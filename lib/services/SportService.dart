import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:new_app/models/commentaires.dart';
import 'package:new_app/models/equipe.dart';
import 'package:new_app/models/football.dart';
import 'package:new_app/models/match.dart';
import 'package:new_app/models/utilisateur.dart';

class SportService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference footballCollection =
      FirebaseFirestore.instance.collection("MATCH");

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

  Future<String> postFootball(Football football) async {
    try {
      await footballCollection
          .doc(football.equipeA.nom +
              " VS " +
              football.equipeB.nom +
              football.date.toString())
          .set(football.toJson());
      return "OK";
    } catch (e) {
      return "Erreur lors de la création du match : $e";
    }
  }

  Future<List<Matches>> getLastMatch() async {
    List<Matches> list = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection("MATCH")
          .where("date", isLessThanOrEqualTo: Timestamp.now())
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

  Future<Football?> getMatchFootballById(String id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection("MATCH").doc(id).get();
      return Football.fromJson(querySnapshot.data()!);
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
      print("Commen");
      String email = FirebaseAuth.instance.currentUser!.email!;

      // Récupérer l'utilisateur avec l'email
      QuerySnapshot userSnapshot = await _firestore
          .collection("USER")
          .where('email', isEqualTo: email)
          .limit(1)
          .get();
      print("OK2");
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
      print(commentaire);
      await matchDoc.update(
        {
          'comments': FieldValue.arrayUnion([commentaire.toJson()])
        },
      );

      print("OK");
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
      print("remove");

      DocumentReference matchDoc = _firestore.collection("MATCH").doc(matchId);

      await matchDoc.update(
        {
          'comments': FieldValue.arrayRemove([commentaire.toJson()])
        },
      );

      print("OK");
      DocumentSnapshot querySnapshot = await matchDoc.get();

      return Football.fromJson(querySnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print(e);
      return null;
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
