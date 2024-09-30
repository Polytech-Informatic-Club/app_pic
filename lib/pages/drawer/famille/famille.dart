import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/models/promo.dart';
import 'package:new_app/pages/drawer/famille/promo.dart';
import 'package:new_app/pages/home/home_page.dart';
import 'package:new_app/services/user_service.dart';
import 'package:new_app/utils/app_colors.dart';

class FamillePolytechnicienneScreen extends StatelessWidget {
  FamillePolytechnicienneScreen({Key? key}) : super(key: key);

  UserService _userService = UserService();

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
                  height: 26,
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                      // focusedBorder: OutlineInputBorder(
                      //     borderSide: BorderSide(color: Colors.black, width: 2),
                      //     borderRadius: BorderRadius.circular(30)),
                      hintText: 'chercher',
                      hintStyle: TextStyle(
                        fontSize: 12,
                      ),
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(style: BorderStyle.none),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              FutureBuilder<List<Promo>?>(
                  future: _userService.getListPromo(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Erreur lors de la récupération des données');
                    } else {
                      final promos = snapshot.data;

                      return Column(
                        children: [
                          for (var i in promos!)
                            promoWidget(i.logo, i.nom, i.total, i.devise,
                                PromotionPage(i.nom)),
                        ],
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}

Widget promoWidget(logo, nom, nombre, devise, page) {
  return Builder(builder: (context) {
    return InkWell(
      onTap: () {
        changerPage(context, page);
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10),
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
    );
  });
}
