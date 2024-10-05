import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/models/user.dart';
import 'package:new_app/services/annonce_service.dart';
import 'package:new_app/services/user_service.dart';
import 'package:new_app/utils/app_colors.dart';
import 'package:new_app/widgets/submited_button.dart';

class AfficherAnononceScreen extends StatefulWidget {
  final String image;
  final String titre;
  final String lieu;
  final DateTime date;
  final String description;
  final String idAnnonce;
  AfficherAnononceScreen(
      {required this.image,
      required this.titre,
      required this.lieu,
      required this.date,
      required this.description,
      required this.idAnnonce,
      super.key});

  @override
  State<AfficherAnononceScreen> createState() => _AfficherAnononceScreenState();
}

class _AfficherAnononceScreenState extends State<AfficherAnononceScreen> {
  bool isAdmin = false;
  final UserService _userService = UserService();

  // Initialement, l'utilisateur n'est pas admin
  String? userId;
  // Stocker l'ID de l'utilisateur connecté
  @override
  void initState() {
    super.initState();
    _checkUserRole(); // Appel pour vérifier le rôle de l'utilisateur
  }

  Future<void> _checkUserRole() async {
    try {
      // Récupérer l'utilisateur connecté via FirebaseAuth
      var user = FirebaseAuth.instance.currentUser;
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
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
        ),
        extendBodyBehindAppBar: true,
        floatingActionButton: isAdmin
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    heroTag:
                        "editButton", // Chaque bouton doit avoir un heroTag unique
                    onPressed: () {},
                    backgroundColor: AppColors.primary,
                    child: Icon(Icons.edit),
                  ),
                  SizedBox(width: 10),
                  FloatingActionButton(
                    heroTag: "deleteButton", // Unique heroTag
                    onPressed: () {
                      _showDeleteConfirmation(context, widget.idAnnonce);
                    },
                    backgroundColor: Colors.red,
                    child: Icon(Icons.delete),
                  ),
                ],
              )
            : null,
        body: SingleChildScrollView(
          child: afficherAnnonce(widget.image, widget.titre, widget.lieu,
              widget.date, widget.description),
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
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
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
                '${simpleDateformat(dateTime)} à ${getHour(widget.date)}',
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

void _showDeleteConfirmation(BuildContext context, String id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirmer la suppression'),
        content: Text('Êtes-vous sûr de vouloir supprimer cette annonce ?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Ferme le dialogue si l'utilisateur annule
              Navigator.of(context).pop();
            },
            child: Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              // Supprime l'annonce et quitte la page
              _deleteAnnonce(id, context);
            },
            child: Text('Supprimer'),
          ),
        ],
      );
    },
  );
}

// Fonction pour supprimer l'annonce
void _deleteAnnonce(String id, BuildContext context) async {
  try {
    // Appelle ton service pour supprimer l'annonce
    await AnnonceService().deleteAnnonceById(id);

    // Affiche un message de succès (si tu veux)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Annonce supprimée avec succès'),
      ),
    );

    // Ferme le dialogue de confirmation
    Navigator.of(context).pop(); // Ferme le AlertDialog

    // Quitte la page après la suppression
    Navigator.of(context).pop(); // Ferme la page actuelle
  } catch (e) {
    // Si une erreur survient, affiche un message d'erreur
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Erreur lors de la suppression de l\'annonce : $e'),
      ),
    );
  }
}
