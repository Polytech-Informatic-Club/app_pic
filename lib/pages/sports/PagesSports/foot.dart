import 'package:flutter/material.dart';
import 'package:new_app/widgets/reusable_widgets.dart';

class FootballPage extends StatefulWidget {
  const FootballPage({super.key});

  @override
  _FootballPageState createState() => _FootballPageState();
}

class _FootballPageState extends State<FootballPage> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.orange.withOpacity(0.5),
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  Image.asset(
                    'assets/images/football/foot_top_bg.jpg',
                    height: 200,
                    fit: BoxFit.cover,
                    opacity: AlwaysStoppedAnimation(0.3),
                  ),
                  Positioned(
                    left: 10,
                    top: 50,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 160,
                    left: MediaQuery.of(context).size.width / 2 - 50,
                    child: Image.asset(
                      "assets/images/foot.webp",
                      width: 100,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 60),
            Text(
              'Football',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MemberCard(title: 'Président'),
                      SizedBox(
                        width: 10,
                      ),
                      MemberCard(title: 'Vice-Président'),
                    ],
                  ),
                  SizedBox(height: 20),
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
                  Column(
                    children: [
                      buildMatchCard(
                          '',
                          'Mercredi 5 Juin',
                          'assets/images/Competition/logo50.png',
                          'TC2: 450',
                          'assets/images/Competition/logo50.png',
                          'TC1: 150'),
                      buildMatchCard(
                          '',
                          'Mercredi 5 Juin',
                          'assets/images/Competition/logo50.png',
                          'TC2: 450',
                          'assets/images/Competition/logo50.png',
                          'TC1: 150'),
                      buildMatchCard(
                          '',
                          'Mercredi 5 Juin',
                          'assets/images/Competition/logo50.png',
                          'TC2: 450',
                          'assets/images/Competition/logo50.png',
                          'TC1: 150'),
                    ],
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
        // leading: Image.network(
        //   'https://example.com/team_logo.png',
        //   width: 50,
        // ),
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
