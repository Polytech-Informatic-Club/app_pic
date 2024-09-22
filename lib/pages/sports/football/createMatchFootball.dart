import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_app/utils/AppColors.dart';
import 'package:new_app/widgets/reusableTextFormFied.dart';
import 'package:new_app/widgets/submitedButton.dart';

class CreateMatchFootball extends StatelessWidget {
  CreateMatchFootball({super.key});
  TextEditingController _equipeTextController = TextEditingController();
  TextEditingController _adversaireTextController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    // if (picked != null && picked != selectedDate)
      // setState(() {
      //   selectedDate = picked;
      // });
  }

  // @override
  // initState() {
  //   super.initState();
  //   selectedDate = DateTime.now();
  // }

  @override
  Widget build(BuildContext context) {
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
                    SizedBox(
                      height: 20,
                    ),
                    ReusableTextFormField(
                        "Equipe 1", _equipeTextController, (value) {}),
                    SizedBox(
                      height: 20,
                    ),
                    ReusableTextFormField(
                        "Equipe 2", _adversaireTextController, (value) {}),
                    SizedBox(
                      height: 20,
                    ),
                    InputDatePickerFormField(
                      firstDate: DateTime(2015, 8),
                      lastDate: DateTime(2101),
                      initialDate: selectedDate,
                      onDateSubmitted: (date) {
                        // setState(() {
                        //   selectedDate = date;
                        // });
                      },
                    ),
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: Text('Select date'),
                    ),
                    SizedBox(height: 10,),
                    SubmittedButton("Créer", (){})
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
