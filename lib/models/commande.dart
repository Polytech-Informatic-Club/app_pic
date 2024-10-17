import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_app/models/utilisateur.dart';

class Commande {
  String id;
  String produitId;
  DateTime date;
  String userId;
  int nombre;

  Commande({
    required this.id,
    required this.produitId,
    required this.date,
    required this.userId,
    required this.nombre,
  });

  factory Commande.fromJson(Map<String, dynamic> json) {
    print(json);
    return Commande(
      id: json['id'] as String,
      produitId: json['produitId'] as String,
      date: (json['date'] as Timestamp).toDate(),
      userId: json['userId'] as String,
      nombre: json['nombre'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'produitId': produitId,
      'date': date,
      'userId': userId,
      'nombre': nombre,
    };
  }
}
