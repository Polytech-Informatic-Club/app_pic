import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/pages/drawer.dart';
import 'package:new_app/pages/home/navbar.dart';
import 'package:new_app/pages/xoss/historique_xoss.dart';
import 'package:new_app/utils/app_colors.dart';

class Xoss extends StatelessWidget {
  const Xoss({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: EptDrawer(),
      bottomNavigationBar: navbar(pageIndex: 0),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromRGBO(250, 242, 230, 1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Stack(
                clipBehavior:
                    Clip.none, // Permet à l'image de sortir du Container
                children: [
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
                  Positioned(
                    bottom:
                        -78, // Positionne l'image en dehors du bas du Container
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/images/xoss/xoss_card.png',
                      width: 100, // Spécifiez une largeur si nécessaire
                    ),
                  ),
                  Positioned(
                    bottom:
                        -20, // Positionne l'image en dehors du bas du Container
                    left: -100,
                    right: 0,
                    child: Column(
                      children: [
                        Text(
                          'Elimane Sall',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '20000 Fcfa',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {
                changerPage(context, HistoriqueXoss());
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(244, 171, 90, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              child: const Text(
                'Historique',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                SizedBox(width: 15),
                Text(
                  'Mes khoss',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
