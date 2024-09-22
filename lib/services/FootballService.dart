import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class FootballService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Football SERVICE
  Future<List<Map<String, dynamic>>> getFootballList() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection("FOOTBALL").get();
      List<Map<String, dynamic>> FootballList =
          querySnapshot.docs.map((doc) => doc.data()).toList();

      return FootballList;
    } catch (e) {
      return [];
    }
  }

  Future<Map<String, dynamic>?> getFootballById(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection("Football")
          .where("FootballUID", isEqualTo: id)
          .get();
      Map<String, dynamic> football = querySnapshot.docs.first.data();
      return football;
    } catch (e) {
      return {};
    }
  }
}
