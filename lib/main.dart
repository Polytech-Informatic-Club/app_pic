// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:new_app/login/inscription.dart';
import 'package:new_app/login/login.dart';
import 'package:new_app/pages/home/home_page.dart';
import 'package:new_app/pages/sports/football/detailFootball.dart';
import 'package:new_app/pages/sports/football/homeFootPage.dart';
import 'package:new_app/pages/sports/interclasse.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting('fr', null);  // Initialisation de la locale française
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
