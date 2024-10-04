// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:new_app/login/inscription.dart';
import 'package:new_app/login/login.dart';
import 'package:new_app/models/football.dart';
import 'package:new_app/pages/object_perdus/objets_perdus.dart';
import 'package:new_app/pages/annonce/afficher_annonce.dart';
import 'package:new_app/pages/annonce/annonce_screen.dart';
import 'package:new_app/pages/drawer/compte/compte.dart';
import 'package:new_app/pages/drawer/famille/famille.dart';
import 'package:new_app/pages/drawer/famille/promo.dart';
import 'package:new_app/pages/drawer/propos/a_propos.dart';
import 'package:new_app/pages/drawer/propos/membre.dart';
import 'package:new_app/pages/home/home_page.dart';
import 'package:new_app/pages/home/jeux/game_screen.dart';
import 'package:new_app/pages/interclasse/basket/basket.dart';
import 'package:new_app/pages/interclasse/football/create_match.dart';
import 'package:new_app/pages/interclasse/football/detail_match.dart';
import 'package:new_app/pages/interclasse/football/home_sport_type_page.dart';
import 'package:new_app/pages/interclasse/football/home_admin_sport_type_page.dart';
import 'package:new_app/pages/interclasse/jeux%20desprit/jeu_esprit.dart';
import 'package:new_app/pages/interclasse/volley/volley.dart';
import 'package:new_app/pages/interclasse/interclasse.dart';
import 'package:new_app/pages/shop/shop.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting(
      'fr', null); // Initialisation de la locale française
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(backgroundColor: Colors.white),
      ),
      debugShowCheckedModeBanner: false,
      home: AuthHandler(),
    );
  }
}

class AuthHandler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Utilisation de StreamBuilder pour écouter les changements d'état de l'utilisateur
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Si l'utilisateur est connecté, afficher la page d'accueil
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;

          if (user == null) {
            return LoginScreen(); // Utilisateur non connecté -> Page de connexion
          } else {
            return HomePage(); // Utilisateur connecté -> Page d'accueil
          }
        }

        // Pendant que la connexion est en cours de vérification, afficher un chargement
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
