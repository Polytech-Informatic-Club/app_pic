import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/models/match.dart';
import 'package:new_app/pages/home/home_page.dart';
import 'package:new_app/pages/home/navbar.dart';
import 'package:new_app/pages/sports/football/detailFootball.dart';
import 'package:new_app/pages/sports/football/homeFootPage.dart';
import 'package:new_app/services/SportService.dart';
import 'package:new_app/utils/AppColors.dart';

class InterclassePage extends StatelessWidget {
  InterclassePage({super.key});

  SportService _sportService = new SportService();

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
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/Competition/top_bg_interclasse.png',
                    fit: BoxFit.cover,
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
                            'assets/images/foot.png', HomeFootballPage()),
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
                  FutureBuilder<List<Matches>>(
                      future: _sportService.getLastMatch(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Erreur lors du chargement');
                        } else {
                          List<Matches> matches = snapshot.data ?? [];
                          return Column(
                            children: [
                              for (var i in matches)
                                Column(
                                  children: [
                                    _buildMatchCard(
                                        context,
                                        i.sport.name,
                                        i.date,
                                        i.equipeA.nom,
                                        i.equipeB.nom,
                                        i.scoreEquipeA.toString(),
                                        i.scoreEquipeB.toString(),
                                        "",
                                        ""),
                                    SizedBox(height: 8),
                                  ],
                                )
                            ],
                          );
                        }
                      }),

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
                      child: FutureBuilder<List<Matches>>(
                          future: _sportService.getLastMatch(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Erreur lors du chargement');
                            } else {
                              List<Matches> matches = snapshot.data ?? [];
                              return Row(
                                children: [
                                  for (var i in matches)
                                    Column(
                                      children: [
                                        _afficheMatch(
                                            i.photo ?? '', i.date, context),
                                        SizedBox(
                                          width: 12,
                                        ),
                                      ],
                                    )
                                ],
                              );
                            }
                          }),
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

  Widget _afficheMatch(String affiche, DateTime date, BuildContext context) {
    return GestureDetector(
        onTap: () => changerPage(context, DetailFootballScreen()),
        child: Column(
          children: [
            affiche != ""
                ? Image.network(
                    affiche,
                    width: 100,
                  )
                : Container(
                    height: MediaQuery.sizeOf(context).height * 0.15,
                    decoration: BoxDecoration(
                        color: AppColors.gray,
                        borderRadius: BorderRadius.circular(10)),
                  ),
            SizedBox(
              height: 5,
            ),
            Text(
              simpleDateformat(date),
              style: TextStyle(fontSize: 12),
            )
          ],
        ));
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
      BuildContext context,
      String title,
      DateTime date,
      String equipe1,
      String equipe2,
      String score1,
      String score2,
      String photo1,
      String photo2) {
    return GestureDetector(
        onTap: () => changerPage(context, DetailFootballScreen()),
        child: Column(
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              decoration: BoxDecoration(
                  color: grisClair, borderRadius: BorderRadius.circular(6)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(dateCustomformat(date)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/Competition/logo50.png',
                              width: 60,
                            ),
                            Row(
                              children: [
                                Text(equipe1 + " : "),
                                Text(score1),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Text(equipe2 + " : "),
                                Text(score2),
                              ],
                            ),
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
        ));
  }
}
