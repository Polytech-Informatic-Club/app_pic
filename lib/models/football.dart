import 'package:new_app/models/commentaires.dart';
import 'package:new_app/models/enums/sport_type.dart';
import 'package:new_app/models/equipe.dart';
import 'package:new_app/models/joueur.dart';
import 'package:new_app/models/match.dart';
import 'package:new_app/models/utilisateur.dart';

class Football extends Match {
  final List<Joueur>? buteurs;
  final Map<String, int> statistiques;

  Football(
      {this.buteurs,
      required this.statistiques,
      required String id,
      required DateTime date,
      dateCreation,
      description,
      photo,
      required Equipe equipeA,
      required Equipe equipeB,
      required int scoreEquipeA,
      required int scoreEquipeB,
      required SportType sport,
      required List<Commentaire> comments,
      required List<Utilisateur> likers,
      required List<Utilisateur> dislikers,
      required String partageLien})
      : super(
            id: id,
            date: date,
            dateCreation: dateCreation,
            equipeA: equipeA,
            equipeB: equipeB,
            scoreEquipeA: scoreEquipeA,
            scoreEquipeB: scoreEquipeB,
            sport: sport,
            comments: comments,
            likers: likers,
            dislikers: dislikers,
            partageLien: partageLien,
            description: description,
            photo: photo);
}
