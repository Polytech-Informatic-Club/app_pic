import 'package:new_app/models/membre.dart';
import 'package:uuid/uuid.dart';

class Commission {
  final String id;
  final String nom; // Team name
  final List<Membre> membres; // List of players

  Commission({
    required this.id,
    required this.nom,
    required this.membres,
  });

  // Factory method to create an Commission object from JSON
  factory Commission.fromJson(Map<String, dynamic> json) {
    // Parse the 'membres' list from JSON and map it to a list of membre objects
    var membresFromJson = json['membres'] as List<dynamic>;
    List<Membre> membresList =
        membresFromJson.map((item) => Membre.fromJson(item)).toList();

    return Commission(
      id: json['id'] as String,
      nom: json['nom'] as String,
      membres: membresList,
    );
  }

  // Method to convert an Commission object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'membres': membres
          .map((membre) => membre.toJson())
          .toList(), // Convert list of membre objects to JSON
    };
  }
}
