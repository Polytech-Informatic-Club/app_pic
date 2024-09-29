import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:new_app/models/objet_perdu_model.dart';
import 'dart:io';

class ObjetPerduService {
  final _firestore = FirebaseFirestore.instance;

  Future<String?> uploadImage(File imageFile) async {
    try {
      // Create a reference to the Firebase Storage location
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('lost_objects/${imageFile.path.split('/').last}');

      // Upload the file
      final uploadTask = storageRef.putFile(imageFile);

      // Get the download URL once the upload is complete
      final TaskSnapshot taskSnapshot = await uploadTask;
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> addLostObject(ObjetPerdu objetPerdu) async {
    try {
      await _firestore.collection('lost_objects').add({
        'description': objetPerdu.description,
        'photoURL': objetPerdu.photoURL,
        'lieu': objetPerdu.lieu,
        'date': objetPerdu.date,
        'etat': objetPerdu.estTrouve,
        'user': objetPerdu.user
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  Stream<QuerySnapshot> getLostObjects() {
    return _firestore
        .collection('lost_objects')
        .orderBy('estTrouve', descending: false)
        .snapshots();
  }
}
