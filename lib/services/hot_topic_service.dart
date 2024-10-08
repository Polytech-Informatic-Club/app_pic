import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_app/pages/annonce/hot_topics.dart';
import 'package:new_app/models/hot_topic.dart';

class HotTopicService {
  final CollectionReference hotTopicsCollection =
      FirebaseFirestore.instance.collection('HOTTOPICS');

  Future<void> createHotTopic(HotTopic hotTopic) async {
    try {
      CollectionReference hotTopicsRef =
          FirebaseFirestore.instance.collection('HOTTOPICS');

      await hotTopicsRef.doc(hotTopic.id).set({
        'id': hotTopic.id,
        'title': hotTopic.title,
        'content': hotTopic.content,
        'category': hotTopic.category,
        'fileUrl': hotTopic.fileUrl,
        'dateCreation': Timestamp.fromDate(hotTopic.dateCreation),
      });

      print("Hot Topic créé avec succès !");
    } catch (e) {
      print("Erreur lors de la création du Hot Topic: $e");
      throw e;
    }
  }

  Future<List<HotTopic>> getHotTopics() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('HOTTOPICS').get();
      return querySnapshot.docs.map((doc) {
        return HotTopic.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Erreur lors de la récupération des Hot Topics: $e');
      throw e;
    }
  }

  Future<void> updateHotTopic(HotTopic hotTopic) async {
    await FirebaseFirestore.instance
        .collection('HOTTOPICS')
        .doc(hotTopic.id)
        .update(hotTopic.toJson());
  }

  Future<void> deleteHotTopic(String id) async {
    try {
      CollectionReference hotTopicsRef =
          FirebaseFirestore.instance.collection('HOTTOPICS');
      await hotTopicsRef.doc(id).delete();

      print("Hot Topic supprimé avec succès !");
    } catch (e) {
      print("Erreur lors de la suppression du Hot Topic: $e");
      throw e;
    }
  }

  Future<List<HotTopic>> getHotTopicsByCategory(String category) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('HOTTOPICS')
          .where('category', isEqualTo: category)
          .get();

      return querySnapshot.docs.map((doc) {
        return HotTopic.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Erreur lors de la récupération des Hot Topics par catégorie: $e');
      throw e;
    }
  }
}
