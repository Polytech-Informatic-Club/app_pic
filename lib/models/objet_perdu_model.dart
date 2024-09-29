import 'package:uuid/uuid.dart';
import 'utilisateur.dart';
import 'package:new_app/models/enums/statut_objet_perdu.dart';

class ObjetPerdu {
  final String description; // Description of the lost object
  final String? photoURL;
  final String lieu; // Place where the object was lost
  final DateTime date; // Date when the object was lost
  final int estTrouve; // Status of the object (PERDU or RETROUVE)
  final Map<String, dynamic> user; // celui qui a signalé l'objet perdu

  ObjetPerdu({
    required this.description,
    required this.photoURL,
    required this.lieu,
    required this.date,
    required this.estTrouve,
    required this.user
  });

  // Factory method to create an ObjetPerdu object from JSON
  factory ObjetPerdu.fromJson(Map<String, dynamic> json) {
    return ObjetPerdu(
      description: json['description'] as String,
      photoURL: json['photoURL'] as String,
      lieu: json['lieu'] as String,
      date: DateTime.parse(json['date'] as String),
      estTrouve: json['etat'] as int,
      user: json['user'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'photoURL': photoURL,
      'lieu': lieu,
      'date': date.toIso8601String(),
      'etat': estTrouve.toString(),
      'user': user,
    };
  }
}
