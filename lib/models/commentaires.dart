import 'package:new_app/models/utilisateur.dart';

class Commentaire {
  final String id;
  final String content;
  final DateTime date;
  final Utilisateur user;
  final int likes;
  final int dislikes;

  Commentaire(
      {required this.id,
      required this.content,
      required this.date,
      required this.user,
      required this.likes,
      required this.dislikes});

  factory Commentaire.fromJson(Map<String, dynamic> json) {
    return Commentaire(
        id: json['id'] as String,
        content: json['content'] as String,
        date: json['date'] as DateTime,
        user: json['user'] as Utilisateur,
        likes: json['likes'] as int,
        dislikes: json['dislikes'] as int);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'date': date,
      'user': user,
      'likes': likes,
      'dislikes': dislikes
    };
  }
}
