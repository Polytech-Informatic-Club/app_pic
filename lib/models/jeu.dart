import 'package:uuid/uuid.dart';
import 'session_jeu.dart'; // Import SessionJeu class

class Jeu {
  final String id;
  final String nom;
  final int joueursEnAttente;
  final List<SessionJeu> sessions;

  Jeu({
    required this.id,
    required this.nom,
    required this.joueursEnAttente,
    required this.sessions,
  });

  // Factory method to create a Jeu object from JSON
  factory Jeu.fromJson(Map<String, dynamic> json) {
    var sessionsFromJson = json['sessions'] as List<dynamic>;
    List<SessionJeu> sessionList = sessionsFromJson.map((item) => SessionJeu.fromJson(item)).toList();

    return Jeu(
      id: json['id'] as String,
      nom: json['nom'] as String,
      joueursEnAttente: json['joueursEnAttente'] as int,
      sessions: sessionList,
    );
  }

  // Method to convert a Jeu object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'joueursEnAttente': joueursEnAttente,
      'sessions': sessions.map((session) => session.toJson()).toList(), // Convert list of SessionJeu objects to JSON
    };
  }
}