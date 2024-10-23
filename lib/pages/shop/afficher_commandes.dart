import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_app/models/commande.dart';
import 'package:new_app/models/article_shop.dart';
import 'package:new_app/models/utilisateur.dart';
import 'package:new_app/utils/app_colors.dart';

class CommandeListPage extends StatefulWidget {
  @override
  _CommandeListPageState createState() => _CommandeListPageState();
}

class _CommandeListPageState extends State<CommandeListPage> {
  final CollectionReference _commandeCollection =
      FirebaseFirestore.instance.collection('COMMANDE');
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('USER');
  final CollectionReference _articleCollection =
      FirebaseFirestore.instance.collection('ARTICLE');

  // Stockage des commandes avec les informations supplémentaires
  List<Map<String, dynamic>> _commandesWithDetails = [];

  @override
  void initState() {
    super.initState();
    _loadCommandes();
  }

  Future<void> _loadCommandes() async {
    QuerySnapshot commandeSnapshot = await _commandeCollection.get();

    List<Map<String, dynamic>> commandesTemp = [];

    for (var doc in commandeSnapshot.docs) {
      Commande commande = Commande.fromJson(doc.data() as Map<String, dynamic>);

      // Récupérer l'utilisateur (nom et prénom)
      DocumentSnapshot userSnapshot =
          await _userCollection.doc(commande.userId).get();
      Utilisateur utilisateur =
          Utilisateur.fromJson(userSnapshot.data() as Map<String, dynamic>);

      // Récupérer l'article (libelle)
      DocumentSnapshot articleSnapshot =
          await _articleCollection.doc(commande.produitId).get();
      ArticleShop article =
          ArticleShop.fromJson(articleSnapshot.data() as Map<String, dynamic>);

      // Ajouter les données au tableau temporaire
      commandesTemp.add({
        'commande': commande,
        'prenom': utilisateur.prenom,
        'nom': utilisateur.nom,
        'libelle': article.titre,
      });
    }

    // Mettre à jour l'état avec les données chargées
    setState(() {
      _commandesWithDetails = commandesTemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des Commandes"),
        backgroundColor: AppColors.primary,
      ),
      body: _commandesWithDetails.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _commandesWithDetails.length,
              itemBuilder: (context, index) {
                var commandeData = _commandesWithDetails[index];
                Commande commande = commandeData['commande'];
                String prenom = commandeData['prenom'];
                String nom = commandeData['nom'];
                String libelle = commandeData['libelle'];

                return ListTile(
                  title: Text("Commande de $prenom $nom"),
                  subtitle: Text(
                      "Article: $libelle\nQuantité: ${commande.nombre}\nDate: ${commande.date.toString()}"),
                );
              },
            ),
    );
  }
}
