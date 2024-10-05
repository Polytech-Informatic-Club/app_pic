import 'package:flutter/material.dart';
import 'package:new_app/models/promo.dart';
import 'package:new_app/models/utilisateur.dart';
import 'package:new_app/services/user_service.dart';
import 'package:new_app/utils/app_colors.dart';

class PromotionPage extends StatefulWidget {
  String nomPromo;
  PromotionPage(this.nomPromo, {super.key});

  @override
  _PromotionPageState createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> {
  UserService _userService = UserService();
  TextEditingController _searchController = TextEditingController();
  List<Utilisateur> _utilisateurs = [];
  List<Utilisateur> _filteredUtilisateurs = [];

  @override
  void initState() {
    super.initState();
    _loadUtilisateurs();
    _searchController.addListener(_filterUtilisateurs);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Charger les utilisateurs de la promo
  Future<void> _loadUtilisateurs() async {
    final utilisateurs = await _userService.getAllUserInPromo(widget.nomPromo);
    setState(() {
      _utilisateurs = utilisateurs;
      _filteredUtilisateurs = _utilisateurs;
    });
  }

  // Filtrer les utilisateurs en fonction de la recherche
  void _filterUtilisateurs() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredUtilisateurs = _utilisateurs.where((utilisateur) {
        final fullName =
            '${utilisateur.prenom} ${utilisateur.nom}'.toLowerCase();
        final genie = utilisateur.genie?.toLowerCase() ?? '';
        final telephone = utilisateur.telephone ?? '';

        return fullName.contains(query) ||
            genie.contains(query) ||
            telephone.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              FutureBuilder<Promo?>(
                  future: _userService.getListByName(widget.nomPromo),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Erreur lors de la récupération des données');
                    } else {
                      final promo = snapshot.data;

                      return Center(
                        child: Column(
                          children: [
                            Image.network(
                              promo!.logo,
                              height: 150,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Promotion ${promo.nom}',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Devise: "${promo.devise}"',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }),
              SizedBox(height: 20),
              // Barre de recherche
              Center(
                child: SizedBox(
                  height: 30,
                  width: 250,
                  child: TextField(
                    controller:
                        _searchController, // Controller pour la recherche
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
              SizedBox(height: 20),
              // Affichage des utilisateurs
              _filteredUtilisateurs.isNotEmpty
                  ? Column(
                      children: [
                        for (var utilisateur in _filteredUtilisateurs)
                          eleveWidget(
                            utilisateur.photo,
                            "${utilisateur.prenom} ${utilisateur.nom.toUpperCase()}",
                            utilisateur.genie ?? 'Aucun génie spécifié',
                            utilisateur.telephone ?? 'Numéro non disponible',
                          ),
                      ],
                    )
                  : Text("Aucun utilisateur trouvé"),
            ],
          ),
        ),
      ),
    );
  }
}

Widget eleveWidget(image, nom, genie, numero) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: 5),
    elevation: 0,
    color: eptLighterOrange,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    child: ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(image),
        radius: 30,
      ),
      title: Text(
        nom,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(genie),
          Row(
            children: [
              Icon(Icons.phone, size: 14),
              SizedBox(width: 5),
              Text(numero),
            ],
          ),
        ],
      ),
    ),
  );
}
