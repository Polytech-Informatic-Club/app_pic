// import 'dart:convert';
// import 'dart:core';

// enum RoleType {
//   ADMIN,
//   USER,
//   ADMIN_FOOTBALL,
//   ADMIN_BASKET,
//   ADMIN_VOLLEY,
//   ADMIN_JEUX_ESPRIT
// }

// class Role {
//   late String id;
//   late RoleType nom;

//   Role({
//     required this.id,
//     required this.nom,
//   });

//   // Convert from JSON
//   Role.fromJson(Map<String, dynamic> json) {
//     id = json["id"] ?? "";
//     nom = RoleType.values.firstWhere(
//       (role) => role.toString() == 'RoleType.${json["nom"]}',
//       orElse: () => RoleType.USER,  // Default value if not found
//     );
//   }

//   // Convert to JSON
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data["id"] = id;
//     data["nom"] = nom.toString().split('.').last; // Store as string
//     return data;
//   }
// }

// class User {
//   late String id;
//   late String username;
//   late String password;
//   late String prenom;
//   late String nom;
//   late String email;
//   late String telephone;
//   late String photo;
//   late String promo;
//   late String notificationToken;
//   late Role role;

//   User({
//     required this.id,
//     required this.username,
//     required this.password,
//     required this.prenom,
//     required this.nom,
//     required this.email,
//     required this.telephone,
//     required this.photo,
//     required this.promo,
//     required this.notificationToken,
//     required this.role,
//   });

//   // Convert from JSON
//   User.fromJson(Map<String, dynamic> json) {
//     id = json["id"] ?? "";
//     username = json["username"] ?? "";
//     password = json["password"] ?? "";
//     prenom = json["prenom"] ?? "";
//     nom = json["nom"] ?? "";
//     email = json["email"] ?? "";
//     telephone = json["telephone"] ?? "";
//     photo = json["photo"] ?? "";
//     promo = json["promo"] ?? "";
//     notificationToken = json["notificationToken"] ?? "";
//     role = Role.fromJson(json["role"] ?? {});
//   }

//   // Convert to JSON
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data["id"] = id;
//     data["username"] = username;
//     data["password"] = password;
//     data["prenom"] = prenom;
//     data["nom"] = nom;
//     data["email"] = email;
//     data["telephone"] = telephone;
//     data["photo"] = photo;
//     data["promo"] = promo;
//     data["notificationToken"] = notificationToken;
//     data["role"] = role.toJson();
//     return data;
//   }
// }
