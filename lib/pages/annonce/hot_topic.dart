import 'package:flutter/material.dart';
import 'package:new_app/models/categorie.dart';
import 'package:new_app/pages/annonce/restauration.dart';
import 'package:new_app/pages/annonce/rex_row.dart';
import 'package:new_app/services/annonce_service.dart';
import 'package:new_app/utils/app_colors.dart';

class HotTopic extends StatelessWidget {
  HotTopic({super.key});

  AnnonceService _annonceService = AnnonceService();

  @override
  Widget build(BuildContext context) {
    bool isAdmin = true;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              "Hot-Topics",
              style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        FutureBuilder<List<Categorie>>(
            future: _annonceService.getAllCategories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Erreur lors du chargement');
              } else {
                List<Categorie> categories = snapshot.data ?? [];
                return Column(
                  children: [
                    for (var categorie in categories)
                      Column(
                        children: [
                          Row(
                            children: [
                              categorie.logo != ""
                                  ? Container(
                                      padding: const EdgeInsets.all(2),
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: orange,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Image.network(
                                            categorie.logo,
                                            scale: 3,
                                          )))
                                  : Container(
                                      height: 0,
                                    ),
                              const SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    categorie.libelle,
                                    style: TextStyle(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  if (isAdmin) ...[
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    InkWell(
                                        onTap: () {},
                                        child: Image.asset(
                                          "assets/images/polytech-Info/plus.png",
                                          scale: 5,
                                        )),
                                  ]
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (categorie.libelle.toUpperCase() ==
                              "retour d'expérience".toUpperCase())
                            RexRow(categorie),
                          if (categorie.libelle.toUpperCase() !=
                                  "retour d'expérience".toUpperCase() ||
                              categorie.libelle.toUpperCase() !=
                                  "Assemblée générale".toUpperCase())
                            Restauration(categorie),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      )
                  ],
                );
              }
            }),
      ],
    );
  }
}
