import 'package:new_app/models/commentaires.dart';
import 'package:new_app/models/enums/sport_type.dart';
import 'package:new_app/models/equipe.dart';

class Match {
  final String id;
  final DateTime date;
  final Equipe equipeA;
  final Equipe equipeB;
  final int scoreEquipeA;
  final int scoreEquipeB;
  final SportType sport;
  final List<Commentaire> comments;
  final int likes;
  final int dislikes;
  final String partageLien;

  Match({
    required this.id,
    required this.date,
    required this.equipeA,
    required this.equipeB,
    required this.scoreEquipeA,
    required this.scoreEquipeB,
    required this.sport,
    required this.comments,
    required this.likes,
    required this.dislikes,
    required this.partageLien
  });

  // Factory method to create a Match object from JSON
  factory Match.fromJson(Map<String, dynamic> json) {
    var commentsFromJson = json['comments'] as List<dynamic>;
    List<Commentaire> commentsList = commentsFromJson.map((item) => Commentaire.fromJson(item)).toList();

    return Match(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      equipeA: Equipe.fromJson(json['equipeA'] as Map<String, dynamic>),
      equipeB: Equipe.fromJson(json['equipeB'] as Map<String, dynamic>),
      scoreEquipeA: json['scoreEquipeA'] as int,
      scoreEquipeB: json['scoreEquipeB'] as int,
      likes: json['likes'] as int,
      dislikes: json['dislikes'] as int,
      sport: SportType.values.firstWhere((e) => e.toString() == 'Sport.${json['sport']}'),
      comments: commentsList,
      partageLien: json['partageLien'] as String
    );
  }

  // Method to convert a Match object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(), // Convert DateTime to ISO 8601 string
      'equipeA': equipeA.toJson(),
      'equipeB': equipeB.toJson(),
      'scoreEquipeA': scoreEquipeA,
      'scoreEquipeB': scoreEquipeB,
      'sport': sport.toString().split('.').last, // Convert enum to string
      'comments': comments.map((comment) => comment.toJson()).toList(), // Convert list of Commentaire objects to JSON
    };
  }
}