import 'package:uuid/uuid.dart';

class CategorieShop {
  final String id;
  final String libelle;
  final String logo;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategorieShop &&
          runtimeType == other.runtimeType &&
          id == other.id;

  // Implémentation de hashCode
  @override
  int get hashCode => id.hashCode;

  CategorieShop({
    required this.id,
    required this.libelle,
    required this.logo,
  });

  // Factory method to create a CategorieShop object from JSON
  factory CategorieShop.fromJson(Map<String, dynamic> json) {
    return CategorieShop(
      id: json['id'] as String,
      libelle: json['libelle'] as String,
      logo: json['logo'] as String,
    );
  }

  // Method to convert a CategorieShop object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'libelle': libelle,
      'logo': logo,
    };
  }
}
