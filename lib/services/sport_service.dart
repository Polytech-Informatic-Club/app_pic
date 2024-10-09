import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_app/models/basket.dart';
import 'package:new_app/models/buteur.dart';
import 'package:new_app/models/commentaires.dart';
import 'package:new_app/models/commission.dart';
import 'package:new_app/models/enums/sport_type.dart';
import 'package:new_app/models/equipe.dart';
import 'package:new_app/models/football.dart';
import 'package:new_app/models/jeux_esprit.dart';
import 'package:new_app/models/joueur.dart';
import 'package:new_app/models/match.dart';
import 'package:new_app/models/utilisateur.dart';
import 'package:new_app/models/volleyball.dart';
import 'package:new_app/services/notification_service.dart';

class SportService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference footballCollection =
      FirebaseFirestore.instance.collection("MATCH");

  CollectionReference commissionCollection =
      FirebaseFirestore.instance.collection("COMMISSION");

  CollectionReference tokenCollection =
      FirebaseFirestore.instance.collection("TOKEN");

// Football SERVICE
  Future<List<Equipe>> getEquipeList() async {
    try {
      List<Equipe> list = [];
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection("EQUIPE").get();
      List<Map<String, dynamic>> listeEquipes =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      for (var equipe in listeEquipes) {
        list.add(Equipe.fromJson(equipe));
      }
      return list;
    } catch (e) {
      return [];
    }
  }

  Future<String> postFootball(dynamic football) async {
    try {
      await footballCollection
          .doc(football.equipeA.nom +
              " VS " +
              football.equipeB.nom +
              football.date.toString())
          .set(football.toJson());

      // var tokensSnapshot = await tokenCollection.get();
      // List<String> tokens = tokensSnapshot.docs
      //     .map((doc) => doc['token'])
      //     .toList() as List<String>;

      String token =
          "cz3LdrHWTfi7kVAPdciW27:APA91bEVGqT7Ru6lsRKLLNrhZ82MWrgSaVKLNRBykhpIdZETs8UH13lEdUtvezqB27CteMn9qBqg3hQ6GZrVNeMCTzuXNmKHh2s9mI19-DiJ_L_CjMevR7tMqsnqY9tXigXqMbpJV6PP";
      // for (var token in tokens) {
      sendPushMessage(token, "Un nouveau match bla bla", "Un nouveau match");
      // }

      return "OK";
    } catch (e) {
      return "Erreur lors de la création du match : $e";
    }
  }

  Future<String> removeMatch(String id) async {
    try {
      await _firestore.collection("MATCH").doc(id).delete();

      return "ok";
    } catch (e) {
      return "Erreur : $e";
    }
  }

  Future<List<Matches>> getLastMatch() async {
    List<Matches> list = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection("MATCH")
          .where("date", isLessThanOrEqualTo: Timestamp.now())
          .orderBy("date", descending: true)
          .limit(2)
          .get();
      List<Map<String, dynamic>> data =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      for (var d in data) {
        list.add(Matches.fromJson(d));
      }

      return list;
    } catch (e) {
      return [];
    }
  }

  Future<List<Matches>> getNextMatch() async {
    List<Matches> list = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection("MATCH")
          .where("date", isGreaterThanOrEqualTo: Timestamp.now())
          .limit(5)
          .get();
      List<Map<String, dynamic>> data =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      for (var d in data) {
        list.add(Matches.fromJson(d));
      }

      return list;
    } catch (e) {
      return [];
    }
  }

  Future<Matches?> getTheFollowingMatch(String typeSport) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection("MATCH")
          .where("date", isGreaterThanOrEqualTo: Timestamp.now())
          .where("sport", isEqualTo: typeSport)
          .orderBy('date', descending: true)
          .limit(1)
          .get();
      return Matches.fromJson(querySnapshot.docs.first.data());
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> getMatchById(String id, String typeSport) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection("MATCH").doc(id).get();
      return typeSport == "BASKETBALL"
          ? Basket.fromJson(querySnapshot.data()!)
          : typeSport == "FOOTBALL"
              ? Football.fromJson(querySnapshot.data()!)
              : typeSport == "VOLLEYBALL"
                  ? Volleyball.fromJson(querySnapshot.data()!)
                  : typeSport == "JEUX_ESPRIT"
                      ? JeuxEsprit.fromJson(querySnapshot.data()!)
                      : null;
    } catch (e) {
      return null;
    }
  }

  Future<Football?> likerMatch(
    String matchId,
  ) async {
    try {
      String email = FirebaseAuth.instance.currentUser!.email!;

      // Récupérer l'utilisateur avec l'email
      QuerySnapshot userSnapshot = await _firestore
          .collection("USER")
          .where('email', isEqualTo: email)
          .limit(1)
          .get();
      if (userSnapshot.docs.isEmpty) return null;

      Map<String, dynamic> userData =
          userSnapshot.docs.first.data() as Map<String, dynamic>;

      DocumentReference matchDoc = _firestore.collection("MATCH").doc(matchId);

      await matchDoc.update(
        {
          'likers': FieldValue.arrayUnion([userData])
        },
      );

      DocumentSnapshot querySnapshot = await matchDoc.get();

      return Football.fromJson(querySnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Football?> removeLikeMatch(String matchId) async {
    try {
      String email = FirebaseAuth.instance.currentUser!.email!;

      // Récupérer l'utilisateur avec l'email
      QuerySnapshot userSnapshot = await _firestore
          .collection("USER")
          .where('email', isEqualTo: email)
          .limit(1)
          .get();
      print(userSnapshot);
      if (userSnapshot.docs.isEmpty) return null;

      Map<String, dynamic> userData =
          userSnapshot.docs.first.data() as Map<String, dynamic>;

      DocumentReference matchDoc = _firestore.collection("MATCH").doc(matchId);

      await matchDoc.update(
        {
          'likers': FieldValue.arrayRemove([userData])
        },
      );

      DocumentSnapshot querySnapshot = await matchDoc.get();

      return Football.fromJson(querySnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Football?> addCommentMatch(String matchId, String content) async {
    try {
      String email = FirebaseAuth.instance.currentUser!.email!;

      // Récupérer l'utilisateur avec l'email
      QuerySnapshot userSnapshot = await _firestore
          .collection("USER")
          .where('email', isEqualTo: email)
          .limit(1)
          .get();
      if (userSnapshot.docs.isEmpty) return null;

      Map<String, dynamic> userData =
          userSnapshot.docs.first.data() as Map<String, dynamic>;

      DocumentReference matchDoc = _firestore.collection("MATCH").doc(matchId);

      Commentaire commentaire = Commentaire(
          id: DateTime.now().toString(),
          content: content,
          date: DateTime.now(),
          user: Utilisateur.fromJson(userData),
          likes: 0,
          dislikes: 0);
      await matchDoc.update(
        {
          'comments': FieldValue.arrayUnion([commentaire.toJson()])
        },
      );

      DocumentSnapshot querySnapshot = await matchDoc.get();

      return Football.fromJson(querySnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Football?> removeCommentMatch(
      String matchId, Commentaire commentaire) async {
    try {
      DocumentReference matchDoc = _firestore.collection("MATCH").doc(matchId);

      await matchDoc.update(
        {
          'comments': FieldValue.arrayRemove([commentaire.toJson()])
        },
      );

      DocumentSnapshot querySnapshot = await matchDoc.get();

      return Football.fromJson(querySnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Football?> updateStatistique(
      String matchId, String libelle, int value) async {
    try {
      DocumentReference matchDoc = _firestore.collection("MATCH").doc(matchId);
      await matchDoc.update(
        {"statistiques.$libelle": FieldValue.increment(value)},
      );

      DocumentSnapshot querySnapshot = await matchDoc.get();

      return Football.fromJson(querySnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Football?> addButeur(String matchId, Joueur joueur, int minute,
      String libelleScore, String libelleBut,
      [int increment = 1]) async {
    try {
      DocumentReference matchDoc = _firestore.collection("MATCH").doc(matchId);
      But but = But(
          joueur: joueur,
          id: DateTime.now().toString(),
          date: DateTime.now(),
          minute: minute);
      await matchDoc.update(
        {
          libelleBut: FieldValue.arrayUnion([but.toJson()]),
          libelleScore: FieldValue.increment(increment)
        },
      );

      DocumentSnapshot querySnapshot = await matchDoc.get();
      print(querySnapshot.data());

      return Football.fromJson(querySnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Matches>> getListMatchFootball(String typeSport) async {
    List<Matches> list = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection("MATCH")
          .where("sport", isEqualTo: typeSport)
          // .limit(2)
          .get();
      List<Map<String, dynamic>> data =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      for (var d in data) {
        list.add(Matches.fromJson(d));
      }

      return list;
    } catch (e) {
      return [];
    }
  }

  Future<Commission?> getMembresCommission(String libelle) async {
    try {
      QuerySnapshot<Map<String, dynamic>> filteredSnapshot = await _firestore
          .collection("COMMISSION")
          .where("nom", isEqualTo: libelle)
          .limit(1)
          .get();

      if (filteredSnapshot.docs.isEmpty) {
        return null;
      }
      var data = filteredSnapshot.docs.first.data();
      return Commission.fromJson(data);
    } catch (e) {
      print("Erreur: $e");
      return null;
    }
  }

  Future<String> postCommission(Commission commission) async {
    try {
      await commissionCollection.doc(commission.nom).set(commission.toJson());
      return "OK";
    } catch (e) {
      return "Erreur lors de la création du match : $e";
    }
  }

  Future<List<Matches>> getAllMatch() async {
    List<Matches> list = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection("MATCH")
          .orderBy("date", descending: true)
          .get();
      List<Map<String, dynamic>> data =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      for (var d in data) {
        list.add(Matches.fromJson(d));
      }

      return list;
    } catch (e) {
      return [];
    }
  }

  Future<Map<String, dynamic>?> getFootballById(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection("MATCH").where("id", isEqualTo: id).get();
      Map<String, dynamic> football = querySnapshot.docs.first.data();
      return football;
    } catch (e) {
      return {};
    }
  }
}
