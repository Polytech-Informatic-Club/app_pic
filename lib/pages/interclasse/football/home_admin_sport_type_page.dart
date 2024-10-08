import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_app/services/user_service.dart';
import 'package:new_app/models/collection.dart';
import 'package:new_app/models/match.dart';
import 'package:new_app/pages/interclasse/football/create_match.dart';
import 'package:new_app/pages/interclasse/create_commission.dart';
import 'package:new_app/pages/shop/create_article_shop.dart';
import 'package:new_app/services/shop_service.dart';
import 'package:new_app/services/sport_service.dart';
import 'package:new_app/widgets/submited_button.dart';
import 'package:new_app/widgets/match_card.dart';

import '../../../fonctions.dart';
import 'administrate_one_match.dart';

class HomeAdminSportTypePage extends StatelessWidget {
  final String typeSport;
  HomeAdminSportTypePage(this.typeSport, {super.key});

  final ShopService _shopService = ShopService();
  final SportService _sportService = SportService();
  final UserService _userService = UserService();
  final TextEditingController _nomCollectionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _userService.getUserByEmail(FirebaseAuth.instance.currentUser!.email!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur de chargement de l\'utilisateur'));
        } else {
          final user = snapshot.data;
          final userRole = user?.role.toString().split(".").last;

          // Vérifie le rôle de l'utilisateur
          if (userRole == "ADMIN_MB") {
            return _buildAdminMBPage(context); // Page complète pour ADMIN_MB
          } else if (userRole == "ADMIN_FOOTBALL") {
            return _buildAdminFootballPage(context); // Page limitée pour ADMIN_FOOTBALL
          } else {
            return _buildAccessDeniedPage(); // Page vierge avec message d'accès refusé
          }
        }
      },
    );
  }

  // Page pour ADMIN_MB (accès à tout)
  Widget _buildAdminMBPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestion $typeSport"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SubmittedButton("Créer une commission", () {
                changerPage(context, CreateCommission(typeSport));
              }),
              SizedBox(height: 10),
              SubmittedButton("Créer une collection", () {
                _showCreateCollectionDialog(context);
              }),
              SizedBox(height: 10),
              SubmittedButton("Créer un article", () {
                changerPage(context, CreateArticleShop());
              }),
              SizedBox(height: 10),
              SubmittedButton("Créer un match", () {
                changerPage(context, CreateMatch(typeSport));
              }),

              _buildMatchList(typeSport),
            ],
          ),
        ),
      ),
    );
  }

  // Page pour ADMIN_FOOTBALL (accès aux matchs seulement)
  Widget _buildAdminFootballPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestion des matchs $typeSport"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SubmittedButton("Créer un match", () {
                changerPage(context, CreateMatch(typeSport));
              }),
              SizedBox(height: 10),
              _buildMatchList(typeSport),
            ],
          ),
        ),
      ),
    );
  }

  // Page vierge avec message d'accès refusé
  Widget _buildAccessDeniedPage() {
    return Scaffold(
      body: Center(
        child: Text("Vous n'avez pas le droit d'accéder à cette page."),
      ),
    );
  }

  void _showCreateCollectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Nom de la collection"),
          content: TextField(
            controller: _nomCollectionController,
            decoration: InputDecoration(hintText: "Entrer le nom de la collection"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Annuler"),
            ),
            TextButton(
              onPressed: () async {
                _shopService.postCollection(Collection(
                  id: DateTime.now().toString(),
                  nom: _nomCollectionController.text,
                  articleShops: [],
                  date: DateTime.now(),
                ));
                Navigator.pop(context);
              },
              child: Text("Confirmer"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMatchList(String typeSport) {
    return FutureBuilder<List<Matches>>(
      future: _sportService.getListMatchFootball(typeSport), // Vérifiez bien cette méthode
      builder: (context, snapshot) {
        // Si en attente de la réponse
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        // En cas d'erreur
        else if (snapshot.hasError) {
          // Ajoutez un message de débogage pour voir l'erreur
          print("Erreur lors de la récupération des matchs : ${snapshot.error}");
          return Text('Erreur lors du chargement des matchs');
        }
        // Une fois les données chargées
        else {
          List<Matches> matches = snapshot.data ?? [];

          // Ajout d'un message de débogage pour vérifier la taille de la liste
          print("Nombre de matchs récupérés : ${matches.length}");

          // Vérifiez si des matchs ont été récupérés
          if (matches.isNotEmpty) {
            return Column(
              children: matches.map((match) {
                // Ajout d'un message de débogage pour voir les détails du match
                print("Match récupéré : ${match.equipeA.nom} vs ${match.equipeB.nom}");

                return buildMatchCard(
                  context,
                  match.id,
                  dateCustomformat(match.date),
                  match.equipeA.nom,
                  match.equipeB.nom,
                  match.scoreEquipeA,
                  match.scoreEquipeB,
                  match.equipeA.logo,
                  match.equipeB.logo,
                  AdministrateOneFootball(match.id, match.sport.name),
                );
              }).toList(),
            );
          } else {
            return Text("Aucun match à administrer");
          }
        }
      },
    );
  }

}
