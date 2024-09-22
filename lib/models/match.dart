import 'package:new_app/models/commentaires.dart';
import 'package:new_app/models/enums/sport_type.dart';
import 'package:new_app/models/equipe.dart';
import 'package:new_app/models/utilisateur.dart';

class Match {
  final String id;
  final DateTime date;
  final DateTime dateCreation;
  final Equipe equipeA;
  final Equipe equipeB;
  final int scoreEquipeA;
  final int scoreEquipeB;
  final SportType sport;
  final List<Commentaire> comments;
  List<Utilisateur>? likers;
  List<Utilisateur>? dislikers;
  String? partageLien;
  String? description;
  String? photo;

  Match(
      {required this.id,
      required this.date,
      required this.dateCreation,
      required this.equipeA,
      required this.equipeB,
      required this.scoreEquipeA,
      required this.scoreEquipeB,
      required this.sport,
      required this.comments,
      this.likers,
      this.dislikers,
      this.partageLien,
      this.description,
      this.photo});

  // Factory method to create a Match object from JSON
  factory Match.fromJson(Map<String, dynamic> json) {
    var commentsFromJson = json['comments'] as List<dynamic>;
    List<Commentaire> commentsList =
        commentsFromJson.map((item) => Commentaire.fromJson(item)).toList();
    var likersFromJson = json['likers'] as List<dynamic>;
    List<Utilisateur> likersList =
        likersFromJson.map((item) => Utilisateur.fromJson(item)).toList();
    var dislikersFromJson = json['dislikers'] as List<dynamic>;
    List<Utilisateur> dislikersList =
        dislikersFromJson.map((item) => Utilisateur.fromJson(item)).toList();

    return Match(
      id: json['id'] as String,
      dateCreation: json['dateCreation'] as DateTime,
      date: json['date'] as DateTime,
      equipeA: Equipe.fromJson(json['equipeA'] as Map<String, dynamic>),
      equipeB: Equipe.fromJson(json['equipeB'] as Map<String, dynamic>),
      scoreEquipeA: json['scoreEquipeA'] as int,
      scoreEquipeB: json['scoreEquipeB'] as int,
      likers: likersList,
      dislikers: dislikersList,
      sport: SportType.values
          .firstWhere((e) => e.toString() == 'Sport.${json['sport']}'),
      comments: commentsList,
      partageLien: json['partageLien'] as String,
      description: json['description'] as String,
      photo: json['photo'] as String,
    );
  }

  // Method to convert a Match object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateCreation': dateCreation,
      'date': date.toIso8601String(), // Convert DateTime to ISO 8601 string
      'equipeA': equipeA.toJson(),
      'equipeB': equipeB.toJson(),
      'scoreEquipeA': scoreEquipeA,
      'scoreEquipeB': scoreEquipeB,
      'description': description,
      'photo': photo,
      'sport': sport.toString().split('.').last, // Convert enum to string
      'comments': comments.map((comment) => comment.toJson()).toList(),
      'likers': likers!.map((liker) => liker.toJson()).toList(),
      'dislikers': dislikers!.map((disliker) => disliker.toJson()).toList(),
    };
  }
}
