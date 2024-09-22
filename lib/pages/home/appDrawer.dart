import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/login/login.dart';
import 'package:new_app/models/enums/role_type.dart';
import 'package:new_app/pages/sports/football/homeAdminFootballPage.dart';
import 'package:new_app/services/UserService.dart';
import 'package:new_app/utils/AppColors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Appdrawer extends StatelessWidget {
  final UserService _userService = new UserService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context)
                      .size
                      .height, // Contraintes pour limiter la hauteur
                ),
                child: IntrinsicHeight(
                    // Permet à l'enfant de prendre la hauteur minimum requise
                    child: FutureBuilder<String?>(
                        future: _userService.getRole(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text(
                                'Erreur lors de la récupération du rôle');
                          } else {
                            final role = snapshot.data ?? 'role';
                            return Column(
                              mainAxisSize:
                                  MainAxisSize.min, // Ajoute cette ligne
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // En-tête du Drawer avec l'image de profil et le nom
                                Center(
                                    child: UserAccountsDrawerHeader(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF8E9D8),
                                  ),
                                  currentAccountPicture: CircleAvatar(
                                    radius: 60,
                                    backgroundImage: NetworkImage(
                                        'https://ept.sn/wp-content/uploads/2017/01/IMG_3913.png'), // Remplace par l'image
                                  ),
                                  accountName: Text(
                                    'Gnatam Gaye',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black),
                                  ),
                                  accountEmail: Text(
                                    role,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black),
                                  ),
                                )),

                                // Liste des options
                                ListTile(
                                  leading: Icon(Icons.person),
                                  title: Text('Compte'),
                                  onTap: () {},
                                ),
                                ListTile(
                                  leading: Icon(Icons.search),
                                  title: Text('Objets perdus'),
                                  onTap: () {},
                                ),
                                ListTile(
                                  leading: Icon(Icons.settings),
                                  title: Text('Paramètres'),
                                  onTap: () {},
                                ),

                                Divider(thickness: 1),
                                if (role ==
                                        RoleType.ADMIN
                                            .toString()
                                            .split(".")
                                            .last ||
                                    role == RoleType.ADMIN_FOOTBALL.toString())
                                  ListTile(
                                    leading: Icon(Icons.settings),
                                    title: Text('Administraion football'),
                                    onTap: () {
                                      changerPage(
                                          context, HomeAdminFootballPage());
                                    },
                                  ),

                                Divider(thickness: 1),

                                // Autres options
                                ListTile(
                                  leading: Icon(Icons.facebook),
                                  title: Text('Compte'),
                                  trailing: Icon(Icons.open_in_new),
                                  onTap: () {},
                                ),
                                ListTile(
                                  leading: Icon(Icons.account_circle),
                                  title: Text('Compte'),
                                  trailing: Icon(Icons.open_in_new),
                                  onTap: () {},
                                ),
                                ListTile(
                                  leading: Icon(Icons.cancel),
                                  title: Text('Compte'),
                                  trailing: Icon(Icons.open_in_new),
                                  onTap: () {},
                                ),
                                ListTile(
                                  leading: Icon(Icons.language),
                                  title: Text('Compte'),
                                  trailing: Icon(Icons.open_in_new),
                                  onTap: () {},
                                ),

                                Spacer(),

                                // Bouton Déconnexion
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange,
                                      surfaceTintColor: Colors.black,
                                      minimumSize: Size(double.infinity, 50),
                                    ),
                                    icon: Icon(Icons.logout),
                                    label: Text('Déconnexion'),
                                    onPressed: () {
                                      _userService.signOut();
                                      changerPage(context, LoginScreen());
                                    },
                                  ),
                                ),

                                SizedBox(height: 10),

                                // Version de l'application
                                Text(
                                  'PolyApp version 1.0.0',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            );
                          }
                        })))));
  }
}
