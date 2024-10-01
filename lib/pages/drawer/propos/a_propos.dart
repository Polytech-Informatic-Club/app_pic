import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/pages/drawer/propos/membre.dart';

class AProposPage extends StatelessWidget {
  const AProposPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A propos'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black, // Couleur du texte et des icônes
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                "Lorem ipsum dolor sit amet consectetur. Dis amet ullamcorper etiam facilisis. At pretium duis donec nec laoreet sem feugiat quam tincidunt. Amet tellus arcu ut tortor nulla euismod ullamcorper velit adipiscing. Justo in morbi elit tellus. Magna nulla fermentum aliquam aliquam sit enim. Non dignissim sed netus adipiscing morbi sagittis. Orci et tellus massa velit nulla. ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'InterMedium',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 1,
                width: 250,
                color: Colors.black,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "L'équipe",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Expanded(
          child: GridView.builder(
            itemCount: 8, // 9 membres au total
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 colonnes
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemBuilder: (context, index) {
              // Exemple de membres de l'équipe avec image et nom
              List<Map<String, String>> equipe = [
                {
                  "imagePath": "assets/images/membre5.jpg",
                  "name": "Elimane SALL",
                  "role": "Lead Backend Developer",
                  "description":
                      "En cinquième année lors du développement de l'application, un élément de la 47ème promotion.",
                  "contact": "77 777 77 77",
                  "message": "Envoyer un message"
                },
                {
                  "imagePath": "assets/images/equipe/ibou.jpg",
                  "name": "Ibrahima DIA",
                  "role": "Lead Frontend Developer",
                  "description":
                      "En deuxième année lors du développement de l'application, un élément de la 50ème promotion.",
                  "contact": "77 888 88 88",
                  "message": "Envoyer un message"
                },
                {
                  "imagePath": "assets/images/membre4.jpg",
                  "name": "Mouhamadou Diouf CISSÉ",
                  "role": "Project Manager/Developer",
                  "description":
                      "En troisième année lors du développement de l'application, un élément de la 49ème promotion.",
                  "contact": "77 999 99 99",
                  "message": "Envoyer un message"
                },
                {
                  "imagePath": "assets/images/membre3.jpg",
                  "name": "Mouhamed El Amine SEMBENE",
                  "role": "UI/UX Designer",
                  "description":
                      "En deuxième année lors du développement de l'application, un élément de la 50ème promotion.",
                  "contact": "77 123 45 67",
                  "message": "Envoyer un message"
                },
                {
                  "imagePath": "assets/images/codiallo.jpg",
                  "name": "Cheikh Oumar DIALLO",
                  "role": "Frontend Developer",
                  "description":
                      "En deuxième année lors du développement de l'application, un élément de la 50ème promotion.",
                  "contact": "77 418 94 39",
                  "message": "Envoyer un message"
                },
                {
                  "imagePath": "assets/images/membre6.jpg",
                  "name": "Amath THIAM",
                  "role": "Backend Developer",
                  "description":
                      "En deuxième année lors du développement de l'application, un élément de la 50ème promotion.",
                  "contact": "77 345 67 89",
                  "message": "Envoyer un message"
                },
                {
                  "imagePath": "assets/images/membre7.jpg",
                  "name": "Abdou Salam MBOUP",
                  "role": "UI/UX Designer",
                  "description":
                      "En deuxième année lors du développement de l'application, un élément de la 50ème promotion.",
                  "contact": "77 456 78 90",
                  "message": "Envoyer un message"
                },
                {
                  "imagePath": "assets/images/aminou.jpg",
                  "name": "Mouhamed Aminou NIANG",
                  "role": "Project Manager",
                  "description":
                      "En première année lors du développement de l'application, un élément de la 51ème promotion.",
                  "contact": "77 567 89 01",
                  "message": "Envoyer un message"
                },
              ];

              // Retourne un membre en fonction de l'index
              return equipeMembre(
                equipe[index]["imagePath"]!, // Chemin de l'image
                equipe[index]["name"]!, // Nom
                equipe[index]["role"]!, // Rôle
                equipe[index]["description"]!, // Description
                equipe[index]["contact"]!, // Contact
                equipe[index]["message"]!, // Message
              );
            },
          ),
        ),
      ]),
    );
  }
}

Widget equipeMembre(
  image,
  nom,
  String role,
  String description,
  String contact,
  String message,
) {
  return Builder(builder: (context) {
    return InkWell(
      onTap: () {
        changerPage(context,
            MembreEquipe(nom, image, role, description, contact, message));
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(image),
            radius: 35,
            backgroundColor: Colors.grey[300], // Couleur de l'avatar
          ),
          SizedBox(height: 5),
          Text(
            nom,
            maxLines: 2,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  });
}
