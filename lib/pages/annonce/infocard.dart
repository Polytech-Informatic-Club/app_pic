import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/pages/annonce/afficher_annonce.dart';
import 'package:new_app/utils/app_colors.dart';

class InfoCard extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  final String titre;
  final String lieu;
  final DateTime date;
  final String description;
  final String idAnnonce;

  InfoCard({
    super.key,
    required this.image,
    required this.width,
    required this.height,
    required this.titre,
    required this.lieu,
    required this.date,
    required this.description,
    required this.idAnnonce,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return InkWell(
        onTap: () {
          changerPage(
              context,
              AfficherAnononceScreen(
                image: image,
                titre: titre,
                date: date,
                lieu: lieu,
                description: description,
                idAnnonce: idAnnonce,
              ));
        },
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
          padding: const EdgeInsets.all(3),
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: eptOrange, borderRadius: BorderRadius.circular(20)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Image(
                image: ResizeImage(
                  NetworkImage(image),
                  width: 730,  // Largeur de cache
                  height: 730, // Hauteur de cache
                ),
                height: height,
              ),
            ),
          ),
        ),
      );
    });
  }
}
