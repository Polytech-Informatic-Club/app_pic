import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_app/models/categorie.dart';
import 'package:uuid/uuid.dart';
import 'package:new_app/models/commentaires.dart';

class Annonce {
  final String id;
  final DateTime date;
  final DateTime dateCreation;
  final String description;
  final String titre;
  final String lieu;
  final String image;
  final Categorie categorie;
  final List<Commentaire> comments;
  final int likes;
  final int dislikes;
  final String partageLien; // Link to share the announcement

  Annonce({
    required this.id,
    required this.date,
    required this.dateCreation,
    required this.description,
    required this.titre,
    required this.lieu,
    required this.image,
    required this.categorie,
    required this.comments,
    required this.likes,
    required this.dislikes,
    required this.partageLien,
  });

  // Factory method to create an Annonce object from JSON
  factory Annonce.fromJson(Map<String, dynamic> json) {
    var commentsFromJson = json['comments'] as List<dynamic>;
    List<Commentaire> commentList =
        commentsFromJson.map((item) => Commentaire.fromJson(item)).toList();

    return Annonce(
      id: json['id'] as String,
      date: (json['date'] as Timestamp).toDate(),
      dateCreation: (json['dateCreation'] as Timestamp).toDate(),
      description: json['description'] as String,
      titre: json['titre'] as String,
      lieu: json['lieu'] as String,
      image: json['image'] as String,
      // categorie: Categorie(id: "", logo: "", libelle: ""),
      categorie: Categorie.fromJson(json['categorie']),
      comments: commentList,
      likes: json['likes'] as int,
      dislikes: json['dislikes'] as int,
      partageLien: json['partageLien'] as String,
    );
  }

  // Method to convert an Annonce object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'dateCreation': dateCreation,
      'description': description,
      'titre': titre,
      'lieu': lieu,
      'image': image,
      'categorie': categorie.toJson(),
      'comments': comments
          .map((comment) => comment.toJson())
          .toList(), // Convert list of Commentaire objects to JSON
      'likes': likes,
      'dislikes': dislikes,
      'partageLien': partageLien,
    };
  }

  Annonce copyWith({
    String? id,
    Categorie? categorie,
    String? titre,
    String? description,
    String? lieu,
    DateTime? date,
    DateTime? dateCreation,
    int? likes,
    int? dislikes,
    List<Commentaire>? comments,
    String? image,
    String? partageLien,
  }) {
    return Annonce(
      id: id ?? this.id,
      categorie: categorie ?? this.categorie,
      titre: titre ?? this.titre,
      description: description ?? this.description,
      lieu: lieu ?? this.lieu,
      date: date ?? this.date,
      dateCreation: dateCreation ?? this.dateCreation,
      likes: likes ?? this.likes,
      dislikes: dislikes ?? this.dislikes,
      comments: comments ?? this.comments,
      image: image ?? this.image,
      partageLien: partageLien ?? this.partageLien,
    );
  }
}
