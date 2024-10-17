import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_app/models/equipe.dart';
import 'package:new_app/services/notification_service.dart';

class EquipeService {
  LocalNotificationService _notificationService =
      new LocalNotificationService();
  final CollectionReference equipesCollection =
      FirebaseFirestore.instance.collection('EQUIPE');

  Future<void> createEquipe(Equipe equipe) async {
    try {
      await equipesCollection.doc(equipe.id).set(equipe.toJson());
      await _notificationService.sendAllNotification("Une nouvelle équipe",
          "L'équipe du nom de ${equipe.nom} vient nous rejoindre dans la famille polytechnicienne. Nous leur souhaitons bonne chance.");
    } catch (e) {
      print('Erreur lors de la création de l\'équipe : $e');
    }
  }

  Future<Equipe?> getEquipeById(String id) async {
    try {
      DocumentSnapshot doc = await equipesCollection.doc(id).get();
      if (doc.exists) {
        return Equipe.fromJson(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print('Erreur lors de la récupération de l\'équipe : $e');
    }
    return null;
  }

  Future<List<Equipe>> getAllEquipes() async {
    try {
      QuerySnapshot querySnapshot = await equipesCollection.get();
      return querySnapshot.docs
          .map((doc) => Equipe.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Erreur lors de la récupération des équipes : $e');
      return [];
    }
  }

  Future<void> updateEquipe(Equipe equipe) async {
    try {
      await equipesCollection.doc(equipe.id).update(equipe.toJson());
    } catch (e) {
      print('Erreur lors de la mise à jour de l\'équipe : $e');
    }
  }

  Future<void> deleteEquipe(String id) async {
    try {
      await equipesCollection.doc(id).delete();
    } catch (e) {
      print('Erreur lors de la suppression de l\'équipe : $e');
    }
  }
}
