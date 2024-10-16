import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_app/services/annonce_service.dart';
import 'dart:io';

import '../../models/categorie.dart';

class AddCategoriePage extends StatefulWidget {
  @override
  _AddCategoriePageState createState() => _AddCategoriePageState();
}

class _AddCategoriePageState extends State<AddCategoriePage> {
  final TextEditingController _libelleController = TextEditingController();
  AnnonceService _annonceService = AnnonceService();
  File? _imageFile;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImageToStorage(File image) async {
    try {
      String fileName = '${_libelleController.text}_logo';
      Reference storageRef =
          FirebaseStorage.instance.ref().child('categories/$fileName');
      UploadTask uploadTask = storageRef.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Erreur lors du téléchargement de l\'image: $e');
      return null;
    }
  }

  Future<void> _ajouterCategorie() async {
    if (_libelleController.text.isEmpty || _imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Veuillez remplir tous les champs et ajouter un logo."),
      ));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      String? logoUrl = await _uploadImageToStorage(_imageFile!);
      if (logoUrl != null) {
        Categorie categorie = Categorie(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          libelle: _libelleController.text,
          logo: logoUrl,
        );

        _annonceService.addCategorie(categorie);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Catégorie ajoutée avec succès !"),
        ));

        _libelleController.clear();
        setState(() {
          _imageFile = null;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Erreur lors de l'ajout de l'image."),
        ));
      }
    } catch (e) {
      print('Erreur lors de l\'ajout de la catégorie: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Erreur lors de l'ajout de la catégorie."),
      ));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une Catégorie'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _libelleController,
              decoration: InputDecoration(labelText: 'Libellé de la Catégorie'),
            ),
            SizedBox(height: 20),
            _imageFile == null
                ? Text('Aucune image sélectionnée.')
                : Image.file(_imageFile!, height: 150),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Choisir un logo'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _ajouterCategorie,
                    child: Text('Ajouter la Catégorie'),
                  ),
          ],
        ),
      ),
    );
  }
}
