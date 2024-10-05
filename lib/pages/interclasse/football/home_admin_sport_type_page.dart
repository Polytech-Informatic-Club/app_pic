import 'package:flutter/material.dart';
import 'package:new_app/models/collection.dart';
import 'package:new_app/models/match.dart';
import 'package:new_app/pages/drawer/drawer.dart';
import 'package:new_app/pages/interclasse/create_commission.dart';
import 'package:new_app/pages/interclasse/football/administrate_one_match.dart';
import 'package:new_app/pages/interclasse/football/create_match.dart';
import 'package:new_app/pages/shop/create_article_shop.dart';
import 'package:new_app/services/shop_service.dart';

import 'package:new_app/services/sport_service.dart';
import 'package:new_app/widgets/submited_button.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/widgets/match_card.dart';

// ignore: must_be_immutable
class HomeAdminSportTypePage extends StatelessWidget {
  String typeSport;
  HomeAdminSportTypePage(this.typeSport, {super.key});
  final SportService _sportService = SportService();
  TextEditingController _nomCollectionController = TextEditingController();
  ValueNotifier<List<Collection?>> _collectionProvider = ValueNotifier([]);
  ShopService _shopService = ShopService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: EptDrawer(),
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
            SubmittedButton(
              "Créer une collection",
              () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Nom de la collection"),
                      content: TextField(
                        controller: _nomCollectionController,
                        decoration: InputDecoration(
                            hintText: "Entrer le nom de la collection"),
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
                                date: DateTime.now()));
                            Navigator.pop(context);
                          },
                          child: Text("Confirmer"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            SubmittedButton("Créer un article", () {
              changerPage(context, CreateArticleShop());
            }),
            SizedBox(
              height: 10,
            ),
            SubmittedButton("Créer un match", () {
              changerPage(context, CreateMatch(typeSport));
            }),
            SizedBox(
              height: 10,
            ),
            SubmittedButton("Créer un commission", () {
              changerPage(context, CreateCommission(typeSport));
            }),
            FutureBuilder<List<Matches>>(
                future: _sportService.getListMatchFootball(typeSport),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Erreur lors du chargement');
                  } else {
                    List<Matches> matches = snapshot.data ?? [];
                    return matches.isNotEmpty
                        ? Column(
                            children: [
                              for (var i in matches)
                                Column(
                                  children: [
                                    Text(i.sport.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    buildMatchCard(
                                        context,
                                        i.id,
                                        dateCustomformat(i.date),
                                        i.equipeA.nom,
                                        i.equipeB.nom,
                                        i.scoreEquipeA,
                                        i.scoreEquipeB,
                                        i.equipeA.logo,
                                        i.equipeA.logo,
                                        AdministrateOneFootball(i.id,
                                            i.sport.name.split(".").last)),
                                    SizedBox(height: 8),
                                  ],
                                )
                            ],
                          )
                        : Text("Aucun match à administrer");
                  }
                }),
          ],
        ),
      )),
    );
  }
}

class MemberCard extends StatelessWidget {
  final String title;
  const MemberCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[300],
        ),
        SizedBox(height: 5),
        Text(title),
      ],
    );
  }
}

class MatchCard extends StatelessWidget {
  const MatchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
          'https://example.com/team_logo.png',
          width: 50,
        ),
        title: Text('Mercredi 5 Juin'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('TC2: 430', style: TextStyle(color: Colors.green)),
                Text('TC1: 190', style: TextStyle(color: Colors.red)),
              ],
            ),
            SizedBox(height: 5), // Espace entre les lignes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('DIC1: 400', style: TextStyle(color: Colors.green)),
                Text('DIC2: 190', style: TextStyle(color: Colors.red)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
