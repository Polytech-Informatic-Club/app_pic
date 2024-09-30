import 'package:flutter/material.dart';
import 'package:new_app/pages/annonce/hot_topic.dart';
import 'package:new_app/pages/annonce/p_info_nouveaute.dart';
import 'package:new_app/utils/app_colors.dart';
import 'package:new_app/widgets/ept_button.dart';
import 'package:new_app/pages/drawer/drawer.dart';
import 'package:new_app/pages/home/navbar.dart';

class Annonce extends StatefulWidget {
  const Annonce({super.key});

  @override
  State<Annonce> createState() => _AnnonceState();
}

class _AnnonceState extends State<Annonce> {
  bool annonceAvailable = true;
  bool isAdmin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Icon(
              Icons.menu,
              size: 35,
            ),
          );
        }),
        title: Text('Polytech Info'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      drawer: EptDrawer(),
      bottomNavigationBar: navbar(pageIndex: 1),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
        children: [
          widgetAG('Jeudi 15 Octobre', '19h30', 'Case des Polytechniciens',
              'Divers'),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 50),
            child: Column(
              children: [
                // if (annonceAvailable) ...[
                //   Row(
                //     children: [
                //       AssembleeGeneraleItem(
                //           date: "Jeudi 13 Juin",
                //           time: "22h30",
                //           location: "Case de Polytechniciens",
                //           topic: "Divers"),
                //     ],
                //   ),
                //   const SizedBox(
                //     height: 20,
                //   ),
                //   if (isAdmin) ...[
                //     EptButton(
                //       title: "Annoncer",
                //       width: 150,
                //       height: 40,
                //       borderRadius: 5,
                //     )
                //   ],
                //   const SizedBox(
                //     height: 40,
                //   ),
                // ],

                const PInfoNouveaute(),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: 250,
                  height: 3,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 30,
                ),
                const HotTopic(),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

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
