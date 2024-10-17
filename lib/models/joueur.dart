import 'package:new_app/models/utilisateur.dart';

class Joueur {
  final String id;
  final String prenom;
  final String nom;
  final String position;
  final int totalBut;

  Joueur({
    required this.id,
    required this.prenom,
    required this.nom,
    required this.position,
    required this.totalBut,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'prenom': prenom,
      'nom': nom,
      'position': position,
      'totalBut': totalBut,
    };
  }

  factory Joueur.fromJson(Map<String, dynamic> json) {
    return Joueur(
      id: json['id'],
      prenom: json['prenom'],
      nom: json['nom'],
      position: json['position'],
      totalBut: json['totalBut'],
    );
  }
}
