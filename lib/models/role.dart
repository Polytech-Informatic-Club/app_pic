import 'package:uuid/uuid.dart';
import 'package:new_app/models/enums/role_type.dart';
// enum RoleType {
//   ADMIN,
//   USER,
//   ADMIN_FOOTBALL,
//   ADMIN_BASKET,
//   ADMIN_VOLLEY,
//   ADMIN_JEUX_ESPRIT
// }

// class Role {
//   final RoleType nom;

//   Role({
//     required this.nom,
//   });

//   // Factory method to create a Role object from JSON
//   factory Role.fromJson(Map<String, dynamic> json) {
//     return Role(
//       nom: RoleType.values.firstWhere((e) => e.toString() == 'RoleType.${json['nom']}'),
//     );
//   }

//   // Method to convert a Role object to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'nom': nom.toString().split('.').last, // Converts enum to string
//     };
//   }
// }