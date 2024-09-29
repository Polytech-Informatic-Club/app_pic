// ignore_for_file: no_logic_in_create_state

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/models/football.dart';
import 'package:new_app/models/joueur.dart';
import 'package:new_app/models/match.dart';
import 'package:new_app/services/sport_service.dart';
import 'package:new_app/utils/app_colors.dart';
import 'package:new_app/widgets/comment_widget.dart';
import 'package:new_app/widgets/delete_confirmed_dialog.dart';
import 'package:new_app/widgets/reusable_comment_input.dart';
import 'package:new_app/widgets/reusable_statistic_card.dart';
import 'package:new_app/widgets/update_statistic_dialog.dart';

// ignore: must_be_immutable
class AdministrateOneFootball extends StatefulWidget {
  String id;
  String typeSport;
  AdministrateOneFootball(this.id, this.typeSport, {super.key});

  @override
  State<AdministrateOneFootball> createState() =>
      _AdministrateOneFootballState(id, typeSport);
}

class _AdministrateOneFootballState extends State<AdministrateOneFootball> {
  final SportService _sportService = SportService();
  final String _id;
  final String _typeSport;
  _AdministrateOneFootballState(this._id, this._typeSport);

  final ValueNotifier<bool> _isPressCommment = ValueNotifier<bool>(false);
  ValueNotifier<dynamic> matchProvider = ValueNotifier<dynamic>(null);

  final TextEditingController _commentairController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.orange[50],
      appBar: AppBar(
        backgroundColor: jauneClair,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Gérer le match",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<dynamic>(
            future: _sportService.getMatchById(_id, _typeSport),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Erreur lors de la récupération du rôle');
              } else {
                // ignore: no_leading_underscores_for_local_identifiers
                final _match = snapshot.data;
                matchProvider.value = _match;
                return _match == null
                    ? CircularProgressIndicator()
                    : ValueListenableBuilder<dynamic>(
                        valueListenable: matchProvider,
                        // ignore: no_leading_underscores_for_local_identifiers
                        builder: (context, _matchProvider, child) {
                          return Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(color: jauneClair),
                                padding: EdgeInsets.only(bottom: 20),
                                child: Column(
                                  children: [
                                    SizedBox(height: 20),
                                    // _Match Information
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            CircleAvatar(
                                                radius:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.1,
                                                backgroundImage: NetworkImage(
                                                  matchProvider
                                                      .value!.equipeA.logo,
                                                )),
                                            SizedBox(height: 10),
                                            Text(
                                              matchProvider.value!.equipeA.nom,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "VS",
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Column(
                                          children: [
                                            CircleAvatar(
                                                radius:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.1,
                                                backgroundImage: NetworkImage(
                                                  matchProvider
                                                      .value!.equipeB.logo,
                                                )),
                                            SizedBox(height: 10),
                                            Text(
                                              matchProvider.value!.equipeB.nom,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    // Score
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 35),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 40),
                                      decoration: BoxDecoration(
                                        color: orange,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Row(children: [
                                                    Text(
                                                      matchProvider
                                                          .value!.scoreEquipeA
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 32,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    if (_typeSport ==
                                                        "FOOTBALL")
                                                      IconButton(
                                                        onPressed: () async {
                                                          Map<String, dynamic>
                                                              resultat =
                                                              await showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return updateGoldDialog(
                                                                context,
                                                                matchProvider
                                                                    .value!
                                                                    .equipeA
                                                                    .joueurs,
                                                              );
                                                            },
                                                          );

                                                          Joueur? joueur =
                                                              resultat[
                                                                  "joueur"];
                                                          int? minute =
                                                              resultat[
                                                                  "minute"];
                                                          if (joueur != null) {
                                                            matchProvider
                                                                    .value =
                                                                await _sportService.addButeur(
                                                                    matchProvider
                                                                        .value!
                                                                        .id,
                                                                    joueur,
                                                                    minute!,
                                                                    "scoreEquipeA",
                                                                    "buteursA");
                                                          }
                                                        },
                                                        icon: Icon(
                                                          Icons.edit,
                                                          color:
                                                              AppColors.white,
                                                        ),
                                                      ),
                                                  ]),
                                                  Container(
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.1,
                                                      child:
                                                          SingleChildScrollView(
                                                              child: Column(
                                                        children: [
                                                          for (var butteur
                                                              in matchProvider
                                                                  .value!
                                                                  .buteursA!)
                                                            Text(
                                                              "${butteur.joueur.nom} (${butteur.minute}')",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                        ],
                                                      )))
                                                ],
                                              ),
                                              Text(
                                                "-",
                                                style: TextStyle(
                                                    fontSize: 32,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              Column(
                                                children: [
                                                  Row(children: [
                                                    Text(
                                                      matchProvider
                                                          .value!.scoreEquipeB
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 32,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    if (_typeSport ==
                                                        "FOOTBALL")
                                                      IconButton(
                                                        onPressed: () async {
                                                          Map<String, dynamic>
                                                              resultat =
                                                              await showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return updateGoldDialog(
                                                                context,
                                                                matchProvider
                                                                    .value!
                                                                    .equipeA
                                                                    .joueurs,
                                                              );
                                                            },
                                                          );

                                                          Joueur? joueur =
                                                              resultat[
                                                                  "joueur"];
                                                          int? minute =
                                                              resultat[
                                                                  "minute"];
                                                          if (joueur != null) {
                                                            matchProvider
                                                                    .value =
                                                                await _sportService.addButeur(
                                                                    matchProvider
                                                                        .value!
                                                                        .id,
                                                                    joueur,
                                                                    minute!,
                                                                    "scoreEquipeB",
                                                                    "buteursB");
                                                          }
                                                        },
                                                        icon: Icon(
                                                          Icons.edit,
                                                          color:
                                                              AppColors.white,
                                                        ),
                                                      ),
                                                  ]),
                                                  Container(
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.1,
                                                      child:
                                                          SingleChildScrollView(
                                                              child: Column(
                                                        children: [
                                                          for (var butteur
                                                              in matchProvider
                                                                  .value!
                                                                  .buteursB!)
                                                            Text(
                                                              "${butteur.joueur.nom} (${butteur.minute}')",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                        ],
                                                      )))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              // Statistiques

                              Text(
                                "Statistiques",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              // Statistics Row
                              if (_typeSport == "FOOTBALL")
                                statisticFootballCard(
                                    matchProvider, context, _sportService),
                              if (_typeSport == "BASKETBALL")
                                statisticBasketballCard(
                                    matchProvider, context, _sportService),
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 100.0),
                                child: Divider(
                                  color: Colors.black,
                                ),
                              ),
                              // SECTION LIKE
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                          icon: Icon(
                                            Icons.thumb_up,
                                            color: matchProvider.value!.likers!
                                                    .any((liker) =>
                                                        liker!.email ==
                                                        FirebaseAuth.instance
                                                            .currentUser!.email)
                                                ? Colors.blue
                                                : Colors.grey,
                                          ),
                                          onPressed: () async {
                                            if (matchProvider.value!.likers!
                                                .any((liker) =>
                                                    liker!.email ==
                                                    FirebaseAuth.instance
                                                        .currentUser!.email)) {
                                              matchProvider.value =
                                                  await _sportService
                                                      .removeLikeMatch(
                                                          _match.id);
                                            } else {
                                              matchProvider.value =
                                                  await _sportService
                                                      .likerMatch(_match.id);
                                            }
                                          }),
                                      Text(matchProvider.value!.likers!.length
                                          .toString())
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        _isPressCommment.value =
                                            !_isPressCommment.value;
                                      },
                                      icon: Icon(
                                        Icons.message,
                                        color: Colors.grey,
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // SECTION COMMENTAIRE
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ValueListenableBuilder<bool>(
                                        valueListenable: _isPressCommment,
                                        builder:
                                            (context, passwordsMatch, child) {
                                          return passwordsMatch
                                              ? reusableCommentInput(
                                                  "Commenter",
                                                  _commentairController,
                                                  (value) {
                                                  return null;
                                                }, () async {
                                                  matchProvider.value =
                                                      await _sportService
                                                          .addCommentMatch(
                                                              _match.id,
                                                              _commentairController
                                                                  .value.text);
                                                  _isPressCommment.value =
                                                      !_isPressCommment.value;
                                                })
                                              : Container(
                                                  height: 0,
                                                );
                                        }),

                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Commentaires",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    SizedBox(height: 10),
                                    // Comment 1
                                    Column(
                                      children: [
                                        for (var comment in matchProvider
                                            .value!.comments!.reversed)
                                          GestureDetector(
                                            onLongPress: () async {
                                              if (comment.user.email ==
                                                  FirebaseAuth.instance
                                                      .currentUser!.email) {
                                                bool confirm = await showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return deleteConfirmedDialog(
                                                        context);
                                                  },
                                                );

                                                if (confirm) {
                                                  matchProvider.value =
                                                      await _sportService
                                                          .removeCommentMatch(
                                                              _match.id,
                                                              comment);
                                                }
                                              }
                                            },
                                            child: CommentWidget(
                                              photo: comment.user.photo!,
                                              name: comment.user.prenom +
                                                  comment.user.nom
                                                      .toUpperCase(),
                                              comment: comment.content,
                                              timeAgo: comment.date,
                                            ),
                                          )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        });
              }
            }),
      ),
    );
  }
}
