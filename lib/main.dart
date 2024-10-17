// ignore_for_file: prefer_const_constructors

import 'package:app_version_update/app_version_update.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:new_app/login/inscription.dart';
import 'package:new_app/login/login.dart';
import 'package:new_app/models/football.dart';
import 'package:new_app/pages/drawer/xoss/page_boutiquier.dart';
import 'package:new_app/pages/interclasse/football/create_membre.dart';
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
import 'package:new_app/pages/shop/shop_screen.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:new_app/services/user_service.dart';
import 'package:new_app/utils/app_colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting(
      'fr', null); // Initialisation de la locale française
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

// Fonction de vérification de la version
  void _verifyVersion(BuildContext context) async {
    // await AppVersionUpdate.checkForUpdates(
    //   appleId: '284882215',
    //   playStoreId: 'com.zhiliaoapp.musically',
    // ).then((result) async {
    //   if (result.canUpdate!) {
    //     // Afficher une boîte de dialogue pour la mise à jour
    //     await AppVersionUpdate.showAlertUpdate(
    //       appVersionResult: result,
    //       context: context,
    //       backgroundColor: Colors.grey[200],
    //       title: 'Une nouvelle version est disponible.',
    //       titleTextStyle: const TextStyle(
    //           color: Colors.black, fontWeight: FontWeight.w600, fontSize: 24.0),
    //       content:
    //           'Voulez-vous mettre à jour votre application à la dernière version?',
    //       contentTextStyle: const TextStyle(
    //         color: Colors.black,
    //         fontWeight: FontWeight.w400,
    //       ),
    //       updateButtonText: 'METTRE À JOUR',
    //       cancelButtonText: 'PLUS TARD',
    //     );
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(backgroundColor: Colors.white),
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('fr')], // Support de la locale française
      home: AuthHandler(),
    );
  }
}

class AuthHandler extends StatelessWidget {
  final UserService _userService = UserService();
  Future<void> _verifyVersion(BuildContext context) async {
    // String appleId = await _userService.getParam("appleId");
    // String playStoreId = await _userService.getParam("playStoreId");
    // await AppVersionUpdate.checkForUpdates(
    //         appleId: appleId, playStoreId: playStoreId, country: "Sénégal")
    //     .then((result) async {
    //   if (result.canUpdate!) {
    //     // Afficher une boîte de dialogue pour la mise à jour
    //     await AppVersionUpdate.showAlertUpdate(
    //       appVersionResult: result,
    //       context: context,
    //       backgroundColor: Colors.grey[200],
    //       title: 'Nouvelle version disponible',
    //       titleTextStyle: const TextStyle(
    //           color: Colors.black, fontWeight: FontWeight.w600, fontSize: 24.0),
    //       content:
    //           'Une nouvelle version de l\'application est disponible. Voulez-vous mettre à jour ?',
    //       contentTextStyle: TextStyle(
    //         color: Colors.black,
    //         fontWeight: FontWeight.w400,
    //       ),
    //       updateButtonText: 'Mettre à jour',
    //       updateButtonStyle: ButtonStyle(
    //         backgroundColor:
    //             MaterialStateProperty.all<Color>(AppColors.success),
    //       ),
    //       cancelButtonText: 'Plus tard',
    //       cancelButtonStyle: ButtonStyle(
    //         backgroundColor: MaterialStateProperty.all<Color>(AppColors.echec),
    //       ),
    //     );
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    // Utilisation de StreamBuilder pour écouter les changements d'état de l'utilisateur
    // return FutureBuilder(
    //     future: _verifyVersion(
    //         context), // Vérification de la version lors de la construction
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return const Scaffold(
    //           body: Center(
    //               child:
    //                   CircularProgressIndicator()), // Indicateur de chargement
    //         );
    //       }
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
          // },
          // );
        });
  }
}
