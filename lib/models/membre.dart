import 'package:new_app/models/utilisateur.dart';
import 'package:uuid/uuid.dart';

class Membre extends Utilisateur {
  final String id;
  final String poste;

  Membre(
      {required this.id,
      required this.poste,
      required email,
      required prenom,
      required nom})
      : super(email: email, prenom: prenom, nom: nom);

  // Factory method to create a Membre object from JSON
  factory Membre.fromJson(Map<String, dynamic> json) {
    return Membre(
        email: json['email'] as String,
        id: json['id'],
        poste: json['poste'],
        prenom: json['prenom'],
        nom: json['nom'] as String);
  }
  // : id = json['id'] as String,
  //   poste = json['poste'] as String,
  //   // super.fromJson(json);

  // Method to convert a Membre object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'poste': poste,
    };
  }
}
