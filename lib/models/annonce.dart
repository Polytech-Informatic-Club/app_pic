import 'package:uuid/uuid.dart';
import 'package:new_app/models/commentaires.dart';

class Annonce {
  final String id;
  final DateTime date;
  final String description;
  final String titre;
  final String image;
  final List<Commentaire> comments;
  final int likes;
  final int dislikes;
  final String partageLien; // Link to share the announcement

  Annonce({
    required this.id,
    required this.date,
    required this.description,
    required this.titre,
    required this.image,
    required this.comments,
    required this.likes,
    required this.dislikes,
    required this.partageLien,
  });

  // Factory method to create an Annonce object from JSON
  factory Annonce.fromJson(Map<String, dynamic> json) {
    var commentsFromJson = json['comments'] as List<dynamic>;
    List<Commentaire> commentList = commentsFromJson.map((item) => Commentaire.fromJson(item)).toList();

    return Annonce(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      description: json['description'] as String,
      titre: json['titre'] as String,
      image: json['image'] as String,
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
      'date': date.toIso8601String(),
      'description': description,
      'titre': titre,
      'image': image,
      'comments': comments.map((comment) => comment.toJson()).toList(), // Convert list of Commentaire objects to JSON
      'likes': likes,
      'dislikes': dislikes,
      'partageLien': partageLien,
    };
  }
}