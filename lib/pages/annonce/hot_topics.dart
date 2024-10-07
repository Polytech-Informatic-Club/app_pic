import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/models/categorie.dart';
import 'package:new_app/models/hot_topic.dart';
import 'package:new_app/pages/annonce/create_hot_topic.dart';
import 'package:new_app/pages/annonce/restauration.dart';
import 'package:new_app/pages/annonce/rex_row.dart';
import 'package:new_app/services/annonce_service.dart';
import 'package:new_app/services/hot_topic_service.dart';
import 'package:new_app/services/user_service.dart';
import 'package:new_app/utils/app_colors.dart';

class HotTopics extends StatefulWidget {
  HotTopics({super.key});

  @override
  State<HotTopics> createState() => _HotTopicsState();
}

class _HotTopicsState extends State<HotTopics> {
  AnnonceService _annonceService = AnnonceService();
  UserService _userService = UserService();
  HotTopicService _hotTopicService = HotTopicService();
  String? userId;
  bool isAdmin = false;
  List<HotTopic> restaurationTopics = [];
  List<HotTopic> bourseTopics = [];

  void initState() {
    super.initState();
    _checkUserRole(); // Appel pour vérifier le rôle de l'utilisateur
    _loadHotTopics();
  }

  Future<void> _loadHotTopics() async {
    try {
      // Récupérer les topics pour la restauration
      List<HotTopic> restauration =
          await _hotTopicService.getHotTopicsByCategory('restauration');
      // Récupérer les topics pour la bourse
      List<HotTopic> bourse =
          await _hotTopicService.getHotTopicsByCategory('bourse');

      setState(() {
        restaurationTopics = restauration;
        bourseTopics = bourse;
      });
    } catch (e) {
      print("Erreur lors du chargement des Hot Topics: $e");
    }
  }

  Future<void> _checkUserRole() async {
    try {
      // Récupérer l'utilisateur connecté via FirebaseAuth
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        userId = user.email;

        // Récupérer le rôle de l'utilisateur à partir du service utilisateur
        String? role = await _userService.getUserRole(userId!);

        // Vérifier si l'utilisateur est admin
        if (role == 'ADMIN_MB') {
          setState(() {
            isAdmin = true; // Met à jour l'état pour afficher le bouton "+"
          });
        }
      }
    } catch (e) {
      print("Erreur lors de la vérification du rôle : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isAdmin = true;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Hot-Topics",
              style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            if (isAdmin) ...[
              SizedBox(
                width: 5,
              ),
              InkWell(
                  onTap: () {
                    changerPage(context, CreateHotTopicScreen());
                  },
                  child: Image.asset(
                    "assets/images/polytech-Info/plus.png",
                    scale: 5,
                  )),
            ]
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        _buildCategorySection(
          'Restauration',
          'assets/images/polytech-Info/icons8-nourriture-halal-90.png',
          restaurationTopics,
        ),
        SizedBox(height: 10),
        _buildCategorySection(
          'Bourses',
          'assets/images/polytech-Info/icons8-récupéré-l\'argent-90.png',
          bourseTopics,
          isBourse: true,
        ),
      ],
    );
  }
}

Widget _buildCategorySection(
    String title, String iconPath, List<HotTopic> topics,
    {bool isBourse = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: orange, borderRadius: BorderRadius.circular(5)),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Image.asset(
                iconPath,
                scale: 3,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
      SizedBox(height: 10),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...topics
                .map((topic) => _buildHotTopicTile(topic, isBourse))
                .toList(),
          ],
        ),
      )
    ],
  );
}

Widget _buildHotTopicTile(HotTopic topic, bool isBourse) {
  return RestaurationItem(
      title: topic.title,
      date: topic.dateCreation,
      content: topic.content,
      isBourse: isBourse);
}

// Fonction pour ouvrir le fichier Excel (tu peux l'implémenter)
void openExcelFile(String? excelFileUrl) {
  // Logique pour ouvrir le fichier Excel
  print('Ouverture du fichier Excel: $excelFileUrl');
}
