import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/login.dart';
import 'package:new_app/utils/AppColors.dart';

class Inscription extends StatelessWidget {
  const Inscription({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 170,
                      child: Image.asset(
                        'assets/images/connection-inscription/logo_ept_baobab.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                // Title
                Row(
                  children: [
                    Text(
                      'Inscription',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                // Subtitle
                Row(
                  children: [
                    Text(
                      'Vos premiers pas dans la vie polytechnicienne',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Nom TextField
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Nom',
                          labelStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),

                      // Prenom TextField
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Prenom',
                          labelStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Mail TextField
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Mail',
                          labelStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Mot de passe TextField
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Mot de passe',
                          labelStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Confirmer mot de passe TextField
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirmer mot de passe',
                          labelStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Promotion TextField
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Promotion',
                          labelStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      // S'inscrire Button
                      ElevatedButton(
                        onPressed: () {
                          // Action lors de l'inscription
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: orange,
                          padding: EdgeInsets.symmetric(
                              horizontal: 100, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          "S'inscrire",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Déjà inscrit? "),
                          TextButton(
                            onPressed: () {
                              changerPage(context, LoginScreen());
                            },
                            child: Text(
                              'connectez vous',
                              style: TextStyle(
                                color: orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}