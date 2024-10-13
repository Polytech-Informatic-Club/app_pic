import 'package:flutter/material.dart';
import 'package:new_app/models/joueur.dart';
import 'package:new_app/pages/interclasse/football/detail_match.dart';
import 'package:new_app/services/sport_service.dart';
import 'package:new_app/utils/app_colors.dart';
import 'package:new_app/widgets/reusable_fin_periode_match.dart';
import 'package:new_app/widgets/update_statistic_dialog.dart';

Widget statisticFootballCard(ValueNotifier matchProvider, BuildContext context,
    SportService _sportService, String _typeSport) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Team 1 Stats
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        matchProvider.value!.statistiques["yellowCardA"]
                            .toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        matchProvider.value!.statistiques["redCardA"]
                            .toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Text("Cartons"),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        bool confirm = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return updateStatisticDialog(context);
                          },
                        );

                        if (confirm || !confirm) {
                          matchProvider.value =
                              await _sportService.updateStatistique(
                                  matchProvider.value!.id,
                                  "yellowCardA",
                                  confirm ? 1 : -1,
                                  _typeSport);
                        }
                      },
                      icon: Icon(
                        Icons.edit,
                        color: AppColors.primary,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        bool confirm = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return updateStatisticDialog(context);
                          },
                        );

                        if (confirm || !confirm) {
                          matchProvider.value =
                              await _sportService.updateStatistique(
                                  matchProvider.value!.id,
                                  "redCardA",
                                  confirm ? 1 : -1,
                                  _typeSport);
                        }
                      },
                      icon: Icon(
                        Icons.edit,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                )
              ],
            ),
            // Statistics Icons
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.sports_soccer, size: 32),
                Text("tirs"),
                Text("${matchProvider.value!.statistiques["tirsA"].toString()} "
                    " - ${matchProvider.value!.statistiques["tirsB"].toString()}"),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        bool confirm = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return updateStatisticDialog(context);
                          },
                        );

                        if (confirm || !confirm) {
                          matchProvider.value =
                              await _sportService.updateStatistique(
                                  matchProvider.value!.id,
                                  "tirsA",
                                  confirm ? 1 : -1,
                                  _typeSport);
                        }
                      },
                      icon: Icon(
                        Icons.edit,
                        color: AppColors.primary,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        bool confirm = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return updateStatisticDialog(context);
                          },
                        );

                        // ignore: unrelated_type_equality_checks
                        if (confirm != Null) {
                          matchProvider.value =
                              await _sportService.updateStatistique(
                                  matchProvider.value!.id,
                                  "tirsB",
                                  confirm ? 1 : -1,
                                  _typeSport);
                        }
                      },
                      icon: Icon(
                        Icons.edit,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Column(
              children: [
                Icon(Icons.sports, size: 32),
                Text("tirs cadrés"),
                Text(
                    "${matchProvider.value!.statistiques["tirsCadresA"].toString()} - ${matchProvider.value!.statistiques["tirsCadresB"].toString()}"),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        bool confirm = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return updateStatisticDialog(context);
                          },
                        );

                        if (confirm || !confirm) {
                          matchProvider.value =
                              await _sportService.updateStatistique(
                                  matchProvider.value!.id,
                                  "tirsCadresA",
                                  confirm ? 1 : -1,
                                  _typeSport);
                        }
                      },
                      icon: Icon(
                        Icons.edit,
                        color: AppColors.primary,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        bool confirm = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return updateStatisticDialog(context);
                          },
                        );

                        // ignore: unrelated_type_equality_checks
                        if (confirm != Null) {
                          matchProvider.value =
                              await _sportService.updateStatistique(
                                  matchProvider.value!.id,
                                  "tirsCadresB",
                                  confirm ? 1 : -1,
                                  _typeSport);
                        }
                      },
                      icon: Icon(
                        Icons.edit,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Column(
              children: [
                Icon(Icons.error_outline, size: 32),
                Text("fautes"),
                Text(
                    "${matchProvider.value!.statistiques["fautesA"].toString()} - ${matchProvider.value!.statistiques["fautesB"].toString()}"),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        bool confirm = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return updateStatisticDialog(context);
                          },
                        );

                        if (confirm || !confirm) {
                          matchProvider.value =
                              await _sportService.updateStatistique(
                                  matchProvider.value!.id,
                                  "fautesA",
                                  confirm ? 1 : -1,
                                  _typeSport);
                        }
                      },
                      icon: Icon(
                        Icons.edit,
                        color: AppColors.primary,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        bool confirm = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return updateStatisticDialog(context);
                          },
                        );

                        if (confirm || !confirm) {
                          // ignore: avoid_print
                          print("Faute B");

                          matchProvider.value =
                              await _sportService.updateStatistique(
                                  matchProvider.value!.id,
                                  "fautesB",
                                  confirm ? 1 : -1,
                                  _typeSport);
                        }
                      },
                      icon: Icon(
                        Icons.edit,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                )
              ],
            ),
            // Team 2 Stats
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        matchProvider.value!.statistiques["yellowCardB"]
                            .toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        matchProvider.value!.statistiques["redCardB"]
                            .toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Text("Cartons"),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        bool confirm = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return updateStatisticDialog(context);
                          },
                        );

                        if (confirm || !confirm) {
                          matchProvider.value =
                              await _sportService.updateStatistique(
                                  matchProvider.value!.id,
                                  "yellowCardB",
                                  confirm ? 1 : -1,
                                  _typeSport);
                        }
                      },
                      icon: Icon(
                        Icons.edit,
                        color: AppColors.primary,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        bool confirm = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return updateStatisticDialog(context);
                          },
                        );

                        if (confirm || !confirm) {
                          matchProvider.value =
                              await _sportService.updateStatistique(
                                  matchProvider.value!.id,
                                  "redCardB",
                                  confirm ? 1 : -1,
                                  _typeSport);
                        }
                      },
                      icon: Icon(
                        Icons.edit,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ));
}

Widget statisticBasketballCard(ValueNotifier matchProvider,
    BuildContext context, SportService _sportService, String _typeSport) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Statistics Icons
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.sports_soccer, size: 32),
                  Text("Un point"),
                  Text(
                      "${matchProvider.value!.statistiques["point1A"].toString()} "
                      " - ${matchProvider.value!.statistiques["point1B"].toString()}"),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          Map<String, dynamic> resultat = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return updateGoldDialog(
                                context,
                                matchProvider.value!.equipeA.joueurs,
                              );
                            },
                          );

                          Joueur? joueur = resultat["joueur"];
                          int? minute = resultat["minute"];
                          if (joueur != null) {
                            matchProvider.value = await _sportService.addButeur(
                                matchProvider.value!.id,
                                joueur,
                                minute!,
                                "scoreEquipeA",
                                "buteursA",
                                _typeSport,
                                1);
                            matchProvider.value =
                                await _sportService.updateStatistique(
                                    matchProvider.value!.id,
                                    "point1A",
                                    1,
                                    _typeSport);
                          }
                        },
                        icon: Icon(
                          Icons.edit,
                          color: AppColors.primary,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          Map<String, dynamic> resultat = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return updateGoldDialog(
                                context,
                                matchProvider.value!.equipeA.joueurs,
                              );
                            },
                          );

                          Joueur? joueur = resultat["joueur"];
                          int? minute = resultat["minute"];
                          if (joueur != null) {
                            matchProvider.value = await _sportService.addButeur(
                                matchProvider.value!.id,
                                joueur,
                                minute!,
                                "scoreEquipeB",
                                "buteursB",
                                _typeSport,
                                1);
                            matchProvider.value =
                                await _sportService.updateStatistique(
                                    matchProvider.value!.id,
                                    "point1B",
                                    1,
                                    _typeSport);
                          }
                        },
                        icon: Icon(
                          Icons.edit,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Icon(Icons.sports, size: 32),
                  Text("Deux points"),
                  Text(
                      "${matchProvider.value!.statistiques["point2A"].toString()} - ${matchProvider.value!.statistiques["point2B"].toString()}"),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          Map<String, dynamic> resultat = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return updateGoldDialog(
                                context,
                                matchProvider.value!.equipeA.joueurs,
                              );
                            },
                          );

                          Joueur? joueur = resultat["joueur"];
                          int? minute = resultat["minute"];
                          if (joueur != null) {
                            matchProvider.value = await _sportService.addButeur(
                                matchProvider.value!.id,
                                joueur,
                                minute!,
                                "scoreEquipeA",
                                "buteursA",
                                _typeSport,
                                2);
                            matchProvider.value =
                                await _sportService.updateStatistique(
                                    matchProvider.value!.id,
                                    "point2A",
                                    2,
                                    _typeSport);
                          }
                        },
                        icon: Icon(
                          Icons.edit,
                          color: AppColors.primary,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          Map<String, dynamic> resultat = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return updateGoldDialog(
                                context,
                                matchProvider.value!.equipeA.joueurs,
                              );
                            },
                          );

                          Joueur? joueur = resultat["joueur"];
                          int? minute = resultat["minute"];
                          if (joueur != null) {
                            matchProvider.value = await _sportService.addButeur(
                                matchProvider.value!.id,
                                joueur,
                                minute!,
                                "scoreEquipeB",
                                "buteursB",
                                _typeSport,
                                2);
                            matchProvider.value =
                                await _sportService.updateStatistique(
                                    matchProvider.value!.id,
                                    "point2B",
                                    2,
                                    _typeSport);
                          }
                        },
                        icon: Icon(
                          Icons.edit,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.sports_soccer, size: 32),
                  Text("Trois points"),
                  Text(
                      "${matchProvider.value!.statistiques["point3A"].toString()} "
                      " - ${matchProvider.value!.statistiques["point3B"].toString()}"),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          Map<String, dynamic> resultat = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return updateGoldDialog(
                                context,
                                matchProvider.value!.equipeA.joueurs,
                              );
                            },
                          );

                          Joueur? joueur = resultat["joueur"];
                          int? minute = resultat["minute"];
                          if (joueur != null) {
                            matchProvider.value = await _sportService.addButeur(
                                matchProvider.value!.id,
                                joueur,
                                minute!,
                                "scoreEquipeA",
                                "buteursA",
                                _typeSport,
                                3);
                            matchProvider.value =
                                await _sportService.updateStatistique(
                                    matchProvider.value!.id,
                                    "point3A",
                                    3,
                                    _typeSport);
                          }
                        },
                        icon: Icon(
                          Icons.edit,
                          color: AppColors.primary,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          Map<String, dynamic> resultat = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return updateGoldDialog(
                                context,
                                matchProvider.value!.equipeA.joueurs,
                              );
                            },
                          );

                          Joueur? joueur = resultat["joueur"];
                          int? minute = resultat["minute"];
                          if (joueur != null) {
                            matchProvider.value = await _sportService.addButeur(
                                matchProvider.value!.id,
                                joueur,
                                minute!,
                                "scoreEquipeB",
                                "buteursB",
                                _typeSport,
                                3);
                            matchProvider.value =
                                await _sportService.updateStatistique(
                                    matchProvider.value!.id,
                                    "point3B",
                                    3,
                                    _typeSport);
                          }
                        },
                        icon: Icon(
                          Icons.edit,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  )
                ],
              ),

              Column(
                children: [
                  Icon(Icons.error_outline, size: 32),
                  Text("fautes"),
                  Text(
                      "${matchProvider.value!.statistiques["fauteA"].toString()} - ${matchProvider.value!.statistiques["fauteB"].toString()}"),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          bool confirm = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return updateStatisticDialog(context);
                            },
                          );

                          if (confirm || !confirm) {
                            matchProvider.value =
                                await _sportService.updateStatistique(
                                    matchProvider.value!.id,
                                    "fauteA",
                                    confirm ? 1 : -1,
                                    _typeSport);
                          }
                        },
                        icon: Icon(
                          Icons.edit,
                          color: AppColors.primary,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          bool confirm = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return updateStatisticDialog(context);
                            },
                          );

                          if (confirm || !confirm) {
                            // ignore: avoid_print
                            print("Faute B");

                            matchProvider.value =
                                await _sportService.updateStatistique(
                                    matchProvider.value!.id,
                                    "fauteB",
                                    confirm ? 1 : -1,
                                    _typeSport);
                          }
                        },
                        icon: Icon(
                          Icons.edit,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () async {
            Map<String, dynamic> resultat = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return finPeriodeMatch(
                  context,
                  ['1er', '2eme', '3eme', '4eme'],
                );
              },
            );
            if (resultat.isNotEmpty) {
              matchProvider.value = await _sportService.updateFinPeriode(
                matchProvider.value!.id,
                resultat["periode"],
                resultat["scoreA"],
                resultat["scoreB"],
                _typeSport,
              );
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Fin quart-temps",
                style: TextStyle(color: AppColors.white),
              ),
              // Icon(Icons.close),
            ],
          ),
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(AppColors.primary)),
        ),
        SizedBox(
          height: 10,
        ),
        statisticBasket(matchProvider.value)
      ]));
}

Widget statisticVolleyballCard(ValueNotifier matchProvider,
    BuildContext context, SportService _sportService, String _typeSport) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Statistics Icons
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.sports_soccer, size: 32),
                Text("Goals"),
                Text("${matchProvider.value!.statistiques["goalA"].toString()} "
                    " - ${matchProvider.value!.statistiques["goalB"].toString()}"),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        Map<String, dynamic> resultat = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return updateGoldDialog(
                              context,
                              matchProvider.value!.equipeA.joueurs,
                            );
                          },
                        );

                        Joueur? joueur = resultat["joueur"];
                        int? minute = resultat["minute"];
                        if (joueur != null) {
                          matchProvider.value = await _sportService.addButeur(
                              matchProvider.value!.id,
                              joueur,
                              minute!,
                              "scoreEquipeA",
                              "buteursA",
                              _typeSport);
                          matchProvider.value =
                              await _sportService.updateStatistique(
                                  matchProvider.value!.id,
                                  "goalA",
                                  1,
                                  _typeSport);
                        }
                      },
                      icon: Icon(
                        Icons.edit,
                        color: AppColors.primary,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        Map<String, dynamic> resultat = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return updateGoldDialog(
                              context,
                              matchProvider.value!.equipeA.joueurs,
                            );
                          },
                        );

                        Joueur? joueur = resultat["joueur"];
                        int? minute = resultat["minute"];
                        if (joueur != null) {
                          matchProvider.value = await _sportService.addButeur(
                              matchProvider.value!.id,
                              joueur,
                              minute!,
                              "scoreEquipeB",
                              "buteursB",
                              _typeSport);
                          matchProvider.value =
                              await _sportService.updateStatistique(
                                  matchProvider.value!.id,
                                  "goalB",
                                  1,
                                  _typeSport);
                        }
                      },
                      icon: Icon(
                        Icons.edit,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.sports_soccer, size: 32),
                Text("Highest streak"),
                Text(
                    "${matchProvider.value!.statistiques["highestStreakA"].toString()} "
                    " - ${matchProvider.value!.statistiques["highestStreakB"].toString()}"),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        bool confirm = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return updateStatisticDialog(context);
                          },
                        );

                        if (confirm || !confirm) {
                          matchProvider.value =
                              await _sportService.updateStatistique(
                                  matchProvider.value!.id,
                                  "highestStreakA",
                                  confirm ? 1 : -1,
                                  _typeSport);
                        }
                      },
                      icon: Icon(
                        Icons.edit,
                        color: AppColors.primary,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        bool confirm = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return updateStatisticDialog(context);
                          },
                        );

                        if (confirm || !confirm) {
                          matchProvider.value =
                              await _sportService.updateStatistique(
                                  matchProvider.value!.id,
                                  "highestStreakB",
                                  confirm ? 1 : -1,
                                  _typeSport);
                        }
                      },
                      icon: Icon(
                        Icons.edit,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                )
              ],
            ),

            Column(
              children: [
                Icon(Icons.error_outline, size: 32),
                Text("Fautes"),
                Text(
                    "${matchProvider.value!.statistiques["fautesA"].toString()} - ${matchProvider.value!.statistiques["fautesB"].toString()}"),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        bool confirm = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return updateStatisticDialog(context);
                          },
                        );

                        if (confirm || !confirm) {
                          matchProvider.value =
                              await _sportService.updateStatistique(
                                  matchProvider.value!.id,
                                  "fautesA",
                                  confirm ? 1 : -1,
                                  _typeSport);
                        }
                      },
                      icon: Icon(
                        Icons.edit,
                        color: AppColors.primary,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        bool confirm = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return updateStatisticDialog(context);
                          },
                        );

                        if (confirm || !confirm) {
                          // ignore: avoid_print
                          print("Faute B");

                          matchProvider.value =
                              await _sportService.updateStatistique(
                                  matchProvider.value!.id,
                                  "fautesB",
                                  confirm ? 1 : -1,
                                  _typeSport);
                        }
                      },
                      icon: Icon(
                        Icons.edit,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ));
}

Widget statisticJeuxEspritsCard(ValueNotifier matchProvider,
    BuildContext context, SportService _sportService, String _typeSport) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Statistics Icons
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.sports_soccer, size: 32),
                Text("Bonnes réponses"),
                Text(
                    "${matchProvider.value!.statistiques["bonneReponseA"].toString()} "
                    " - ${matchProvider.value!.statistiques["bonneReponseB"].toString()}"),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        Map<String, dynamic> resultat = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return updateGoldWithPointDialog(
                              context,
                              matchProvider.value!.equipeA.joueurs,
                            );
                          },
                        );

                        Joueur? joueur = resultat["joueur"];
                        int? minute = resultat["minute"];
                        int? point = resultat["point"];

                        if (joueur != null) {
                          matchProvider.value = await _sportService.addButeur(
                              matchProvider.value!.id,
                              joueur,
                              minute!,
                              "scoreEquipeA",
                              "buteursA",
                              _typeSport,
                              point!);
                          matchProvider.value =
                              await _sportService.updateStatistique(
                                  matchProvider.value!.id,
                                  "bonneReponseA",
                                  point,
                                  _typeSport);
                        }
                      },
                      icon: Icon(
                        Icons.edit,
                        color: AppColors.primary,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        Map<String, dynamic> resultat = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return updateGoldWithPointDialog(
                              context,
                              matchProvider.value!.equipeA.joueurs,
                            );
                          },
                        );

                        Joueur? joueur = resultat["joueur"];
                        int? minute = resultat["minute"];
                        int? point = resultat["point"];

                        if (joueur != null) {
                          matchProvider.value = await _sportService.addButeur(
                              matchProvider.value!.id,
                              joueur,
                              minute!,
                              "scoreEquipeB",
                              "buteursB",
                              _typeSport,
                              point!);
                          matchProvider.value =
                              await _sportService.updateStatistique(
                                  matchProvider.value!.id,
                                  "bonneReponseB",
                                  point,
                                  _typeSport);
                        }
                      },
                      icon: Icon(
                        Icons.edit,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ));
}
