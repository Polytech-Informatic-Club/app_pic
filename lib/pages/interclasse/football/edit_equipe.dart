import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_app/services/equipe_service.dart';
import 'dart:io';
import '/models/equipe.dart';

class EditEquipePage extends StatefulWidget {
  final Equipe equipe;

  EditEquipePage({required this.equipe});

  @override
  _EditEquipePageState createState() => _EditEquipePageState();
}

class _EditEquipePageState extends State<EditEquipePage> {
  final TextEditingController _nomController = TextEditingController();
  File? _imageFile;
  bool _isLoading = false;
  EquipeService _equipeService = EquipeService();

  @override
  void initState() {
    super.initState();
    _nomController.text = widget.equipe.nom;
  }

  Future<void> _supprimerEquipe() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('EQUIPE')
          .doc(widget.equipe.id)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Équipe supprimée avec succès !"),
      ));

      Navigator.pop(context); // Retour à la page précédente après suppression
    } catch (e) {
      print('Erreur lors de la suppression de l\'équipe: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Erreur lors de la suppression de l'équipe."),
      ));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Fonction pour afficher une boîte de dialogue de confirmation
  Future<void> _showDeleteConfirmation() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmer la suppression'),
          content: Text('Voulez-vous vraiment supprimer cette équipe ?'),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirmer'),
              onPressed: () {
                Navigator.of(context).pop();
                _supprimerEquipe();
              },
            ),
          ],
        );
      },
    );
  }

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
      String fileName = '${_nomController.text}_logo';
      Reference storageRef =
          FirebaseStorage.instance.ref().child('equipes/$fileName');
      UploadTask uploadTask = storageRef.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Erreur lors du téléchargement de l\'image: $e');
      return null;
    }
  }

  Future<void> _modifierEquipe() async {
    if (_nomController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Veuillez remplir tous les champs."),
      ));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      String? logoUrl;
      if (_imageFile != null) {
        logoUrl = await _uploadImageToStorage(_imageFile!);
      } else {
        logoUrl = widget.equipe.logo;
      }

      if (logoUrl != null) {
        Equipe updatedEquipe = Equipe(
          id: widget.equipe.id,
          nom: _nomController.text,
          logo: logoUrl,
          joueurs: widget.equipe.joueurs,
        );

        _equipeService.updateEquipe(updatedEquipe);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Équipe modifiée avec succès !"),
        ));

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Erreur lors de la modification de l'image."),
        ));
      }
    } catch (e) {
      print('Erreur lors de la modification de l\'équipe: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Erreur lors de la modification de l'équipe."),
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
        title: Text('Modifier une Équipe'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDeleteConfirmation();
        },
        child: Icon(Icons.delete),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nomController,
              decoration: InputDecoration(labelText: 'Nom de l\'équipe'),
            ),
            SizedBox(height: 20),
            _imageFile == null
                ? widget.equipe.logo.isNotEmpty
                    ? Image.network(widget.equipe.logo, height: 150)
                    : Text('Aucune image sélectionnée.')
                : Image.file(_imageFile!, height: 150),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Choisir un nouveau logo'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _modifierEquipe,
                    child: Text('Modifier l\'équipe'),
                  ),
          ],
        ),
      ),
    );
  }
}
