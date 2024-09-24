// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
//import 'package:new_app/UserPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:new_app/login/inscription.dart';
import 'package:new_app/login/login.dart';
import 'package:new_app/models/football.dart';
import 'package:new_app/pages/home/home_page.dart';
import 'package:new_app/pages/home/jeux/loup.dart';
import 'package:new_app/pages/home/jeux/monopoly.dart';
import 'package:new_app/pages/home/jeux/scrabble.dart';
import 'package:new_app/pages/home/jeux/uno.dart';
import 'package:new_app/pages/interclasse/basket/basket.dart';
import 'package:new_app/pages/interclasse/football/createMatchFootball.dart';
import 'package:new_app/pages/interclasse/football/detailFootball.dart';
import 'package:new_app/pages/interclasse/football/homeFootPage.dart';
import 'package:new_app/pages/interclasse/football/homeAdminFootballPage.dart';
import 'package:new_app/pages/interclasse/jeux%20desprit/jeuEsprit.dart';
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
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
