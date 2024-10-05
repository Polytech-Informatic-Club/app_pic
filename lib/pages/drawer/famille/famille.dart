import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/models/promo.dart';
import 'package:new_app/pages/drawer/famille/promo.dart';
import 'package:new_app/services/user_service.dart';
import 'package:new_app/utils/app_colors.dart';

class FamillePolytechnicienneScreen extends StatefulWidget {
  FamillePolytechnicienneScreen({Key? key}) : super(key: key);

  @override
  _FamillePolytechnicienneScreenState createState() =>
      _FamillePolytechnicienneScreenState();
}

class _FamillePolytechnicienneScreenState
    extends State<FamillePolytechnicienneScreen> {
  UserService _userService = UserService();
  TextEditingController _searchController = TextEditingController();
  List<Promo> _promos = [];
  List<Promo> _filteredPromos = [];

  @override
  void initState() {
    super.initState();
    // Charger les données à l'initialisation
    _loadPromos();
    // Écouter les changements de texte
    _searchController.addListener(_filterPromos);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Charger la liste des promos
  Future<void> _loadPromos() async {
    final promos = await _userService.getListPromo();
    setState(() {
      _promos = promos;
      _filteredPromos = _promos; // Afficher toutes les promos au début
    });
  }

  // Filtrer les promos en fonction de la recherche
  void _filterPromos() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredPromos = _promos.where((promo) {
        return promo.nom.toLowerCase().contains(query) ||
            promo.devise.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Famille Polytechnicienne'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 30,
                  width: 250,
                  child: TextField(
                    controller: _searchController, // Ajout du controller
                    decoration: InputDecoration(
                      hintText: 'chercher',
                      hintStyle:
                          TextStyle(fontSize: 12, fontFamily: 'InterMedium'),
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              // Afficher la liste filtrée
              _filteredPromos.isNotEmpty
                  ? Column(
                      children: [
                        for (var promo in _filteredPromos)
                          promoWidget(promo.logo, promo.nom, promo.total,
                              promo.devise, PromotionPage(promo.nom)),
                      ],
                    )
                  : Text("Aucun résultat trouvé"),
            ],
          ),
        ),
      ),
    );
  }
}

Widget promoWidget(logo, nom, nombre, devise, page) {
  return Builder(builder: (context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            changerPage(context, page);
          },
          child: Card(
            elevation: 0,
            color: eptLighterOrange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(logo), // Chemin de l'image
              ),
              title: Text(
                nom,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              subtitle: Text(devise),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 4),
                  Text(nombre),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  });
}
