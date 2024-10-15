class Membre {
  final String role;
  final String nom;
  final String image;
  final String sport;
  final String id;

  Membre({
    required this.role,
    required this.nom,
    required this.image,
    required this.sport,
    required this.id,
  });

  // Méthode pour convertir l'objet en map (pour Firestore)
  Map<String, dynamic> toJson() {
    return {'role': role, 'nom': nom, 'image': image, 'sport': sport, 'id': id};
  }

  // Méthode pour créer un objet Membre à partir d'un document Firestore
  factory Membre.fromJson(Map<String, dynamic> json) {
    return Membre(
      role: json['role'],
      nom: json['nom'],
      image: json['image'],
      sport: json['sport'],
      id: json['id'],
    );
  }
}
