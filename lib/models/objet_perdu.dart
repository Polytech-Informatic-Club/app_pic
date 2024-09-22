import 'package:uuid/uuid.dart';
import 'user.dart';
import 'package:new_app/models/enums/statut_objet_perdu.dart';

class ObjetPerdu {
  final String id; // UUID
  final String description; // Description of the lost object
  final String lieu; // Place where the object was lost
  final DateTime date; // Date when the object was lost
  final Etat etat; // Status of the object (PERDU or RETROUVE)
  final User user; // The user who lost the object

  ObjetPerdu({
    required this.id,
    required this.description,
    required this.lieu,
    required this.date,
    required this.etat,
    required this.user,
  });

  // Factory method to create an ObjetPerdu object from JSON
  factory ObjetPerdu.fromJson(Map<String, dynamic> json) {
    return ObjetPerdu(
      id: json['id'] as String,
      description: json['description'] as String,
      lieu: json['lieu'] as String,
      date: DateTime.parse(json['date'] as String),
      etat: Etat.values.firstWhere((e) => e.toString() == 'Etat.${json['etat']}'),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'lieu': lieu,
      'date': date.toIso8601String(),
      'etat': etat.toString().split('.').last, // Convert enum to string
      'user': user.toJson(),
    };
  }
}