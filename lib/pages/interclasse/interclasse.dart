import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/models/match.dart';
import 'package:new_app/pages/home/app_drawer.dart';
import 'package:new_app/pages/home/home_page.dart';
import 'package:new_app/pages/home/navbar.dart';
import 'package:new_app/pages/interclasse/basket/basket.dart';
import 'package:new_app/pages/interclasse/football/allMatch.dart';
import 'package:new_app/pages/interclasse/football/detailFootball.dart';
import 'package:new_app/pages/interclasse/football/homeFootPage.dart';
import 'package:new_app/pages/interclasse/jeux%20desprit/jeuEsprit.dart';
import 'package:new_app/pages/interclasse/volley/volley.dart';
import 'package:new_app/services/sport_service.dart';
import 'package:new_app/utils/app_colors.dart';
import 'package:new_app/widgets/match_card.dart';

// ignore: must_be_immutable
class InterclassePage extends StatelessWidget {
  InterclassePage({super.key});

  SportService _sportService = new SportService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: navbar(pageIndex: 3),
      drawer: Appdrawer(),
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
                      Builder(builder: (context) {
                        return IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: Icon(
                            Icons.menu,
                            size: 35,
                            color: Colors.black,
                          ),
                          alignment: AlignmentDirectional.topStart,
                        );
                      }),
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
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(color: grisClair),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildCircularIcon('assets/images/foot.png',
                            HomeFootballPage("FOOTBALL")),
                        _buildCircularIcon(
                            'assets/images/Competition/logo_basket.png',
                            HomeFootballPage("BASKETBALL")),
                        _buildCircularIcon(
                            'assets/images/Competition/logo jeux desprit.png',
                            HomeFootballPage("GENIE_EN_HERBE")),
                        _buildCircularIcon(
                            'assets/images/Competition/logo_volley.png',
                            HomeFootballPage("VOLLEYBALL")),
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
                                    Text(i.sport.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    buildMatchCard(
                                        context,
                                        i.id,
                                        dateCustomformat(i.date),
                                        i.equipeA.nom,
                                        i.equipeB.nom,
                                        i.scoreEquipeA,
                                        i.scoreEquipeB,
                                        i.equipeA.logo,
                                        i.equipeA.logo,
                                        DetailFootballScreen(i.id,
                                            i.sport.name.split(".").last)),
                                    SizedBox(height: 8),
                                  ],
                                )
                            ],
                          );
                        }
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Matchs à venir',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () => changerPage(context, AllMatch()),
                        child: Text(
                          "Voir tout",
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: 500,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: FutureBuilder<List<Matches>>(
                          future: _sportService.getNextMatch(),
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
                                    Row(
                                      children: [
                                        _afficheMatch(
                                            i.id,
                                            i.photo ?? '',
                                            i.date,
                                            i.sport.name.split(".").last,
                                            context),
                                        SizedBox(
                                          width: 10,
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

  Widget _afficheMatch(String id, String affiche, DateTime date,
      String typeSport, BuildContext context) {
    return GestureDetector(
        onTap: () => changerPage(context, DetailFootballScreen(id, typeSport)),
        child: Column(
          children: [
            affiche != ""
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      affiche,
                      height: MediaQuery.sizeOf(context).height * 0.17,
                    ))
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
}
