import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/models/enums/sport_type.dart';
import 'package:new_app/models/equipe.dart';
import 'package:new_app/models/football.dart';
import 'package:new_app/pages/sports/football/homeAdminFootballPage.dart';
import 'package:new_app/services/FootballService.dart';
import 'package:new_app/utils/AppColors.dart';
import 'package:new_app/widgets/alerteMessage.dart';
import 'package:new_app/widgets/reusableDescriptionInput.dart';
import 'package:new_app/widgets/reusableTextFormFied.dart';
import 'package:new_app/widgets/submitedButton.dart';

class CreateMatchFootball extends StatelessWidget {
  CreateMatchFootball({super.key});
  TextEditingController _descriptionTextController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  FootballService _footballService = new FootballService();

  final ValueNotifier<List<Equipe>> _equipes = ValueNotifier([]);
  ValueNotifier<Equipe?> _selectedEquipeA = ValueNotifier(null);
  ValueNotifier<Equipe?> _selectedEquipeB = ValueNotifier(null);
  ValueNotifier<DateTime?> _selectedDate = ValueNotifier(DateTime.now());
  ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<String> _url = ValueNotifier("");

  Future<void> _loadEquipes() async {
    List<Equipe> equipes = await _footballService.getEquipeList();
    _equipes.value = equipes;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
  }

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  Future<void> uploadImage(BuildContext context) async {
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return null;
    }
    String filename = pickedImage.name;
    File imageFile = File(pickedImage.path);

    Reference reference = firebaseStorage.ref(filename);

    try {
      _loading.value = true;
      await reference.putFile(imageFile);
      _url.value = (await reference.getDownloadURL()).toString();
      _loading.value = false;

      AlerteMessageWidget(
          context, "Fichier enregistré avec succès !", AppColors.success);

      print("SamaUrl" + _url.value);
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadEquipes();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text("Créer un match"),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      20, MediaQuery.of(context).size.height * 0.2, 20, 0),
                  child: Column(children: <Widget>[
                    ValueListenableBuilder<bool>(
                        valueListenable: _loading,
                        builder: (context, isSaving, child) {
                          return !isSaving
                              ? CircularProgressIndicator()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: ElevatedButton.icon(
                                      onPressed: () async {
                                        await uploadImage(context);
                                      },
                                      icon: Icon(
                                        Icons.library_add,
                                      ),
                                      label: Text("Image"),
                                    )),
                                  ],
                                );
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ValueListenableBuilder<List<Equipe>>(
                            valueListenable: _equipes,
                            builder: (context, equipes, child) {
                              return ValueListenableBuilder<Equipe?>(
                                  valueListenable: _selectedEquipeA,
                                  builder: (context, selectedEquipe, child) {
                                    return DropdownButton<Equipe>(
                                      hint: Text('Equipe A'),
                                      value: _selectedEquipeA.value,
                                      onChanged: (Equipe? newValue) {
                                        _selectedEquipeA.value = newValue;
                                      },
                                      items: _equipes.value
                                          .map<DropdownMenuItem<Equipe>>(
                                              (Equipe equipe) {
                                        return DropdownMenuItem<Equipe>(
                                          value: equipe,
                                          child: Text(equipe.nom),
                                        );
                                      }).toList(),
                                    );
                                  });
                            }),
                        SizedBox(
                          width: 3,
                        ),
                        Text("VS"),
                        SizedBox(
                          width: 3,
                        ),
                        ValueListenableBuilder<List<Equipe>>(
                            valueListenable: _equipes,
                            builder: (context, equipes, child) {
                              return ValueListenableBuilder<Equipe?>(
                                  valueListenable: _selectedEquipeB,
                                  builder: (context, selectedEquipe, child) {
                                    return DropdownButton<Equipe>(
                                      borderRadius: BorderRadius.circular(10),
                                      hint: Text('Equipe B'),
                                      value: _selectedEquipeB.value,
                                      onChanged: (Equipe? newValue) {
                                        _selectedEquipeB.value = newValue;
                                      },
                                      items: _equipes.value
                                          .map<DropdownMenuItem<Equipe>>(
                                              (Equipe equipe) {
                                        return DropdownMenuItem<Equipe>(
                                          value: equipe,
                                          child: Text(equipe.nom),
                                        );
                                      }).toList(),
                                    );
                                  });
                            }),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Row(children: [
                        Icon(Icons.calendar_month),
                        SizedBox(
                          width: 5,
                        ),
                        ValueListenableBuilder<DateTime?>(
                            valueListenable: _selectedDate,
                            builder: (context, selectedDate, child) {
                              return Text(
                                _selectedDate.value.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              );
                            }),
                      ]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ReusableDescriptionInput(
                        "Description", _descriptionTextController, (value) {}),
                    SizedBox(
                      height: 20,
                    ),
                    SubmittedButton("Créer", () async {
                      if (_selectedEquipeA.value != null &&
                          _selectedEquipeB.value != null &&
                          _selectedEquipeA.value != _selectedEquipeB.value) {
                        try {
                          Football football = new Football(
                              buteurs: [],
                              description: _descriptionTextController.value,
                              photo: _url.value,
                              statistiques: {
                                "redCardA": 0,
                                "redCardB": 0,
                                "yellowCardA": 0,
                                "yellowCardB": 0,
                                "cornersA": 0,
                                "cornersB": 0,
                                "fautesA": 0,
                                "fautesB": 0,
                                "tirsA": 0,
                                "tirsB": 0,
                                "tirsCadresA": 0,
                                "tirsCadresB": 0,
                              },
                              id: DateTime.now().toString(),
                              date: _selectedDate.value!,
                              equipeA: _selectedEquipeA.value!,
                              equipeB: _selectedEquipeB.value!,
                              dateCreation: DateTime.now(),
                              scoreEquipeA: 0,
                              scoreEquipeB: 0,
                              sport: SportType.FOOTBALL,
                              comments: [],
                              likers: [],
                              dislikers: [],
                              partageLien: "");
                          try {
                            String code =
                                await _footballService.postFootball(football);
                            if (code == "OK") {
                              AlerteMessageWidget(
                                  context,
                                  "Match crée avec succès !",
                                  AppColors.success);
                              changerPage(context, HomeAdminFootballPage());
                            }
                          } catch (e) {}
                        } catch (e) {
                          AlerteMessageWidget(
                              context,
                              "Une erreur est survie lors de la création.",
                              AppColors.echec);
                        }
                      } else {
                        AlerteMessageWidget(
                            context,
                            "Vous n'avez pas sélectionné une équipe ou des équipes différentes.",
                            AppColors.echec);
                      }
                    })
                    // signInSignUpButton("Créer", context, false, () {
                    //   FirebaseFirestore.instance.collection('Matchs').add({
                    //     "idEquipe1": _equipeTextController.value.text,
                    //     "idEquipe2": _adversaireTextController.value.text,
                    //     "redCard1": 0,
                    //     "redCard2": 0,
                    //     "yellowCard1": 0,
                    //     "yellowCard2": 0,
                    //     "corners1": 0,
                    //     "corners2": 0,
                    //     "fautes1": 0,
                    //     "fautes2": 0,
                    //     "score1": 0,
                    //     "score2": 0,
                    //     "tirs1": 0,
                    //     "tirs2": 0,
                    //     "tirsCadres1": 0,
                    //     "tirsCadres2": 0,
                    //     "date": selectedDate,
                    //     "dateCreation": DateTime.now(),
                    //     "commentaires": [],
                    //     "likes": 0
                    //   });
                    // }),
                  ])))),
    );
  }
}
