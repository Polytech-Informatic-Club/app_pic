import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/models/jeu.dart';
import 'package:new_app/models/joueur.dart';
import 'package:new_app/models/session_jeu.dart';
import 'package:new_app/services/jeu_service.dart';
import 'package:new_app/utils/app_colors.dart';
import 'package:new_app/widgets/alerte_message.dart';
import 'package:new_app/widgets/delete_confirmed_dialog.dart';
import 'package:new_app/widgets/submited_button.dart';

class GameScreen extends StatelessWidget {
  String id;
  GameScreen(this.id, {super.key});

  JeuService _jeuService = JeuService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
        ),
        extendBodyBehindAppBar: true,
        body: FutureBuilder<Jeu?>(
            future: _jeuService.getJeuId(id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Erreur lors du chargement');
              } else {
                Jeu? jeu = snapshot.data;
                return jeu != null
                    ? SingleChildScrollView(
                        child: Column(children: [
                          Stack(children: [
                            // Image de fond
                            Container(
                              height: 310,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/homepage/jeux_top_bg.png'), // Image de fond à ajouter dans 'assets'
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 70,
                                ),
                                Center(
                                  child: Image.network(
                                    jeu.logo, // Image UNO dans 'assets'
                                    height: 150,
                                  ),
                                ),
                                SizedBox(height: 10),

                                // Texte UNO
                                Center(
                                  child: Text(
                                    jeu.nom,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                          SizedBox(height: 10),
                          // Contenu de la page
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Règles:",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  jeu.regle,
                                  style: TextStyle(
                                      fontSize: 12, fontFamily: 'InterRegular'),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Sessions:",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),

                                Column(
                                  children: [
                                    ...List.generate(jeu.sessions.length,
                                        (index) {
                                      SessionJeu session = jeu!.sessions[index];
                                      return session.statut ==
                                              StatutSessionJeu.OUVERTE
                                          ? GestureDetector(
                                              onLongPress: () async {
                                                // if (session.user.email ==
                                                //     FirebaseAuth.instance
                                                //         .currentUser!.email) {
                                                bool confirm = await showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return deleteConfirmedDialog(
                                                        context,
                                                        "Voulez-vous vraiment supprimer cette session ?");
                                                  },
                                                );

                                                if (confirm) {
                                                  jeu = await _jeuService
                                                      .deleteSessionJeu(
                                                          id, session);
                                                }
                                              },
                                              child: ExpansionTile(
                                                  expandedCrossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  title: Text(
                                                    "Session à ${session.lieu} ${timeAgoCustom(session.date)}",
                                                    style: TextStyle(
                                                        fontSize:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.04,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  children: [
                                                    Text(
                                                      "Il y a ${session.joueurs.length} joueurs en attente à ${session.lieu}",
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                    Container(
                                                        width: double.infinity,
                                                        padding:
                                                            EdgeInsets.all(16),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.grey[200],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: session
                                                              .joueurs
                                                              .map((joueur) {
                                                            return Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  SizedBox(
                                                                      height:
                                                                          10),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(joueur
                                                                              .prenom +
                                                                          " " +
                                                                          joueur
                                                                              .nom
                                                                              .toUpperCase()),
                                                                    ],
                                                                  ),
                                                                ]);
                                                          }).toList(),
                                                        )),
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        try {
                                                          Jeu? jeu =
                                                              await _jeuService
                                                                  .postRejoindreSessionJeu(
                                                                      id);
                                                          if (jeu == null) {
                                                            alerteMessageWidget(
                                                                context,
                                                                "Vous etes déjà dans la session.",
                                                                AppColors
                                                                    .echec);
                                                          } else {
                                                            alerteMessageWidget(
                                                                context,
                                                                "Bienvenue dans la session.",
                                                                AppColors
                                                                    .success);
                                                          }
                                                        } catch (e) {}
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            grisClair,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10,
                                                                vertical: 5),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        'Rejoindre',
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ]))
                                          : Container(
                                              height: 0,
                                            );
                                    }),
                                  ],
                                ),

                                SizedBox(height: 20),

                                // Bouton "Créer une session"
                              ],
                            ),
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                TextEditingController _lieuController =
                                    TextEditingController();

                                // Afficher un dialog pour saisir le lieu
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title:
                                          Text('Entrer le lieu de la session'),
                                      content: TextField(
                                        controller: _lieuController,
                                        decoration:
                                            InputDecoration(hintText: 'Lieu'),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Fermer le dialog
                                          },
                                          child: Text('Annuler'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            String lieu = _lieuController.text;
                                            if (lieu.isNotEmpty) {
                                              // Poster la session si le lieu est saisi
                                              Jeu? jeu = await _jeuService
                                                  .postSessionJeu(id, lieu);
                                              Navigator.of(context)
                                                  .pop(); // Fermer le dialog
                                              if (jeu != null) {
                                                alerteMessageWidget(
                                                  context,
                                                  "Session créée avec succès.",
                                                  AppColors.success,
                                                );
                                              }
                                            } else {
                                              alerteMessageWidget(
                                                  context,
                                                  "Veuillez entrer un lieu.",
                                                  AppColors.echec);
                                            }
                                          },
                                          child: Text('Valider'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: orange,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Créer une session',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ),
                          ),

                          SizedBox(height: 20),
                        ]),
                      )
                    : Text("Aucun jeu trouvé");
              }
            }));
  }
}
