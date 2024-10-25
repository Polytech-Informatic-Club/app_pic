import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/models/annonce.dart';
import 'package:new_app/models/categorie.dart';
import 'package:new_app/models/commentaires.dart';
import 'package:new_app/models/utilisateur.dart';
import 'package:new_app/pages/annonce/annonce_screen.dart';
import 'package:new_app/pages/annonce/edit_annonce.dart';
import 'package:new_app/services/annonce_service.dart';
import 'package:new_app/services/user_service.dart';
import 'package:new_app/utils/app_colors.dart';
import 'package:new_app/widgets/submited_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

// Fonction pour ouvrir les liens
Future<void> _onOpenLink(LinkableElement link) async {
  if (await canLaunch(link.url)) {
    await launch(link.url);
  } else {
    throw 'Could not launch ${link.url}';
  }
}

class AfficherAnononceScreen extends StatefulWidget {
  final String image;
  final String titre;
  final String lieu;
  final DateTime date;
  final String description;
  final String idAnnonce;

  AfficherAnononceScreen({
    required this.image,
    required this.titre,
    required this.lieu,
    required this.date,
    required this.description,
    required this.idAnnonce,
    super.key,
  });

  @override
  State<AfficherAnononceScreen> createState() => _AfficherAnononceScreenState();
}

class _AfficherAnononceScreenState extends State<AfficherAnononceScreen> {
  bool isAdmin = false;
  final UserService _userService = UserService();
  final AnnonceService _annonceService = AnnonceService();
  Annonce? _currentAnnonce;
  String? userId;

  @override
  void initState() {
    super.initState();
    _checkUserRole();
    _loadAnnonce();
  }

  Future<void> _loadAnnonce() async {
    Annonce? annonce = await _annonceService.getAnnonceId(widget.idAnnonce);
    if (annonce != null) {
      setState(() {
        _currentAnnonce = annonce;
      });
    }
  }

  Future<void> _checkUserRole() async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        userId = user.email;

        String? role = await _userService.getUserRole(userId!);

        if (role == 'ADMIN_MB') {
          setState(() {
            isAdmin = true;
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
                  heroTag: "editButton",
                  onPressed: () {
                    changerPage(
                        context, EditAnnonce(idAnnonce: widget.idAnnonce));
                  },
                  backgroundColor: AppColors.primary,
                  child: Icon(Icons.edit),
                ),
                SizedBox(width: 10),
                FloatingActionButton(
                  heroTag: "deleteButton",
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
        child: afficherAnnonce(
          widget.image,
          widget.titre,
          widget.lieu,
          widget.date,
          widget.description,
        ),
      ),
    );
  }

  Widget afficherAnnonce(imagePath, title, lieu, dateTime, description) {
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
                      'assets/images/polytech-Info/white_bg_ept.png'),
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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                FullScreenImage(imageUrl: imagePath),
                          ),
                        );
                      },
                      child: SizedBox(
                        height: 370,
                        child: Image(
                          image: ResizeImage(
                            NetworkImage(imagePath),
                            height: 1110, // hauteur souhaitée
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
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
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                lieu,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          height: 10,
          decoration: BoxDecoration(color: jauneClair),
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${simpleDateformat(dateTime)} à ${getHour(widget.date)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
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
                    Linkify(
                      onOpen: _onOpenLink,
                      text: description,
                      style: TextStyle(fontSize: 16),
                      linkStyle: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
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
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                _deleteAnnonce(id, context);
              },
              child: Text('Supprimer'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAnnonce(String id, BuildContext context) async {
    try {
      await AnnonceService().deleteAnnonceById(id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Annonce supprimée avec succès')),
      );
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      changerPage(context, AnnonceScreen());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Erreur lors de la suppression de l\'annonce : $e')),
      );
    }
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  FullScreenImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PhotoView(
            imageProvider: NetworkImage(imageUrl),
            minScale: PhotoViewComputedScale.contained * 1,
            maxScale: PhotoViewComputedScale.covered * 5,
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
