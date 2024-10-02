import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/models/annonce.dart';
import 'package:new_app/models/categorie.dart';
import 'package:new_app/services/annonce_service.dart';
import 'package:new_app/utils/app_colors.dart';
import 'package:new_app/widgets/ept_button.dart';

class Restauration extends StatelessWidget {
  Categorie categorie;
  Restauration(this.categorie, {super.key});

  AnnonceService _annonceService = AnnonceService();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder<List<Annonce>>(
                future: _annonceService.getAnnoncesByCategorie(categorie),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Erreur lors du chargement');
                  } else {
                    List<Annonce> annonces = snapshot.data ?? [];
                    return annonces.isEmpty
                        ? Text("Aucune annonce trouvée.")
                        : Row(
                            children: [
                              for (var annonce in annonces)
                                RestaurationItem(
                                  title: annonce.titre,
                                  content: annonce.description,
                                  date: annonce.date,
                                  isBourse:
                                      annonce.categorie.libelle.toUpperCase() ==
                                          "bourse".toUpperCase(),
                                ),
                            ],
                          );
                  }
                })
          ],
        ),
      ),
    );
  }
}

class RestaurationItem extends StatelessWidget {
  final String title;
  final String content;
  final DateTime date;
  final bool isBourse;
  const RestaurationItem(
      {super.key,
      required this.title,
      required this.content,
      required this.date,
      required this.isBourse});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
      padding: const EdgeInsets.all(15),
      width: 350,
      height: MediaQuery.sizeOf(context).height * 0.2,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontFamily: "Inter",
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          RichText(
              text: TextSpan(
            text: content,
            style: const TextStyle(
              fontFamily: "Inter",
              color: Colors.white,
              fontSize: 12,
            ),
          )),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                timeAgoCustom(date),
                style: TextStyle(color: AppColors.white),
              ),
              const SizedBox(),
              isBourse
                  ? EptButton(
                      title: "Voir communiqué",
                      width: 150,
                      height: 30,
                      borderRadius: 5,
                      color: Colors.white,
                      fontColor: Colors.black,
                      fontsize: 12,
                    )
                  : Container(
                      height: 0,
                    )
            ],
          )
        ],
      ),
    );
  }
}
