import 'package:flutter/material.dart';
import 'package:new_app/utils/AppColors.dart';
import 'package:new_app/widgets/submitedButton.dart';

class ScrabbleGameScreen extends StatelessWidget {
  const ScrabbleGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image de fond
          Container(
            height: 310,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/homepage/jeux_top_bg.png'), // Image de fond à ajouter dans 'assets'
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Contenu de la page
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30), // Pour espacer du haut de l'écran

                // Bouton retour
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),

                SizedBox(height: 20),

                // Logo UNO
                Center(
                  child: Image.asset(
                    'assets/images/homepage/scrabble.jpg', // Image UNO dans 'assets'
                    height: 150,
                  ),
                ),

                SizedBox(height: 10),

                // Texte UNO
                Center(
                  child: Text(
                    "Scrabble",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),

                SizedBox(height: 40),

                // Règles du jeu
                Text(
                  "Règles:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Lorem ipsum dolor sit amet consectetur. Quisita vestibulum nisi non molestie sollicitudin porta posuere eget. Ut ut aliquet nisi felis euismod.",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 10),
                Text(
                  "In sed fermentum massa. Phasellus ornare et adipiscing id fermentum aliquet sit sagittis.",
                  style: TextStyle(fontSize: 16),
                ),

                SizedBox(height: 30),

                // Joueurs
                Text(
                  "Joueurs:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Il y a 4 joueurs en attente à H4",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sir_Noddles"),
                      Text("Amath_Thiam"),
                      Text("Fatah_la_victime"),
                      Text("COD"),
                    ],
                  ),
                ),

                SizedBox(height: 10),

                // Bouton "Rejoindre"
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: grisClair,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Rejoindre',
                    style: TextStyle(fontSize: 13, color: Colors.black),
                  ),
                ),

                SizedBox(height: 20),

                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: orange,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Créer une session',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                ),
                // Bouton "Créer une session"

                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
