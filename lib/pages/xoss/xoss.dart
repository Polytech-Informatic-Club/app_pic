import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/pages/drawer/drawer.dart';
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
                        0, // Positionne l'image en dehors du bas du Container
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
            SizedBox(height: 50),
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
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                height: 170,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            " Xossna",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Image.asset("assets/images/xoss/Ellipse_green.png")
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(127, 127, 127, 1),
                                borderRadius: BorderRadius.circular(10)),
                            width: 200,
                            height: 110,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Scrollbar(
                                trackVisibility: true,
                                thumbVisibility: true,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(width: 20),
                                          Image.asset(
                                            "assets/images/xoss/Ellipse_white.png",
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "Lait",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(width: 20),
                                          Image.asset(
                                            "assets/images/xoss/Ellipse_white.png",
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "Lait",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(width: 20),
                                          Image.asset(
                                            "assets/images/xoss/Ellipse_white.png",
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "Lait",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(width: 20),
                                          Image.asset(
                                            "assets/images/xoss/Ellipse_white.png",
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "Lait",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(width: 20),
                                          Image.asset(
                                            "assets/images/xoss/Ellipse_white.png",
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "Lait",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(width: 20),
                                          Image.asset(
                                            "assets/images/xoss/Ellipse_white.png",
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "Lait",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(width: 20),
                                          Image.asset(
                                            "assets/images/xoss/Ellipse_white.png",
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "Lait",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(width: 20),
                                          Image.asset(
                                            "assets/images/xoss/Ellipse_white.png",
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "Lait",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(width: 20),
                                          Image.asset(
                                            "assets/images/xoss/Ellipse_white.png",
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "Lait",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(width: 20),
                                          Image.asset(
                                            "assets/images/xoss/Ellipse_white.png",
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "Lait",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(width: 20),
                                          Image.asset(
                                            "assets/images/xoss/Ellipse_white.png",
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "Lait",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "3000 Fcfa",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "15 fevrier",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
