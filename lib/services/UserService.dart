import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// BUS SERVICE
  Future<List<Map<String, dynamic>>> getAllUser() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection("USER").get();
      List<Map<String, dynamic>> listeUsers =
          querySnapshot.docs.map((doc) => doc.data()).toList();

      return listeUsers;
    } catch (e) {
      return [];
    }
  }

  Future<void> ajouterUser(String url, String prenom, String nom, String email,
      Map<dynamic, dynamic> position) async {
    try {
      CollectionReference alerteCollection =
          FirebaseFirestore.instance.collection("ALERTES");

      await alerteCollection.add({
        'urlProfile': url,
        'prenom': prenom,
        'nom': nom,
        "time": DateTime.now(),
        "email": email,
        "userId": FirebaseAuth.instance.currentUser!.uid,
        "tokenNotification": "",
        "currentPosition": position
      });

      // Affichez un message ou effectuez une action supplémentaire après l'ajout réussi
      print("Alerte ajoutée avec succès !");
    } catch (e) {
      print("Erreur lors de l'ajout de l'alerte : $e");
    }
  }
}
