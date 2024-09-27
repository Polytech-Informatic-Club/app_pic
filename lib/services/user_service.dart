import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_app/models/utilisateur.dart';
import 'package:new_app/utils/app_colors.dart';
import 'package:new_app/widgets/alerte_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("USER");
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('id_token');
  }

  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('id_token', token);
  }

  Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }

  Future<void> setRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', role);
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    final UserCredential userCredential = await _auth
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    final UserCredential userCredential = await _auth
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Stream<User?> get authStateChanges => _auth.authStateChanges();

// USER SERVICE
  Future<List<Utilisateur>> getAllUser() async {
    try {
      List<Utilisateur> list = [];
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection("USER").get();
      List<Map<String, dynamic>> listeUsers =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      for (var user in listeUsers) {
        list.add(Utilisateur.fromJson(user));
      }

      return list;
    } catch (e) {
      return [];
    }
  }

  Future<String> ajouterUser(Utilisateur utilisateur) async {
    try {
      await userCollection.doc(utilisateur.email).set(utilisateur.toJson());
      return "OK";
    } catch (e) {
      return "Erreur lors de l'ajout de l'Utilisateur : $e";
    }
  }

  Future<String?> getUserRole(String uid) async {
    try {
      // Récupère le document correspondant à l'utilisateur dans Firestore
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await _firestore.collection("USER").doc(uid).get();

      if (docSnapshot.exists) {
        // Si le document existe, récupère les données de l'utilisateur
        Map<String, dynamic>? userData = docSnapshot.data();

        if (userData != null && userData.containsKey('role')) {
          // Retourne le rôle de l'utilisateur si disponible
          return userData['role'] as String?;
        }
      }

      return null; // Retourne null si le rôle n'est pas trouvé
    } catch (e) {
      return null; // Gestion des erreurs
    }
  }

  Future<String?> uploadImage(
      BuildContext context, ValueNotifier _loading, ValueNotifier _url) async {
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return "";
    }
    String filename = pickedImage.name;
    File imageFile = File(pickedImage.path);

    Reference reference = firebaseStorage.ref(filename);

    try {
      _loading.value = true;
      await reference.putFile(imageFile);

      _url.value = (await reference.getDownloadURL()).toString();
      _loading.value = false;
      return _url.value;
    } on FirebaseException catch (e) {
      alerteMessageWidget(context,
          "Une erreur s'est produit lors du chargement !", AppColors.echec);
    } catch (error) {
      alerteMessageWidget(context,
          "Une erreur s'est produit lors du chargement !", AppColors.echec);
    }
    return "";
  }
}
