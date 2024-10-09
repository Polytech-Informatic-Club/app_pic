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
                  "imagePath": "assets/images/equipe/Elimane.jpg",
                  "name": "Elimane SALL",
                  "role": "Lead Backend Developer",
                  "description":
                      "Durant ce projet, nous étions chargés d'intégrer les API.",
                  "contact": "77 209 95 38",
                  "message":
                      "En tant qu'élève ingenieur, nous avons une obligation d'etre au service de notre nation. Toujours au service de notre nation.",
                  "linkedin": "",
                  "github": "",
                },
                {
                  "imagePath": "assets/images/equipe/ibou.jpg",
                  "name": "Ibrahima DIA",
                  "role": "Lead Frontend Developer",
                  "description":
                      "En TC2 lors du développement de l'application, chargé d'intégrer l'ensemble des interfaces visuelles.",
                  "contact": "77 474 88 97",
                  "message":
                      "En tant que passionné par l'IT et amateur de développement mobile c'était un réel plaisir de participer à ce projet. De plus travailler en collaboration avec mes anciens m'a été très bénéfiques car ils m'ont donné pas mal de hints. Bref j'espère que cette application perdurera durant des années et nous comptons sur les générations futures pour continuer à maintenir le code et y apporter des améliorations.",
                  "linkedin": "Ibrahima DIA",
                  "github": "ibou-dia",
                },
                {
                  "imagePath": "assets/images/membre4.jpg",
                  "name": "Mouhamadou Diouf CISSÉ",
                  "role": "Project Manager/Developer",
                  "description":
                      "En troisième année lors du développement de l'application, un élément de la 49ème promotion.",
                  "contact": "77 999 99 99",
                  "message": "Envoyer un message",
                  "linkedin": "",
                  "github": "",
                },
                {
                  "imagePath": "assets/images/membre3.jpg",
                  "name": "Mouhamed El Amine SEMBENE",
                  "role": "UI/UX Designer",
                  "description":
                      "En deuxième année lors du développement de l'application, un élément de la 50ème promotion.",
                  "contact": "77 123 45 67",
                  "message": "Envoyer un message",
                  "linkedin": "",
                  "github": "",
                },
                {
                  "imagePath": "assets/images/equipe/codiallo.jpg",
                  "name": "Cheikh Oumar DIALLO",
                  "role": "Frontend Developer",
                  "description":
                      "Durant ce projet, nous étions chargé de coder les interfaces qu'a faites le designer",
                  "contact": "77 418 94 39",
                  "message":
                      "Cette application a été créée par des élèves ingénieurs comme vous. N'hésitez pas à apporter également votre contribution à l'édifice de l'école polytechnique de Thiès.",
                  "linkedin": "co_diallo_",
                  "github": "cheikhouma",
                },
                {
                  "imagePath": "assets/images/membre6.jpg",
                  "name": "Amath THIAM",
                  "role": "Backend Developer",
                  "description":
                      "En deuxième année lors du développement de l'application, un élément de la 50ème promotion.",
                  "contact": "77 345 67 89",
                  "message": "Envoyer un message",
                  "linkedin": "",
                  "github": "",
                },
                {
                  "imagePath": "assets/images/membre7.jpg",
                  "name": "Abdou Salam MBOUP",
                  "role": "UI/UX Designer",
                  "description":
                      "En deuxième année lors du développement de l'application, un élément de la 50ème promotion.",
                  "contact": "77 456 78 90",
                  "message": "Envoyer un message",
                  "linkedin": "",
                  "github": "",
                },
                {
                  "imagePath": "assets/images/equipe/aminou.jpg",
                  "name": "Mohamed Aminou NIANG",
                  "role": " Project manager ",
                  "description":
                      "Durant ce projet, nous étions chargés de distribuer les taches et de suivre l’évolution de l’application .",
                  "contact": "77 258 42 81",
                  "message":
                      "En tant qu'élève ingenieur, nous avons une obligation d'etre au service de notre nation. Toujours au service de notre nation.",
                  "linkedin": "Mohamed Aminou Niang ",
                  "github": "aminouniang ",
                },
              ];

              return equipeMembre(
                equipe[index]["imagePath"]!,
                equipe[index]["name"]!,
                equipe[index]["role"]!,
                equipe[index]["description"]!,
                equipe[index]["contact"]!,
                equipe[index]["message"]!,
                equipe[index]["linkedin"]!,
                equipe[index]["github"]!,
              );
            },
          ),
        ),
      ]),
    );
  }
}

Widget equipeMembre(image, nom, String role, String description, String contact,
    String message, String linkedin, String github) {
  return Builder(builder: (context) {
    return InkWell(
      onTap: () {
        changerPage(
            context,
            MembreEquipe(nom, image, role, description, contact, message,
                linkedin, github));
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
