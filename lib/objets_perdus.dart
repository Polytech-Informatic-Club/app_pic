// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart'; // Importer intl pour le formatage des dates
import 'package:new_app/models/objet_perdu_model.dart';
import 'package:new_app/models/utilisateur.dart';
import 'package:new_app/services/user_service.dart';
import 'package:new_app/utils/app_colors.dart'; // Assurez-vous que cette classe existe
import 'package:new_app/services/lost_found_service.dart';

class ObjetsPerdus extends StatefulWidget {
  const ObjetsPerdus({super.key});

  @override
  _ObjetsPerdusState createState() => _ObjetsPerdusState();
}

class _ObjetsPerdusState extends State<ObjetsPerdus> {
  final ObjetPerduService _service = ObjetPerduService();
  final UserService _userService = UserService();

  TextEditingController dateController = TextEditingController();
  TextEditingController lieuController = TextEditingController();
  TextEditingController objetController = TextEditingController();
  TextEditingController infoSuppController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker(); // Instance de ImagePicker

  // Fonction pour sélectionner une image depuis la galerie ou prendre une photo
  Future<void> _choisirImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Galerie'),
                onTap: () async {
                  final pickedFile =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _image = File(pickedFile.path);
                    });
                  }
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Caméra'),
                onTap: () async {
                  final pickedFile =
                      await _picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    setState(() {
                      _image = File(pickedFile.path);
                    });
                  }
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Fonction pour choisir la date
  Future<void> _choisirDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        dateController.text =
            DateFormat('dd-MM-yyyy').format(pickedDate); // Format de date
      });
    }
  }

  // submit the form
  Future<void> _submitForm() async {
    String? photoURL = await _service.uploadImage(_image!);
    User? user = FirebaseAuth.instance.currentUser;

    ObjetPerdu objet = ObjetPerdu(
      description: objetController.text,
      details: infoSuppController.text,
      photoURL: photoURL,
      lieu: lieuController.text,
      date: dateController.text,
      estTrouve: 0,
      idUser: user?.email,
    );

    await _service.addLostObject(objet);

    // clear the form
    objetController.clear();
    lieuController.clear();
    dateController.clear();
    infoSuppController.clear();
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Objets Perdus'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chercher un objet perdu',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextField(
                controller: objetController,
                decoration: InputDecoration(
                  labelText: "Qu'avez-vous perdu?",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: lieuController,
                decoration: InputDecoration(
                  labelText: "Où avez-vous perdu votre objet?",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: dateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Quand avez-vous perdu votre objet?",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: _choisirDate, // Ouvre le calendrier
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: infoSuppController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Informations supplémentaires",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                      grisClair), // Couleur personnalisée
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8.0), // Bordure personnalisée
                    ),
                  ),
                ),
                onPressed:
                    _choisirImage, // Appel de la fonction pour choisir l'image
                icon: Icon(Icons.camera_alt),
                label: Text(
                  "Attacher une photo",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16),
              _image != null
                  ? Image.file(
                      _image!,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    )
                  : Icon(Icons.image_not_supported, size: 100),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    // Code pour soumettre le formulaire
                    await _submitForm();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Soumission réussie!"),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                        const Color.fromRGBO(244, 171, 90, 1)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8.0), // Bordure personnalisée
                      ),
                    ),
                  ),
                  child: Text(
                    "Soumettre",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 32),
              Text(
                'Liste des objets perdus',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: "Chercher",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              StreamBuilder<QuerySnapshot>(
                stream: _service.getLostObjects(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        children: [
                          const Text('Erreur de chargement'),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {});
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  const Color.fromRGBO(244, 171, 90, 1)),
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Bordure personnalisée
                                ),
                              ),
                            ),
                            child: Text(
                              "Réessayer",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (!snapshot.hasData) {
                    return Center(
                      child: const Text(
                        "Aucun objet perdu n'est encore signalé",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    );
                  } else {
                    final lostObjects = snapshot.data!.docs;

                    return SizedBox(
                      height: 500,
                      child: ListView.builder(
                        // physics: NeverScrollableScrollPhysics(),
                        // shrinkWrap: true,
                        itemCount: lostObjects.length,
                        itemBuilder: (context, index) {
                          // Extracting data from each document
                          var lostObject =
                              lostObjects[index].data() as Map<String, dynamic>;
                          String description =
                              lostObject['description'] ?? 'No description';
                          String lieu =
                              lostObject['lieu'] ?? 'Unknown location';
                          String? photoUrl = lostObject[
                              'photoURL']; // Nullable: May not have a photo
                          bool estTrouve = lostObject['etat'] != 0;

                          return Card(
                            margin: EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (photoUrl != null)
                                    Image.network(photoUrl,
                                        height: 150,
                                        width: double.infinity,
                                        fit: BoxFit.cover)
                                  else
                                    Container(
                                      height: 150,
                                      color: Colors.grey[300],
                                      child: Center(
                                          child: Icon(Icons.image_not_supported,
                                              size: 50)),
                                    ),
                                  SizedBox(height: 8),
                                  Text(description,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                  Text(lieu,
                                      style: TextStyle(color: Colors.grey)),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text('Condition: '),
                                      estTrouve
                                          ? Text(
                                              'Trouvé',
                                              style: TextStyle(
                                                  color: Colors.green),
                                            )
                                          : Text(
                                              'Non Trouvé',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )
                                    ],
                                  ),
                                  Text(
                                      'Date: ${lostObject['date'] ?? 'Unknown'}'),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
