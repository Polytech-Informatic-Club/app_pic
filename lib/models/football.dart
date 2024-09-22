import 'package:new_app/models/commentaires.dart';
import 'package:new_app/models/enums/sport_type.dart';
import 'package:new_app/models/equipe.dart';
import 'package:new_app/models/joueur.dart';
import 'package:new_app/models/match.dart';


class Football extends Match {
  final List<Joueur> buteurs;
  final Map<String, String> statistiques;

  Football({
    required this.buteurs,
    required this.statistiques,
    required String id,
    required DateTime date,
    required Equipe equipeA,
    required Equipe equipeB,
    required int scoreEquipeA,
    required int scoreEquipeB,
    required SportType sport,
    required List<Commentaire> comments,
    required int likes,
    required int dislikes,
    required String partageLien
  }) : super(
    id: id,
    date: date,
    equipeA: equipeA,
    equipeB: equipeB,
    scoreEquipeA: scoreEquipeA,
    scoreEquipeB: scoreEquipeB,
    sport: sport,
    comments: comments,
    likes: likes,
    dislikes: dislikes,
    partageLien: partageLien
  );
}