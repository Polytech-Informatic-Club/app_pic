import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/models/commission.dart';
import 'package:new_app/models/enums/sport_type.dart';
import 'package:new_app/models/equipe.dart';
import 'package:new_app/models/football.dart';
import 'package:new_app/models/membre.dart';
import 'package:new_app/models/utilisateur.dart';
import 'package:new_app/pages/interclasse/football/homeAdminFootballPage.dart';
import 'package:new_app/services/SportService.dart';
import 'package:new_app/services/UserService.dart';
import 'package:new_app/utils/AppColors.dart';
import 'package:new_app/widgets/alerteMessage.dart';
import 'package:new_app/widgets/reusableDescriptionInput.dart';
import 'package:new_app/widgets/reusable_widgets.dart';
import 'package:new_app/widgets/submitedButton.dart';

class CreateCommission extends StatelessWidget {
  String typeSport;
  CreateCommission(this.typeSport, {super.key});
  TextEditingController _nomCommissionTextController = TextEditingController();
  SportService _SportService = new SportService();
  UserService _userService = new UserService();

  final ValueNotifier<List<Utilisateur>> _equipes = ValueNotifier([]);
  ValueNotifier<Utilisateur?> _selectedEquipeA = ValueNotifier(null);
  Future<void> _loadEquipes() async {
    List<Utilisateur> equipes = await _userService.getAllUser();
    _equipes.value = equipes;
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
          // height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      20, MediaQuery.of(context).size.height * 0.02, 20, 0),
                  child: Column(children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ValueListenableBuilder<List<Utilisateur>>(
                          valueListenable: _equipes,
                          builder: (context, equipes, child) {
                            return ValueListenableBuilder<Utilisateur?>(
                              valueListenable: _selectedEquipeA,
                              builder: (context, selectedEquipeA, child) {
                                return DropdownButton<Utilisateur>(
                                  hint: Text('Equipe A'),
                                  value: equipes.contains(selectedEquipeA)
                                      ? selectedEquipeA
                                      : null,
                                  onChanged: (Utilisateur? newValue) {
                                    _selectedEquipeA.value = newValue;
                                  },
                                  items: equipes
                                      .map<DropdownMenuItem<Utilisateur>>(
                                          (Utilisateur equipe) {
                                    return DropdownMenuItem<Utilisateur>(
                                      value: equipe,
                                      child: Text(equipe.nom),
                                    );
                                  }).toList(),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    reusableTextFormField(
                        "Poste", _nomCommissionTextController, (value) {}),
                    reusableTextFormField("Nom Commission",
                        _nomCommissionTextController, (value) {}),
                    SizedBox(
                      height: 20,
                    ),
                    SubmittedButton("Créer", () async {
                      try {
                        Commission commission = Commission(
                            id: DateTime.now().toString(),
                            nom: _nomCommissionTextController.value.text,
                            membres: [
                              Membre(
                                  id: DateTime.now().toString(),
                                  poste: "Président",
                                  email: "tester",
                                  prenom: "Elimane",
                                  nom: "SALL")
                            ]);
                        try {
                          String code =
                              await _SportService.postCommission(commission);
                          if (code == "OK") {
                            alerteMessageWidget(context,
                                "Match crée avec succès !", AppColors.success);
                            changerPage(
                                context, HomeAdminFootballPage(typeSport));
                          }
                        } catch (e) {}
                      } catch (e) {
                        alerteMessageWidget(
                            context,
                            "Une erreur est survie lors de la création.${e}",
                            AppColors.echec);
                      }
                    })
                  ])))),
    );
  }
}
