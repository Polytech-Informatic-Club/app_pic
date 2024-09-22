import 'package:uuid/uuid.dart';

class Membre {
  final String id;
  final String nom;
  final String poste;

  Membre({
    required this.id,
    required this.nom,
    required this.poste,
  });

  // Factory method to create a Membre object from JSON
  factory Membre.fromJson(Map<String, dynamic> json) {
    return Membre(
      id: json['id'] as String,
      nom: json['nom'] as String,
      poste: json['poste'] as String,
    );
  }

  // Method to convert a Membre object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'poste': poste,
    };
  }
}
