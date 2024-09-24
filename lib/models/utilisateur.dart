import 'package:uuid/uuid.dart';
import 'package:new_app/models/enums/role_type.dart';

class Utilisateur {
  final String? id;
  final String? username;
  final String? password;
  final String prenom; // Obligatoire
  final String nom; // Obligatoire
  final String email; // Obligatoire
  final String? telephone;
  final String? photo; // This could be a URL
  final RoleType? role;

  Utilisateur({
    this.id,
    this.username,
    this.password,
    required this.prenom,
    required this.nom,
    required this.email,
    this.telephone,
    this.photo,
    this.role,
  });

  // Factory method to create a Utilisateur object from JSON
  Utilisateur.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        username = json['username'] as String,
        password = json['password'] as String,
        prenom = json['prenom'] as String,
        nom = json['nom'] as String,
        email = json['email'] as String,
        telephone = json['telephone'] as String,
        photo = json['photo'] as String,
        role = RoleType.values.firstWhere(
          (e) => e.toString().split('.').last == json['role'],
        );

  // Method to convert a Utilisateur object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'prenom': prenom,
      'nom': nom,
      'email': email,
      'telephone': telephone,
      'photo': photo,
      'role': role.toString().split('.').last
      // 'role': role.toJson(), // Converts enum to string
    };
  }
}
