import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/utils/app_colors.dart';
import 'package:new_app/widgets/submited_button.dart';

class AfficherAnononceScreen extends StatelessWidget {
  final String image;
  final String titre;
  final String lieu;
  final DateTime date;
  final String description;
  const AfficherAnononceScreen(
      {required this.image,
      required this.titre,
      required this.lieu,
      required this.date,
      required this.description,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: afficherAnnonce(image, titre, lieu, date, description),
        ));
  }

  Widget afficherAnnonce(imagePath, title, subtitle, dateTime, description) {
    return Column(
      children: [
        Stack(
          children: [
            // Image de fond
            Container(
              height: 470,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/polytech-Info/white_bg_ept.png'), // Image de fond à ajouter dans 'assets'
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Contenu de la page
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100),
                  Center(
                    child: SizedBox(
                      height: 370,
                      child: Image.network(
                        imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 10,
          decoration: BoxDecoration(color: jauneClair),
        ),
        Container(
          decoration: BoxDecoration(color: orange),
          width: double.infinity,
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                subtitle,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Container(
          height: 10,
          decoration: BoxDecoration(color: jauneClair),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${simpleDateformat(dateTime)} à ${getHour(date)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 251, 240, 223),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      description,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              // Bouton "Rejoindre"
            ],
          ),
        )
      ],
    );
  }
}
