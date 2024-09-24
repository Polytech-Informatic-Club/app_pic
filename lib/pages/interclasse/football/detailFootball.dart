import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/models/football.dart';
import 'package:new_app/models/match.dart';
import 'package:new_app/services/SportService.dart';
import 'package:new_app/utils/AppColors.dart';
import 'package:new_app/widgets/commentWidget.dart';
import 'package:new_app/widgets/deleteConfirmedDialog.dart';
import 'package:new_app/widgets/reusable_comment_input.dart';

class DetailFootballScreen extends StatefulWidget {
  String id;
  DetailFootballScreen(this.id, {super.key});

  @override
  State<DetailFootballScreen> createState() => _DetailFootballScreenState(id);
}

class _DetailFootballScreenState extends State<DetailFootballScreen> {
  SportService _sportService = new SportService();
  String _id;
  _DetailFootballScreenState(this._id);

  ValueNotifier<bool> _isPressCommment = new ValueNotifier<bool>(false);
  ValueNotifier<Football?> _match = new ValueNotifier<Football?>(null);

  TextEditingController _commentairController = TextEditingController();

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
          "Détails du match",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Football?>(
            future: _sportService.getMatchFootballById(_id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Erreur lors de la récupération du rôle');
              } else {
                final match = snapshot.data ?? null;
                _match.value = match;
                return match == null
                    ? CircularProgressIndicator()
                    : Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(color: jauneClair),
                            padding: EdgeInsets.only(bottom: 20),
                            child: Column(
                              children: [
                                SizedBox(height: 20),
                                // Match Information
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        CircleAvatar(
                                            radius: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.1,
                                            backgroundImage: NetworkImage(
                                              match.equipeA.logo,
                                            )),
                                        SizedBox(height: 10),
                                        Text(
                                          match.equipeA.nom,
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
                                            radius: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.1,
                                            backgroundImage: NetworkImage(
                                              match.equipeB.logo,
                                            )),
                                        SizedBox(height: 10),
                                        Text(
                                          match.equipeB.nom,
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
                                  margin: EdgeInsets.symmetric(horizontal: 35),
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
                                              Text(
                                                match.scoreEquipeA.toString(),
                                                style: TextStyle(
                                                    fontSize: 32,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              Column(
                                                children: [
                                                  for (var butteur
                                                      in match.buteursA!)
                                                    Text(
                                                      "${butteur.joueur.nom} (${butteur.minute}')",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                ],
                                              )
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
                                              Text(
                                                match.scoreEquipeB.toString(),
                                                style: TextStyle(
                                                    fontSize: 32,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              Column(
                                                children: [
                                                  for (var butteur
                                                      in match.buteursB!)
                                                    Text(
                                                      "${butteur.joueur.nom} (${butteur.minute}')",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                ],
                                              )
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
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            match.statistiques["yellowCardA"]
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            match.statistiques["redCardA"]
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Text("Cartons"),
                                  ],
                                ),
                                // Statistics Icons
                                Column(
                                  children: [
                                    Icon(Icons.sports_soccer, size: 32),
                                    Text("tirs"),
                                    Text(
                                        "${match.statistiques["tirsA"].toString()} - ${match.statistiques["tirsB"].toString()}"),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(Icons.sports, size: 32),
                                    Text("tirs cadrés"),
                                    Text(
                                        "${match.statistiques["tirsCadresA"].toString()} - ${match.statistiques["tirsCadresB"].toString()}"),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(Icons.error_outline, size: 32),
                                    Text("fautes"),
                                    Text(
                                        "${match.statistiques["fautesA"].toString()} - ${match.statistiques["fautesB"].toString()}"),
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            match.statistiques["yellowCardB"]
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            match.statistiques["redCardA"]
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Text("Cartons"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 100.0),
                            child: Divider(
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            children: [
                              ValueListenableBuilder<Football?>(
                                  valueListenable: _match,
                                  builder: (context, matchProvider, child) {
                                    return Row(
                                      children: [
                                        IconButton(
                                            icon: Icon(
                                              Icons.thumb_up,
                                              color: _match.value!.likers!.any(
                                                      (liker) =>
                                                          liker!.email ==
                                                          FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .email)
                                                  ? Colors.blue
                                                  : Colors.grey,
                                            ),
                                            onPressed: () async {
                                              if (_match.value!.likers!.any(
                                                  (liker) =>
                                                      liker!.email ==
                                                      FirebaseAuth
                                                          .instance
                                                          .currentUser!
                                                          .email)) {
                                                _match.value =
                                                    await _sportService
                                                        .removeLikeMatch(
                                                            match.id);
                                              } else {
                                                _match.value =
                                                    await _sportService
                                                        .likerMatch(match.id);
                                              }
                                            }),
                                        Text(_match.value!.likers!.length
                                            .toString())
                                      ],
                                    );
                                  }),
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
                          // Comment Section
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ValueListenableBuilder<bool>(
                                    valueListenable: _isPressCommment,
                                    builder: (context, passwordsMatch, child) {
                                      return passwordsMatch
                                          ? reusableCommentInput(
                                              "Commenter",
                                              _commentairController,
                                              (value) {}, () async {
                                              _match.value = await _sportService
                                                  .addCommentMatch(
                                                      match.id,
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
                                ValueListenableBuilder<Football?>(
                                    valueListenable: _match,
                                    builder: (context, matchProvider, child) {
                                      return Column(
                                        children: [
                                          for (var comment in _match
                                              .value!.comments!.reversed)
                                            GestureDetector(
                                              onLongPress: () async {
                                                if (comment.user.email ==
                                                    FirebaseAuth.instance
                                                        .currentUser!.email) {
                                                  bool confirm =
                                                      await showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return deleteConfirmedDialog(
                                                          context);
                                                    },
                                                  );

                                                  if (confirm) {
                                                    _match.value =
                                                        await _sportService
                                                            .removeCommentMatch(
                                                                match.id,
                                                                comment);
                                                  }
                                                } else {
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
                                      );
                                    })
                              ],
                            ),
                          ),
                        ],
                      );
              }
            }),
      ),
    );
  }
}
