import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_app/models/commentaires.dart';
import 'package:new_app/models/enums/sport_type.dart';
import 'package:new_app/models/equipe.dart';
import 'package:new_app/models/joueur.dart';
import 'package:new_app/models/match.dart';
import 'package:new_app/models/utilisateur.dart';

class Football extends Matches {
  final List<Joueur>? buteurs;
  final Map<String, int> statistiques;

  Football(
      {this.buteurs,
      required this.statistiques,
      required String id,
      required DateTime date,
      dateCreation,
      description,
      photo,
      required Equipe equipeA,
      required Equipe equipeB,
      required int scoreEquipeA,
      required int scoreEquipeB,
      required SportType sport,
      required List<Commentaire> comments,
      required List<Utilisateur> likers,
      required List<Utilisateur> dislikers,
      required String partageLien})
      : super(
            id: id,
            date: date,
            dateCreation: dateCreation,
            equipeA: equipeA,
            equipeB: equipeB,
            scoreEquipeA: scoreEquipeA,
            scoreEquipeB: scoreEquipeB,
            sport: sport,
            comments: comments,
            likers: likers,
            dislikers: dislikers,
            partageLien: partageLien,
            description: description,
            photo: photo);

  Football.fromJson(Map<String, dynamic> json)
      : buteurs = (json['buteurs'] as List<dynamic>?)
            ?.map((item) => Joueur.fromJson(item))
            .toList(),
        statistiques = Map<String, int>.from(json['statistiques']),
        super.fromJson(json);

  // factory Football.fromJson(Map<String, dynamic> json) {
  //   return Football(
  //       buteurs: (json['buteurs'] as List<dynamic>?)
  //           ?.map((item) => Joueur.fromJson(item))
  //           .toList(),
  //       statistiques: Map<String, int>.from(json['statistiques']),
  //       id: json['id'],
  //       date: (json['date'] as Timestamp).toDate(),
  //       dateCreation: (json['dateCreation'] as Timestamp).toDate(),
  //       description: json['description'],
  //       photo: json['photo'],
  //       equipeA: Equipe.fromJson(json['equipeA']),
  //       equipeB: Equipe.fromJson(json['equipeB']),
  //       scoreEquipeA: json['scoreEquipeA'],
  //       scoreEquipeB: json['scoreEquipeB'],
  //       sport: SportType.values
  //           .firstWhere((e) => e.toString().split('.').last == json['sport']),
  //       comments: (json['comments'] as List<dynamic>)
  //           .map((comment) => Commentaire.fromJson(comment))
  //           .toList(),
  //       likers: (json['likers'] as List<dynamic>)
  //           .map((liker) => Utilisateur.fromJson(liker))
  //           .toList(),
  //       dislikers: (json['dislikers'] as List<dynamic>)
  //           .map((disliker) => Utilisateur.fromJson(disliker))
  //           .toList(),
  //       partageLien: json['partageLien']);
  // }

  Map<String, dynamic> toJson() {
    final data = super.toJson(); // Appelle le toJson() de Matches
    data['buteurs'] = buteurs?.map((buteur) => buteur.toJson()).toList();
    data['statistiques'] = statistiques;
    return data;
  }
}
