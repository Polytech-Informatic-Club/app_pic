import 'package:flutter/material.dart';
import 'package:new_app/models/promo.dart';
import 'package:new_app/models/utilisateur.dart';
import 'package:new_app/services/user_service.dart';
import 'package:new_app/utils/app_colors.dart';

class PromotionPage extends StatelessWidget {
  String nomPromo;
  PromotionPage(this.nomPromo, {super.key});
  UserService _userService = UserService();

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
              SizedBox(
                height: 60,
              ),
              FutureBuilder<Promo?>(
                  future: _userService.getListByName(nomPromo),
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
              Center(
                child: SizedBox(
                  height: 30,
                  width: 250,
                  child: TextField(
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
              SizedBox(
                height: 20,
              ),
              FutureBuilder<List<Utilisateur>?>(
                  future: _userService.getAllUserInPromo(nomPromo),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Erreur lors de la récupération des données');
                    } else {
                      final promos = snapshot.data;

                      return Column(children: [
                        for (var i in promos!)
                          eleveWidget(
                              i.photo,
                              "${i.prenom} ${i.nom.toUpperCase()}",
                              i.genie,
                              i.telephone),
                      ]);
                    }
                  })
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
        backgroundImage: AssetImage(image),
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
