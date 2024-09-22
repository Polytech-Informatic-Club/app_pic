import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_app/models/utilisateur.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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

  Future<void> ajouterUser(Utilisateur utilisateur) async {
    try {
      await userCollection.doc(utilisateur.email).set(utilisateur.toJson());

      print("Utilisateur ajoutée avec succès !");
    } catch (e) {
      print("Erreur lors de l'ajout de l'Utilisateur : $e");
    }
  }
}
