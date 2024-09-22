import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:new_app/models/equipe.dart';
import 'package:new_app/models/football.dart';
import 'package:new_app/models/match.dart';

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
          .doc(football.date.toString())
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
        print(d);
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
          .limit(2)
          .get();
      List<Map<String, dynamic>> data =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      for (var d in data) {
        print(d);
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
