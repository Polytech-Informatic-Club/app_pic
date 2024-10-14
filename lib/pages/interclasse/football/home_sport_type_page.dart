// ignore_for_file: must_be_immutable, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/models/commission.dart';
import 'package:new_app/models/match.dart';
import 'package:new_app/models/membre.dart';
import 'package:new_app/pages/interclasse/football/detail_match.dart';
import 'package:new_app/services/sport_service.dart';
import 'package:new_app/utils/app_colors.dart';
import 'package:new_app/widgets/match_card.dart';

class HomeSportTypePage extends StatefulWidget {
  String typeSport;
  String bgImage;
  String icone;
  HomeSportTypePage(this.typeSport, this.bgImage, this.icone, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeSportTypePageState createState() =>
      // ignore: unnecessary_this
      _HomeSportTypePageState(this.typeSport, this.bgImage, this.icone);
}

class _HomeSportTypePageState extends State<HomeSportTypePage> {
  final String _typeSport;
  final String _bgImage;
  final String _icone;
  _HomeSportTypePageState(
    this._typeSport,
    this._bgImage,
    this._icone,
  );
  final SportService _sportService = SportService();
  String nomSport = "";

  Future<void> getNomSport() async {
    if (_typeSport == "FOOTBALL") {
      nomSport = "Football";
    } else if (_typeSport == "BASKETBALL") {
      nomSport = "Basketball";
    } else if (_typeSport == "JEUX_ESPRIT") {
      nomSport = "Jeux d'Esprit";
    } else if (_typeSport == "VOLLEYBALL") {
      nomSport = "Volleyball";
    }
  }

  @override
  void initState() {
    super.initState();
    getNomSport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    _bgImage,
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
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50,
                      backgroundImage: AssetImage(
                        _icone,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 60),
            Center(
                child: Text(
              nomSport,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Membres',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  FutureBuilder<Commission?>(
                      future: _sportService.getMembresCommission(_typeSport),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Erreur lors du chargement');
                        } else {
                          Commission? commissions = snapshot.data;
                          return commissions != null
                              ? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      for (var i in commissions.membres)
                                        MemberCard(role: i.poste)
                                    ],
                                  ))
                              : Text(
                                  "Aucun membre de la sous-commission ${_typeSport.split("_").join(" ").toLowerCase()}");
                        }
                      }),
                  SizedBox(height: 20),
                  Text(
                    'Prochain-évènement',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  FutureBuilder<Matches?>(
                      future: _sportService.getTheFollowingMatch(_typeSport),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Erreur lors du chargement');
                        } else {
                          Matches? followingMatch = snapshot.data;
                          return followingMatch != null
                              ? _afficheFollowingMatch(
                                  followingMatch.id,
                                  followingMatch.photo!,
                                  followingMatch.description!,
                                  followingMatch.sport.name.split(".").last,
                                  context)
                              : Text(
                                  "Aucun match n'est prévu dans les jours à venir");
                        }
                      }),
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
                  FutureBuilder<List<Matches>>(
                      future: _sportService.getListMatchFootball(_typeSport),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Erreur lors du chargement');
                        } else {
                          List<Matches> matches = snapshot.data ?? [];
                          print("SALLOS ??${matches.length.toString()}");
                          return matches.isEmpty
                              ? Text("Aucun match trouvé")
                              : Column(
                                  children: [
                                    for (var i in matches.reversed)
                                      Column(
                                        children: [
                                          buildMatchCard(
                                              context,
                                              i.id,
                                              simpleDateformat(i.date),
                                              i.equipeA.nom,
                                              i.equipeB.nom,
                                              i.scoreEquipeA,
                                              i.scoreEquipeB,
                                              i.equipeA.logo,
                                              i.equipeB.logo,
                                              DetailMatchScreen(
                                                  i.id,
                                                  i.sport.name
                                                      .split(".")
                                                      .last)),
                                          SizedBox(height: 8),
                                        ],
                                      )
                                  ],
                                );
                        }
                      }),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _afficheFollowingMatch(String id, String affiche, String description,
    String typeSport, BuildContext context) {
  return GestureDetector(
      onTap: () => changerPage(context, DetailMatchScreen(id, typeSport)),
      child: Column(
        children: [
          affiche != ""
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    affiche,
                    height: description != ""
                        ? MediaQuery.sizeOf(context).height * 0.2
                        : MediaQuery.sizeOf(context).height * 0.3,
                    width: double.infinity,
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
            description,
            // simpleDateformat(date),
            style: TextStyle(fontSize: 12),
          )
        ],
      ));
}

class MemberCard extends StatelessWidget {
  final String role;
  const MemberCard({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            role,
            style: TextStyle(fontSize: 12),
          ),
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.primary,
            backgroundImage: AssetImage('assetName'),
          ),
          Text(
            'Mouhamadou Mourtada Kamara',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
