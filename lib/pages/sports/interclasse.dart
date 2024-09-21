import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/pages/home/home_page.dart';
import 'package:new_app/pages/home/navbar.dart';
import 'package:new_app/pages/sports/PagesSports/foot.dart';
import 'package:new_app/utils/AppColors.dart';

class Interclasse extends StatelessWidget {
  const Interclasse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: navbar(pageIndex: 3),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 170,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/Competition/top_bg_interclasse.png',
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.menu,
                          size: 35,
                          color: Colors.black,
                        ),
                        alignment: AlignmentDirectional.topStart,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 70,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Interclasses',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 33,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sous-Commissions',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  // TextField(
                  //   decoration: InputDecoration(
                  //     hintText: 'Chercher',
                  //     prefixIcon: Icon(Icons.search),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(color: grisClair),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildCircularIcon(
                            'assets/images/foot.png', FootballPage()),
                        _buildCircularIcon(
                            'assets/images/Competition/logo_basket.png',
                            HomePage()),
                        _buildCircularIcon(
                            'assets/images/Competition/logo jeux desprit.png',
                            HomePage()),
                        _buildCircularIcon(
                            'assets/images/Competition/logo_volley.png',
                            HomePage()),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Derniers matchs',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  _buildMatchCard('Génie en herbe', 'Mercredi 5 Juin',
                      'TC2: 450', 'TC1: 150'),
                  SizedBox(height: 8),
                  _buildMatchCard(
                      'Basket', 'Lundi 3 Juin', 'DIC3: 120', 'TC2: 88'),
                  SizedBox(height: 24),
                  Text(
                    'Matchs à venir',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.all(20),
                    width: 500,
                    decoration: BoxDecoration(
                      color: orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _afficheMatch('assets/images/interclasseBasket.jpg',
                              'Mardi 15 Juin'),
                          SizedBox(
                            width: 12,
                          ),
                          _afficheMatch('assets/images/interclasseBasket.jpg',
                              'Mardi 15 Juin'),
                          SizedBox(
                            width: 12,
                          ),
                          _afficheMatch('assets/images/interclasseBasket.jpg',
                              'Mardi 15 Juin'),
                          SizedBox(
                            width: 12,
                          ),
                          _afficheMatch('assets/images/interclasseBasket.jpg',
                              'Mardi 15 Juin'),
                          SizedBox(
                            width: 12,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _afficheMatch(affiche, date) {
    return Column(
      children: [
        Image.asset(
          affiche,
          width: 100,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          date,
          style: TextStyle(fontSize: 12),
        )
      ],
    );
  }

  Widget _buildCircularIcon(String assetPath, page) {
    return ClipOval(child: Builder(builder: (context) {
      return Material(
          child: InkWell(
        onTap: () {
          changerPage(context, page);
        },
        child: Image.asset(
          assetPath,
          height: 70,
        ),
      ));
    }));
  }

  Widget _buildMatchCard(
      String title, String date, String score1, String score2) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        Container(
          decoration: BoxDecoration(
              color: grisClair, borderRadius: BorderRadius.circular(6)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(date),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/Competition/logo50.png',
                          width: 60,
                        ),
                        Text(score1),
                      ],
                    ),
                    Row(
                      children: [
                        Text(score2),
                        Image.asset(
                          'assets/images/Competition/logo50.png',
                          width: 60,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
