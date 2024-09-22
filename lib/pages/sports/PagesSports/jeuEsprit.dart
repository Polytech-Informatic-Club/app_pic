import 'package:flutter/material.dart';

class JEspritPage extends StatefulWidget {
  const JEspritPage({super.key});

  @override
  _JEspritPageState createState() => _JEspritPageState();
}

class _JEspritPageState extends State<JEspritPage> {
  List<Widget> matchs = [
    MatchCard(),
    MatchCard(),
    MatchCard(),
  ];

  void addMatch() {
    setState(() {
      matchs.add(MatchCard());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jeux d\'esprit'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Image.network(
                  'https://example.com/assets/images/jeux-desprit/WhatsApp Image 2024-06-07 at 19.41.17_1c69ac4e.jpg',
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
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Positioned(
                  top: 160,
                  left: MediaQuery.of(context).size.width / 2 - 50,
                  child: Image.asset(
                    "assets/images/assets/images/jeux-desprit/logo jeux desprit.png",
                    width: 100,
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),
            Text(
              'Jeux d\'esprit',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Scrolling horizontal pour les membres
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  MemberCard(title: 'Président'),
                  MemberCard(title: 'Vice-Président'),
                  MemberCard(title: 'Membre'),
                  MemberCard(title: 'Membre'),
                  MemberCard(title: 'Membre'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Prochain-évènement',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 100,
                    color: Colors.grey[300],
                    child: Center(
                      child: Icon(Icons.play_arrow, size: 50),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Lorem ipsum dolor sit amet consectetur. Quis faucibus lacus integer nisi. Aenean amet amet libero duis sollicitudin blandit sed...',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Matchs',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: matchs,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: addMatch,
                    child: Text('Ajouter un match'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MemberCard extends StatelessWidget {
  final String title;
  const MemberCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[300],
        ),
        SizedBox(height: 5),
        Text(title),
      ],
    );
  }
}

class MatchCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
          'https://example.com/team_logo.png',
          width: 50,
        ),
        title: Text('Mercredi 5 Juin'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('TC2: 430', style: TextStyle(color: Colors.green)),
                Text('TC1: 190', style: TextStyle(color: Colors.red)),
              ],
            ),
            SizedBox(height: 5), // Espace entre les lignes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('DIC1: 400', style: TextStyle(color: Colors.green)),
                Text('DIC2: 190', style: TextStyle(color: Colors.red)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
