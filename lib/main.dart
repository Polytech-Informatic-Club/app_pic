// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:new_app/UserPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:new_app/inscription.dart';
import 'package:new_app/login.dart';
import 'package:new_app/pages/home/home_page.dart';
import 'package:new_app/pages/sports/PagesSports/foot.dart';
import 'package:new_app/pages/sports/interclasse.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Interclasse(),
    );
  }
}
