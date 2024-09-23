import 'package:new_app/models/utilisateur.dart';
import 'package:uuid/uuid.dart';

class Joueur extends Utilisateur {
  final String id;
  final String position;
  final int totalBut;

  Joueur(
      {required this.id,
      required this.position,
      required this.totalBut,
      required email,
      required prenom,
      required nom})
      : super(email: email, prenom: prenom, nom: nom);

  // Factory method to create a Joueur object from JSON
  factory Joueur.fromJson(Map<String, dynamic> json) {
    return Joueur(
      id: json['id'] as String,
      nom: json['nom'] as String,
      position: json['position'] as String,
      totalBut: json['totalBut'] as int,
      email: json['email'] as String,
      prenom: json['prenom'] as String,
    );
  }

  // Method to convert a Joueur object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'position': position,
      'totalBut': totalBut,
    };
  }
}
