import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_app/models/utilisateur.dart';

class Commande {
  String id;
  String produit;
  DateTime date;
  Utilisateur user;
  int nombre;

  Commande({
    required this.id,
    required this.produit,
    required this.date,
    required this.user,
    required this.nombre,
  });

  factory Commande.fromJson(Map<String, dynamic> json) {
    return Commande(
      id: json['id'] as String,
      produit: json['produit'] as String,
      date: (json['date'] as Timestamp).toDate(),
      user: Utilisateur.fromJson(json['user']),
      nombre: json['nombre'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'produit': produit,
      'date': date,
      'user': user.toJson(),
      'nombre': nombre,
    };
  }
}
