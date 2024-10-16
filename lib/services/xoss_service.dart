import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/models/utilisateur.dart';
import 'package:new_app/models/xoss.dart';

class XossService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference<Map<String, dynamic>> xossCollection =
      FirebaseFirestore.instance.collection("XOSS");

  Future<List<Xoss>> getAllXoss() async {
    List<Xoss> list = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await xossCollection.get();

      if (querySnapshot.docs.isEmpty) {
        print("Aucun document trouvé dans la collection XOSS.");
      }

      List<Map<String, dynamic>> data = querySnapshot.docs.map((doc) {
        print(
            "Document data: ${doc.data()}"); // Afficher chaque document récupéré
        return doc.data();
      }).toList();

      for (var d in data) {
        try {
          Xoss xoss = Xoss.fromJson(d);
          list.add(xoss);
          print(
              "Xoss ajouté : ${xoss.id}"); // Afficher chaque prêt ajouté à la liste
        } catch (e) {
          print(
              "Erreur lors de la conversion de Xoss : $e"); // Afficher les erreurs de parsing
        }
      }

      return list;
    } catch (e) {
      print("Erreur lors de la récupération des données de Firestore : $e");
      return [];
    }
  }

  Future<List<Xoss>> getAllXossOfUserByEmail(String email) async {
    List<Xoss> list = [];

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await xossCollection
          .where("user.email", isEqualTo: email)
          .orderBy("date", descending: true)
          .get();

      List<Map<String, dynamic>> data =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      for (var d in data) {
        print(d);
        list.add(Xoss.fromJson(d));
      }

      return list;
    } catch (e) {
      return [];
    }
  }

  Future<String> postXoss(Xoss xoss) async {
    try {
      String email = FirebaseAuth.instance.currentUser!.email!;
      // Récupérer l'utilisateur avec l'email
      QuerySnapshot userSnapshot = await _firestore
          .collection("USER")
          .where('email', isEqualTo: email)
          .limit(1)
          .get();
      if (userSnapshot.docs.isEmpty) return "";

      Map<String, dynamic> userData =
          userSnapshot.docs.first.data() as Map<String, dynamic>;

      Utilisateur utilisateur = Utilisateur.fromJson(userData);
      xoss.user = utilisateur;
      await xossCollection.doc(xoss.id).set(xoss.toJson());
      return "OK";
    } catch (e) {
      return "Erreur lors de la création du match : $e";
    }
  }

  Future<Xoss?> getXossId(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await xossCollection.where('id', isEqualTo: id).get();

      if (querySnapshot.docs.isNotEmpty) {
        return Xoss.fromJson(querySnapshot.docs.first.data());
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<Xoss?> updateXoss(String id, String libelle, dynamic value) async {
    try {
      DocumentReference matchDoc = xossCollection.doc(id);
      await matchDoc.update(
        {libelle: value},
      );

      DocumentSnapshot querySnapshot = await matchDoc.get();

      return Xoss.fromJson(querySnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
