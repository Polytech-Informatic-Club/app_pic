import 'package:uuid/uuid.dart';
import 'package:new_app/models/enums/role_type.dart';

class Utilisateur {
  final String id;
  final String username;
  final String password;
  final String prenom;
  final String nom;
  final String email;
  final String telephone;
  final String photo; // This could be a URL
  final RoleType role;

  Utilisateur({
    required this.id,
    required this.username,
    required this.password,
    required this.prenom,
    required this.nom,
    required this.email,
    required this.telephone,
    required this.photo,
    required this.role,
  });

  // Factory method to create a Utilisateur object from JSON
  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
        id: json['id'] as String,
        username: json['username'] as String,
        password: json['password'] as String,
        prenom: json['prenom'] as String,
        nom: json['nom'] as String,
        email: json['email'] as String,
        telephone: json['telephone'] as String,
        photo: json['photo'] as String,
        role: json['role']
        // role: RoleType.fromJson(json['role'] as Map<String, dynamic>),
        );
  }

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
