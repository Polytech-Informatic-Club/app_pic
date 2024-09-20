import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class BusService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// BUS SERVICE
  Future<List<Map<String, dynamic>>> getBusList() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection("BUS").get();
      List<Map<String, dynamic>> busList =
          querySnapshot.docs.map((doc) => doc.data()).toList();

      return busList;
    } catch (e) {
      return [];
    }
  }

  Future<Map<String, dynamic>?> getBusById(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection("BUS")
          .where("busId", isEqualTo: id)
          .get();
      Map<String, dynamic> publicite = querySnapshot.docs.first.data();
      return publicite;
    } catch (e) {
      return {};
    }
  }


}
