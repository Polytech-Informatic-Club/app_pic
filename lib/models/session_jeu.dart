import 'package:new_app/models/joueur_jeu.dart';
import 'package:uuid/uuid.dart';

enum StatutSessionJeu { OUVERTE, FERMEE }

class SessionJeu {
  final String id;
  final DateTime date;
  final List<JoueurJeu> joueurs;
  final StatutSessionJeu statut;
  final String lieu;

  SessionJeu({
    required this.id,
    required this.date,
    required this.joueurs,
    required this.statut,
    required this.lieu,
  });

  // Factory method to create a SessionJeu object from JSON
  factory SessionJeu.fromJson(Map<String, dynamic> json) {
    var joueursFromJson = json['joueurs'] as List<dynamic>;
    List<JoueurJeu> joueurList =
        joueursFromJson.map((item) => JoueurJeu.fromJson(item)).toList();

    return SessionJeu(
      id: json['id'] as String,
      lieu: json['lieu'] as String,
      date: DateTime.parse(json['date'] as String),
      joueurs: joueurList,
      statut: StatutSessionJeu.values.firstWhere(
          (e) => e.toString() == 'StatutSessionJeu.${json['statut']}'),
    );
  }

  // Method to convert a SessionJeu object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lieu': lieu,
      'date': date.toIso8601String(),
      'joueurs': joueurs
          .map((joueur) => joueur.toJson())
          .toList(), // Convert list of User objects to JSON
      'statut': statut.toString().split('.').last, // Convert enum to string
    };
  }
}
