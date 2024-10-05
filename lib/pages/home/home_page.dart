import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/models/jeu.dart';
import 'package:new_app/pages/home/jeux/game_screen.dart';
import 'package:new_app/pages/drawer/drawer.dart';
import 'package:new_app/pages/home/navbar.dart';
import 'package:new_app/pages/home/nouveaute.dart';
import 'package:new_app/pages/interclasse/interclasse.dart';
import 'package:new_app/services/jeu_service.dart';
import 'package:new_app/utils/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: EptDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 210,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  Image.asset(
                    'assets/images/homepage/home_top_bg.png',
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 5,
                    top: 40,
                    child: Builder(
                      builder: (context) {
                        return IconButton(
                          icon: Icon(Icons.menu),
                          color: Colors.black,
                          iconSize: 35,
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        );
                      },
                    ),
                  ),
                  Center(
                    child: Text(
                      'PolyApp',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 60,
                          fontFamily: 'LilyScriptOne'),
                    ),
                  ),
                  Positioned(
                    top: 120,
                    right: MediaQuery.of(context).size.width / 2 - 190,
                    child: Container(
                        padding: const EdgeInsets.all(2),
                        width: 88,
                        height: 117,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40)),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                  width: 1,
                                  color: jauneClair,
                                  strokeAlign: BorderSide.strokeAlignOutside),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/ept-app-46930.appspot.com/o/assets%2Fpolytech-info%2Fbde_ept.jpg?alt=media&token=12c1e41f-0d06-4068-8ac6-50e35c146140',
                              fit: BoxFit.contain,
                            ))),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Nouveaute(),

                  SizedBox(height: 30),

                  // Section Jeux
                  Text("Jeux", style: TextStyle(fontSize: 16)),
                  SizedBox(
                    height: 10,
                  ),
                  _buildGameIcons(),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: navbar(pageIndex: 2),
    );
  }
}

Widget _buildGameIcons() {
  JeuService _jeuService = JeuService();
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: FutureBuilder<List<Jeu>?>(
        future: _jeuService.getAllJeux(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Erreur lors de la récupération des données');
          } else {
            List<Jeu> jeux = snapshot.data!;
            return jeux.isNotEmpty
                ? Row(
                    children: [
                      for (var i in jeux)
                        GestureDetector(
                            onTap: () {
                              changerPage(context, GameScreen(i.id));
                            },
                            child: _buildGameIcon(
                                i.logo, i.nom, '4 joueurs en attente')),
                    ],
                  )
                : Text("Aucun jeu n'est disponible");
          }
        }),
  );
}

Widget _buildGameIcon(
    String imagePath, String gameName, String playersWaiting) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: grisClair,
            width: 3,
          ),
          image: DecorationImage(
            image: NetworkImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
      SizedBox(height: 8),
      Text(gameName),
      Text(playersWaiting,
          style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
    ],
  );
}
