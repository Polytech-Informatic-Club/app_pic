import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/pages/home/appDrawer.dart';
import 'package:new_app/pages/home/navbar.dart';
import 'package:new_app/pages/interclasse/football/homeFootPage.dart';
import 'package:new_app/pages/interclasse/interclasse.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      drawer: Appdrawer(),
      body: ListView(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.sizeOf(context).width * 0.07),
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset(
                'assets/images/homepage/background.png',
                height: 200,
                fit: BoxFit.cover,
              ),
              Container(
                width: double.infinity,
                height: 200,
                color: Colors.orange.withOpacity(0.5),
              ),
              Positioned(
                left: 10,
                top: 10,
                child: Builder(
                  builder: (context) {
                    return DrawerButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  },
                ),
              ),
              Positioned(
                top: 100,
                right: MediaQuery.of(context).size.width / 2 - 180,
                child: Image.asset(
                  "assets/images/homepage/profile.png",
                  width: 50,
                ),
              ),
            ],
          ),

          // Section Nouveautés
          _buildSectionTitle('Nouveautés', context,
              ['Polytech-Info', 'Interclasses', 'Commerces']),
          SizedBox(height: 16),
          _buildEventCards(),
          SizedBox(height: 32),

          // Section Jeux
          _buildSectionTitle('Jeux', context, []),
          _buildGameIcons(),
        ],
      ),
      bottomNavigationBar: navbar(pageIndex: 2),
    );
  }
}

Widget _buildSectionTitle(
    String title, BuildContext context, List<String> tabs) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Row(
            children: [
              Text('voir tout',
                  style: TextStyle(fontSize: 16, color: Colors.red)),
              Icon(
                Icons.arrow_forward_sharp,
                color: Colors.red,
                size: 16,
              )
            ],
          )
        ],
      ),
      SizedBox(
        height: 10,
      ),
      if (tabs.isNotEmpty)
        Row(
          children: tabs.map((tab) {
            return GestureDetector(
                onTap: () {
                  changerPage(context, InterclassePage());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    tab,
                    style: TextStyle(
                        fontSize: 16,
                        color: tab == 'Polytech-Info'
                            ? Colors.black
                            : Colors.grey),
                  ),
                ));
          }).toList(),
        ),
    ],
  );
}

Widget _buildEventCards() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        _buildEventCard('assets/basketball.png', 'Demi-Finale de Basketball',
            'Mardi 6 Juin 21h45'),
        _buildEventCard('assets/conference.png',
            'Conférence de Maitre Djiby Mang', '6 Aout 19h00'),
        _buildEventCard(
            'assets/fire_camp.png', 'Feu de Camp', 'Samedi 01 Juillet 23h30'),
      ],
    ),
  );
}

Widget _buildEventCard(String imagePath, String title, String date) {
  return Card(
    margin: EdgeInsets.only(right: 16),
    child: Container(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(imagePath,
              fit: BoxFit.cover, height: 150, width: double.infinity),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(date, style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    ),
  );
}

Widget _buildGameIcons() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        _buildGameIcon('assets/images/homepage/loup_garou.jpg', 'Loup-Garou',
            '4 joueurs en attente'),
        _buildGameIcon(
            'assets/images/homepage/uno.jpg', 'UNO', '4 joueurs en attente'),
        _buildGameIcon('assets/images/homepage/monopoly.png', 'Monopoly',
            '4 joueurs en attente'),
        _buildGameIcon('assets/images/homepage/scrabble.jpg', 'Scrabble',
            '4 joueurs en attente'),
      ],
    ),
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
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
      SizedBox(height: 8),
      Text(gameName),
      Text(playersWaiting, style: TextStyle(color: Colors.grey, fontSize: 12)),
    ],
  );
}
