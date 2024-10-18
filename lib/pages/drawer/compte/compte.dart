import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/models/utilisateur.dart';
import 'package:new_app/pages/drawer/compte/edit_infos_utilisateur.dart';
import 'package:new_app/pages/drawer/compte/edit_password.dart';
import 'package:new_app/services/user_service.dart';
import 'package:new_app/utils/app_colors.dart';

class CompteScreen extends StatelessWidget {
  CompteScreen({super.key});

  UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compte'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: Icon(
          Icons.edit,
          color: AppColors.black,
        ),
        onPressed: () {
          changerPage(context, EditInfosUtilisateur());
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder<Utilisateur?>(
            future: _userService
                .getUserByEmail(FirebaseAuth.instance.currentUser!.email!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child: Text('Erreur lors de la récupération des données'));
              } else {
                final user = snapshot.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle, // Forme en cercle
                              border: Border.all(
                                color: orange, // Couleur de la bordure
                                width: 4.0, // Largeur de la bordure
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 80,
                              backgroundImage: user!.photo! != ""
                                  ? ResizeImage(
                                NetworkImage(user.photo!),
                                height: 480,  // Hauteur d'affichage souhaitée
                              )
                                  : AssetImage('') as ImageProvider,
                              backgroundColor: grisClair,
                            ),

                          ),
                          Text(user.role.toString().split(".").last),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: Colors.black,
                            height: 2,
                            width: 100,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text('Prénom(s)'),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: eptLighterOrange,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(user.prenom),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Nom'),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: eptLighterOrange,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(user.nom.toUpperCase()),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Numéro'),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: eptLighterOrange,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(user.telephone!),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Email'),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: eptLighterOrange,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(user.email),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Promo'),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: eptLighterOrange,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(user.promo!),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Génie'),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: eptLighterOrange,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(user.genie!),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () =>
                              {changerPage(context, EditPassword())},
                          child: Text(
                            "Modifier le mot de passe",
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(AppColors.primary)),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                  ],
                );
              }
            }),
      ),
    );
  }
}
