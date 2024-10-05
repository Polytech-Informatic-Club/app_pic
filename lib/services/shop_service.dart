import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/models/article_shop.dart';
import 'package:new_app/models/categorie_shop.dart';
import 'package:new_app/models/collection.dart';
import 'package:new_app/models/utilisateur.dart';

class ShopService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference<Map<String, dynamic>> collectionCollection =
      FirebaseFirestore.instance.collection("COLLECTION");

  CollectionReference<Map<String, dynamic>> articleCollection =
      FirebaseFirestore.instance.collection("ARTICLE");

  CollectionReference<Map<String, dynamic>> categorieShopCollection =
      FirebaseFirestore.instance.collection("CATEGORIESHOP");

  Future<List<Collection>> getAllCollection() async {
    List<Collection> list = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await collectionCollection.get();

      List<Map<String, dynamic>> data =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      for (var d in data) {
        list.add(Collection.fromJson(d));
      }

      return list;
    } catch (e) {
      return [];
    }
  }
  Future<Collection?> getNewCollection() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await collectionCollection.get();

      Map<String, dynamic> data =
          querySnapshot.docs.map((doc) => doc.data()).first;
    

      return Collection.fromJson(data);
    } catch (e) {
      return null;
    }
  }

  Future<List<CategorieShop>> getAllCategorieShop() async {
    List<CategorieShop> list = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await categorieShopCollection.get();

      List<Map<String, dynamic>> data =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      for (var d in data) {
        print(d);
        list.add(CategorieShop.fromJson(d));
      }

      return list;
    } catch (e) {
      return [];
    }
  }

  Future<List<Collection>> getAllShopOfUserByEmail(String email) async {
    List<Collection> list = [];

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await collectionCollection
              .where("user.email", isEqualTo: email)
              .orderBy("date", descending: true)
              .get();

      List<Map<String, dynamic>> data =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      for (var d in data) {
        print(d);
        list.add(Collection.fromJson(d));
      }

      return list;
    } catch (e) {
      return [];
    }
  }

  Future<String> postCollection(Collection collection) async {
    try {
      await collectionCollection.doc(collection.id).set(collection.toJson());
      return "OK";
    } catch (e) {
      return "Erreur lors de la création de collection : $e";
    }
  }

  Future<String> postArticleShop(
      ArticleShop article, Collection collection) async {
    try {
      await articleCollection.doc(article.id).set(article.toJson());
      await collectionCollection.doc(collection.id).update({
        "articleShops": FieldValue.arrayUnion([article.toJson()])
      });
      return "OK";
    } catch (e) {
      return "Erreur lors de la création de l'article : $e";
    }
  }

  // Future<String> postShop(Collection collection) async {
  //   try {
  //     String email = FirebaseAuth.instance.currentUser!.email!;
  //     // Récupérer l'utilisateur avec l'email
  //     QuerySnapshot userSnapshot = await _firestore
  //         .collection("USER")
  //         .where('email', isEqualTo: email)
  //         .limit(1)
  //         .get();
  //     if (userSnapshot.docs.isEmpty) return "";
  //     Map<String, dynamic> userData =
  //         userSnapshot.docs.first.data() as Map<String, dynamic>;
  //     Utilisateur utilisateur = Utilisateur.fromJson(userData);
  //     Shop.user = utilisateur;
  //     await ShopCollection.doc(Shop.id).set(Shop.toJson());
  //     return "OK";
  //   } catch (e) {
  //     return "Erreur lors de la création du match : $e";
  //   }
  // }

  Future<Collection?> getCollectionId(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await collectionCollection.where('id', isEqualTo: id).get();

      if (querySnapshot.docs.isNotEmpty) {
        return Collection.fromJson(querySnapshot.docs.first.data());
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<Collection?> updateShop(
      String id, String libelle, dynamic value) async {
    try {
      DocumentReference matchDoc = collectionCollection.doc(id);
      await matchDoc.update(
        {libelle: value},
      );

      DocumentSnapshot querySnapshot = await matchDoc.get();

      return Collection.fromJson(querySnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
