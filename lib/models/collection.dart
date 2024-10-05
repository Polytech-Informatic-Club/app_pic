import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_app/models/article_shop.dart';
import 'package:uuid/uuid.dart';

class Commission {
  final String id;
  final String nom;
  final List<ArticleShop> ArticleShops;
  DateTime date;

  Commission(
      {required this.id,
      required this.nom,
      required this.ArticleShops,
      required this.date});

  // Factory method to create an Commission object from JSON
  factory Commission.fromJson(Map<String, dynamic> json) {
    // Parse the 'ArticleShops' list from JSON and map it to a list of ArticleShop objects
    var ArticleShopsFromJson = json['ArticleShops'] as List<dynamic>;
    List<ArticleShop> ArticleShopsList =
        ArticleShopsFromJson.map((item) => ArticleShop.fromJson(item)).toList();

    return Commission(
      id: json['id'] as String,
      nom: json['nom'] as String,
      date: (json['date'] as Timestamp).toDate(),
      ArticleShops: ArticleShopsList,
    );
  }

  // Method to convert an Commission object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'date': date,
      'ArticleShops': ArticleShops.map((ArticleShop) => ArticleShop.toJson())
          .toList(), // Convert list of ArticleShop objects to JSON
    };
  }
}
