import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_app/models/annonce.dart';
import 'package:new_app/models/categorie.dart';

class AnnonceService {
  CollectionReference<Map<String, dynamic>> annonceCollection =
      FirebaseFirestore.instance.collection("ANNONCE");

  Future<List<Annonce>> getAllAnnonce() async {
    List<Annonce> list = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await annonceCollection.get();

      List<Map<String, dynamic>> data =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      for (var d in data) {
        list.add(Annonce.fromJson(d));
      }

      return list;
    } catch (e) {
      return [];
    }
  }

  Future<String> postAnnonce(Annonce annonce) async {
    try {
      await annonceCollection.doc(annonce.titre).set(annonce.toJson());
      return "OK";
    } catch (e) {
      return "Erreur lors de la création de l'annnonce : $e";
    }
  }

  Future<Annonce?> getAnnonceId(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await annonceCollection.where('id', isEqualTo: id).get();

      if (querySnapshot.docs.isNotEmpty) {
        return Annonce.fromJson(querySnapshot.docs.first.data());
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<Categorie>> getAllCategories() async {
    try {
      List<Categorie> list = [];
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection("CATEGORIE").get();

      List<Map<String, dynamic>> listeCategories =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      for (var categorie in listeCategories) {
        list.add(Categorie.fromJson(categorie));
      }

      return list;
    } catch (e) {
      return [];
    }
  }

  Future<List<Annonce>> getAnnoncesByCategorie(Categorie categorie) async {
    List<Annonce> list = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await annonceCollection
              .where("categorie.id", isEqualTo: categorie.id)
              .get();

      List<Map<String, dynamic>> data =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      for (var d in data) {
        list.add(Annonce.fromJson(d));
      }

      return list;
    } catch (e) {
      return [];
    }
  }

  Future<List<Annonce>> getListEvenements(Categorie categorie) async {
    List<Annonce> list = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await annonceCollection.where("image", isNotEqualTo: "").get();

      List<Map<String, dynamic>> data =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      for (var d in data) {
        list.add(Annonce.fromJson(d));
      }

      return list;
    } catch (e) {
      return [];
    }
  }

  Future<Annonce?> getNextAG() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await annonceCollection
              .where('date', isLessThanOrEqualTo: Timestamp.now())
              .limit(1)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        return Annonce.fromJson(querySnapshot.docs.first.data());
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}