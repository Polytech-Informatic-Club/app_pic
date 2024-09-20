import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/pages/home/home_page.dart';
import 'package:new_app/pages/home/navbar.dart';
import 'package:new_app/pages/sports/PagesSports/foot.dart';

class Interclasse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF9800),
        title: Text('Interclasse'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      bottomNavigationBar:
          navbar(pageIndex: 3), // Assuming you have a navbar widget
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildCircularIcon('assets/images/foot.png', FootballPage()),
                  _buildCircularIcon('assets/images/foot.png', HomePage()),
                  _buildCircularIcon('assets/images/foot.png', HomePage()),
                  _buildCircularIcon('assets/images/foot.png', HomePage()),
                ],
              ),
              SizedBox(height: 24),
              Text(
                'Derniers matchs',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _buildMatchCard(
                  'Génie en herbe', 'Mercredi 5 Juin', 'TC2: 450', 'TC1: 150'),
              SizedBox(height: 8),
              _buildMatchCard('Basket', 'Lundi 3 Juin', 'DIC3: 120', 'TC2: 88'),
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
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20)),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _afficheMatch('assets/images/interclasseBasket.jpg',
                          'Mardi 15 Juin'),
                      SizedBox(
                        width: 10,
                      ),
                      _afficheMatch('assets/images/interclasseBasket.jpg',
                          'Mardi 15 Juin'),
                      SizedBox(
                        width: 10,
                      ),
                      _afficheMatch('assets/images/interclasseBasket.jpg',
                          'Mardi 15 Juin'),
                      SizedBox(
                        width: 10,
                      ),
                      _afficheMatch('assets/images/interclasseBasket.jpg',
                          'Mardi 15 Juin'),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
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
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(date),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(score1),
                    Text(score2),
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
