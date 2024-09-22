import 'package:uuid/uuid.dart';

class Joueur {
  final String id;
  final String nom;
  final String position;
  final int totalBut;

  Joueur({
    required this.id,
    required this.nom,
    required this.position,
    required this.totalBut,
  });

  // Factory method to create a Joueur object from JSON
  factory Joueur.fromJson(Map<String, dynamic> json) {
    return Joueur(
      id: json['id'] as String,
      nom: json['nom'] as String,
      position: json['position'] as String,
      totalBut: json['totalBut'] as int,
    );
  }

  // Method to convert a Joueur object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'position': position,
      'totalBut': totalBut,
    };
  }
}