import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_app/models/equipe.dart';

class EquipeService {
  final CollectionReference equipesCollection =
      FirebaseFirestore.instance.collection('EQUIPES');

  Future<void> createEquipe(Equipe equipe) async {
    try {
      await equipesCollection.doc(equipe.id).set(equipe.toJson());
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
