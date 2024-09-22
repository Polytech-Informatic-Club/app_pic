import 'package:uuid/uuid.dart';
import 'package:new_app/models/enums/role_type.dart';
import 'package:new_app/models/role.dart';

class User {
  final String id;
  final String username;
  final String password;
  final String prenom;
  final String nom;
  final String email;
  final String telephone;
  final String photo; // This could be a URL
  final Role role;

  User({
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

  // Factory method to create a User object from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      prenom: json['prenom'] as String,
      nom: json['nom'] as String,
      email: json['email'] as String,
      telephone: json['telephone'] as String,
      photo: json['photo'] as String,
      role: Role.fromJson(json['role'] as Map<String, dynamic>),
    );
  }

  // Method to convert a User object to JSON
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
      'role': role.toString().split('.').last, // Converts enum to string
    };
  }
}