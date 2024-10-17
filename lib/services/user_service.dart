// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_app/models/promo.dart';
import 'package:new_app/models/utilisateur.dart';
import 'package:new_app/utils/app_colors.dart';
import 'package:new_app/widgets/alerte_message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("USER");

  CollectionReference tokenCollection =
      FirebaseFirestore.instance.collection("TOKEN");
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> getUserData() async {
    String? email = FirebaseAuth.instance.currentUser?.email;

    if (email == null) {
      throw Exception("Utilisateur non authentifié");
    }

    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection("USER").doc(email).get();

    if (!userDoc.exists) {
      throw Exception("Données utilisateur non trouvée");
    }

    return userDoc.data() as Map<String, dynamic>;
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('id_token');
  }

  Future<String?> getPrenom() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('prenom');
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

  Future<Utilisateur?> getUserByEmail(String email) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection("USER")
          .where("email", isEqualTo: email)
          .limit(1)
          .get();
      Map<String, dynamic> user = querySnapshot.docs.first.data();
      return Utilisateur.fromJson(user);
    } catch (e) {
      return null;
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

  Future<String> updateUser(
      String email, Map<String, dynamic> fieldsToUpdate) async {
    try {
      print("Updating user with email: $email");
      print("Fields to update: $fieldsToUpdate");

      // Vérifiez que l'email est valide
      if (email.isEmpty) {
        throw "Email is empty!";
      }

      await userCollection.doc(email).update(fieldsToUpdate);
      print("Update successful for user with email: $email");
      return "OK";
    } catch (e) {
      print("Error updating user: $e");
      return "Erreur lors de la mise à jour de l'utilisateur : $e";
    }
  }

  Future<String?> getUserRole(String email) async {
    try {
      // Récupère le document correspondant à l'utilisateur dans Firestore
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await _firestore.collection("USER").doc(email).get();

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

  Future<String> getParam(String param) async {
    try {
      // Récupère le document correspondant à l'utilisateur dans Firestore
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await _firestore.collection("PARAMETRE").doc(param).get();

      if (docSnapshot.exists) {
        // Si le document existe, récupère les données de l'utilisateur
        Map<String, dynamic>? data = docSnapshot.data();

        if (data != null && data.containsKey(param)) {
          // Retourne le rôle de l'utilisateur si disponible
          return data[param];
        }
      }

      return ""; // Retourne null si le rôle n'est pas trouvé
    } catch (e) {
      return ""; // Gestion des erreurs
    }
  }

  Future<String> postToken(String token, String role) async {
    try {
      await tokenCollection
          .doc(token)
          .set({"token": postToken, "role": role, "active": true});
      return "OK";
    } catch (e) {
      return "Erreur lors de l'ajout de l'Utilisateur : $e";
    }
  }

  Future<String?> uploadImage(
      BuildContext context, ValueNotifier _loading, ValueNotifier _url) async {
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return "";
    }

    File imageFile = File(pickedImage.path);

    try {
      _loading.value = true;

      // Lire l'image
      final img.Image originalImage =
          img.decodeImage(await imageFile.readAsBytes())!;

      // Compresser l'image
      File compressedImageFile = await compressImage(originalImage);

      // Uploader l'image compressée
      String filename =
          DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
      Reference reference = FirebaseStorage.instance.ref(filename);
      await reference.putFile(compressedImageFile);

      _url.value = await reference.getDownloadURL();
      return _url.value;
    } on FirebaseException catch (e) {
      alerteMessageWidget(
          context,
          "Une erreur s'est produite lors du chargement : ${e.message}",
          AppColors.echec);
    } catch (error) {
      alerteMessageWidget(
          context,
          "Une erreur s'est produite lors du chargement : $error",
          AppColors.echec);
    } finally {
      _loading.value = false;
    }
    return "";
  }

  Future<File> compressImage(img.Image image) async {
    int quality = 85;
    int minQuality = 20;
    File? result;

    do {
      final tempDir = await getTemporaryDirectory();
      final path = tempDir.path;
      final compressedImage = img.encodeJpg(image, quality: quality);
      result = await File('$path/compressed_image.jpg')
          .writeAsBytes(compressedImage);

      final fileSize = await result.length();
      if (fileSize > 1000000) {
        // 1 MB = 1,000,000 bytes
        quality = max(quality - 10, minQuality);
      }
    } while (await result.length() > 1000000 && quality > minQuality);

    return result;
  }

  Future<List<Promo>> getListPromo() async {
    try {
      List<Promo> list = [];
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection("PROMO").get();
      List<Map<String, dynamic>> listePromos =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      for (var promo in listePromos) {
        print(promo);
        list.add(Promo.fromJson(promo));
      }

      return list;
    } catch (e) {
      return [];
    }
  }

  Future<Promo?> getListByName(String promo) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection("PROMO")
          .where("nom", isEqualTo: promo)
          .limit(1)
          .get();
      List<Map<String, dynamic>> listePromos =
          querySnapshot.docs.map((doc) => doc.data()).toList();

      return Promo.fromJson(listePromos.first);
    } catch (e) {
      return null;
    }
  }

  Future<List<Utilisateur>> getAllUserInPromo(String promo) async {
    try {
      List<Utilisateur> list = [];
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection("USER")
          .where("promo", isEqualTo: promo)
          .get();
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

  Future<bool> changePassword(
      String currentPassword, String newPassword) async {
    final user = FirebaseAuth.instance.currentUser;
    print(currentPassword + newPassword);

    final credential = EmailAuthProvider.credential(
      email: user!.email!,
      password: currentPassword,
    );
    print(currentPassword + newPassword);

    try {
      // Re-authenticate the user
      await user.reauthenticateWithCredential(credential);

      // Update the password
      await user.updatePassword(newPassword);
      print('Password changed successfully');
      return true;
    } catch (e) {
      print('Error: $e');
    }
    return false;
  }

  Future<bool> resetAccount(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      print('Password reset email sent');
      return true;
    } catch (e) {
      print('Error: $e');

      return false;
    }
  }
}
