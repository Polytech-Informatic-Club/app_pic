class BusModel {
  final String nom;
  final Position currentPosition;
  final int lastUpdateTime;

  BusModel({
    required this.nom,
    required this.currentPosition,
    required this.lastUpdateTime,
  });
}

class Position {
  final double latitude;
  final double longitude;

  Position({
    required this.latitude,
    required this.longitude,
  });
}
