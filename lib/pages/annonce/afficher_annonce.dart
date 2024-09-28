import 'package:flutter/material.dart';
import 'package:new_app/utils/app_colors.dart';
import 'package:new_app/widgets/submited_button.dart';

class AfficherAnononceScreen extends StatelessWidget {
  const AfficherAnononceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: afficherAnnonce(
            'assets/images/polytech-Info/WhatsApp Image 2024-06-02 at 15.45.03_affac0af.jpg',
            'Levée des couleurs',
            "Carré d'arme",
            'Mardi 15 Juin à 7:50',
            'Lorem ipsum dolor sit amet consectetur. Quisita vestibulum nisi non molestie sollicitudin porta posuere eget. Ut ut aliquet nisi felis euismod. In sed fermentum massa. Phasellus ornare et adipiscing id fermentum aliquet sit sagittis.',
          ),
        ));
  }

  Widget afficherAnnonce(imagePath, title, subtitle, dateTime, description) {
    return Column(
      children: [
        Stack(
          children: [
            // Image de fond
            Container(
              height: 500,
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
                  SizedBox(height: 70),

                  Center(
                    child: SizedBox(
                      height: 400,
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Texte UNO
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
                dateTime,
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
