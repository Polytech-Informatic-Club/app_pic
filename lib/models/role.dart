import 'package:uuid/uuid.dart';
import 'package:new_app/models/enums/role_type.dart';

class Role {
  final String id;
  final RoleType nom;

  Role({
    required this.id,
    required this.nom,
  });

  // Factory method to create a Role object from JSON
  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'] as String,
      nom: RoleType.values
          .firstWhere((e) => e.toString() == 'RoleType.${json['nom']}'),
    );
  }

  // Method to convert a Role object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom.toString().split('.').last, // Converts enum to string
    };
  }
}
