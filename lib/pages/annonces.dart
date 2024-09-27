import 'package:flutter/material.dart';
import 'package:new_app/pages/home/app_drawer.dart';
import 'package:new_app/pages/home/navbar.dart';
import 'package:new_app/utils/app_colors.dart';

class Annonces extends StatelessWidget {
  const Annonces({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Polytech Info'),
        centerTitle: true,
      ),
      drawer: Appdrawer(),
      // bottomNavigationBar: navbar(pageIndex: 1),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widgetAG(
                'Jeudi 13 Juin', '22h30', 'Case des Polytechniciens', 'Divers'),

            // Bouton Annonce
            // Center(
            //   child: ElevatedButton(
            //     onPressed: () {},
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: orange,
            //       padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //     ),
            //     child: Text('Annonce',
            //         style: TextStyle(fontSize: 16, color: Colors.white)),
            //   ),
            // ),

            SizedBox(height: 20),

            // Section Catégories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Nouveautés",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  buildCategoryIcon(
                      'assets/images/polytech-Info/logo sc-medicale.png'),
                  buildCategoryIcon(
                      'assets/images/polytech-Info/logo sc-medicale.png'),
                  buildCategoryIcon(
                      'assets/images/polytech-Info/logo sc-medicale.png'),
                  buildCategoryIcon(
                      'assets/images/polytech-Info/logo sc-medicale.png'),
                  buildCategoryIcon(
                      'assets/images/polytech-Info/logo sc-medicale.png'),
                  buildCategoryIcon(
                      'assets/images/polytech-Info/logo sc-medicale.png'),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Section Hot-Topics
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Hot-Topics",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // Fonction pour construire les icônes de catégories
  Widget buildCategoryIcon(String assetPath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CircleAvatar(
        radius: 20,
        backgroundImage: AssetImage(assetPath),
      ),
    );
  }

  // Fonction pour construire une section de "Hot-Topics"
  Widget buildHotTopic(String title, String author, String assetPath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(assetPath),
                    radius: 30,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(author, style: TextStyle(fontSize: 14)),
                      Text("#33 GC", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

@override
Widget widgetAG(String date, String heure, String lieu, String sujet) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Stack(
      children: [
        // Image de fond avec les personnes et le tableau
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0), color: jauneClair),
          height: 200,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Assemblée Générale",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 20,
                      ),
                      SizedBox(width: 4),
                      Text(
                        date,
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 20,
                      ),
                      SizedBox(width: 4),
                      Text(
                        heure,
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.apartment,
                        size: 20,
                      ),
                      SizedBox(width: 4),
                      Text(
                        lieu,
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.category,
                        size: 20,
                      ),
                      SizedBox(width: 4),
                      Text(
                        sujet,
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Action pour "Voir communiqué"
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    child: Text(
                      "Voir communiqué",
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                ],
              ),
              // Image de l'horloge à droite
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 150.0),
          child: SizedBox(
            height: 220,
            child: Image.asset(
              'assets/images/polytech-Info/schedule.png', // Chemin vers l'image de l'horloge
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
      ],
    ),
  );
}
