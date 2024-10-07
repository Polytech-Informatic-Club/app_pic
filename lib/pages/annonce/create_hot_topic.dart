import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_app/models/hot_topic.dart';
import 'package:new_app/services/hot_topic_service.dart';
import 'dart:io';

import 'package:new_app/widgets/reusable_widgets.dart';
import 'package:new_app/widgets/submited_button.dart';

class CreateHotTopicScreen extends StatefulWidget {
  @override
  _CreateHotTopicScreenState createState() => _CreateHotTopicScreenState();
}

class _CreateHotTopicScreenState extends State<CreateHotTopicScreen> {
  final _formKey = GlobalKey<FormState>();
  HotTopicService _hotTopicService = HotTopicService();
  String? _selectedCategory;
  String? _excelFileUrl; // URL du fichier Excel si joint
  File? _selectedFile;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  // Liste des catégories disponibles
  final List<String> _categories = ['restauration', 'bourse'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer un Hot Topic'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              reusableTextFormField(
                'Titre',
                _titleController,
                (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un titre';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              reusableTextFormField(
                'Description',
                _descriptionController,
                (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: InputDecoration(labelText: 'Catégorie'),
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Veuillez sélectionner une catégorie';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // Affiche un bouton si la catégorie sélectionnée est "bourse"
              if (_selectedCategory == 'bourse')
                ElevatedButton(
                  onPressed: _selectFile,
                  child: Text(_selectedFile == null
                      ? 'Joindre un fichier Excel'
                      : 'Changer le fichier Excel'),
                ),
              SizedBox(height: 16),
              SubmittedButton('Créer le Hot Topic', _submitHotTopic),
            ],
          ),
        ),
      ),
    );
  }

  // Sélectionner un fichier Excel
  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  // Soumettre le hot topic
  Future<void> _submitHotTopic() async {
    if (_formKey.currentState!.validate()) {
      try {
        String? fileUrl;

        // Si un fichier est sélectionné, uploader dans Firebase Storage
        if (_selectedFile != null) {
          fileUrl = await _uploadExcelFile(_selectedFile!);
        }

        // Créer une instance de HotTopic
        HotTopic newHotTopic = HotTopic(
          id: DateTime.now()
              .millisecondsSinceEpoch
              .toString(), // Générer un ID unique
          title: _titleController.text,
          content: _descriptionController.text,
          category: _selectedCategory!,
          fileUrl: fileUrl,
          dateCreation: DateTime.now(),
        );

        // Sauvegarder dans Firestore
        await _hotTopicService.createHotTopic(newHotTopic);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hot Topic créé avec succès')),
        );

        // Vider les champs après la création
        _titleController.clear();
        _descriptionController.clear();
        setState(() {
          _selectedCategory = null;
          _selectedFile = null;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur : $e')),
        );
      }
    }
  }

  // Uploader le fichier Excel dans Firebase Storage
  Future<String> _uploadExcelFile(File file) async {
    String fileName = 'hotTopics/${DateTime.now().millisecondsSinceEpoch}.xlsx';
    UploadTask uploadTask =
        FirebaseStorage.instance.ref(fileName).putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }
}
