import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/login/login.dart';
import 'package:new_app/models/enums/role_type.dart';
import 'package:new_app/objets_perdus.dart';
import 'package:new_app/pages/interclasse/football/home_admin_football_age.dart';
import 'package:new_app/services/user_service.dart';
import 'package:new_app/utils/app_colors.dart';

class EptDrawer extends StatelessWidget {
  final UserService _userService = new UserService();

  EptDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    double size = 100;
    return Drawer(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: eptLighterOrange,
        child: FutureBuilder<String?>(
          future: _userService.getRole(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Erreur lors de la récupération du rôle');
            } else {
              final role = snapshot.data ?? 'role';
              return Column(
                mainAxisSize: MainAxisSize.min, // Ajoute cette ligne
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                      width: size,
                      height: size,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: eptOrange,
                      ),
                      child: Container(
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200)),
                        clipBehavior: Clip.hardEdge,
                        child: Image.asset(
                          "assets/images/homepage/profile.png",
                          fit: BoxFit.cover,
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Gnatam Guaye",
                    style: TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  Text(
                    role,
                    style: TextStyle(fontFamily: "Inter", fontSize: 11),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Container(
                    width: 200,
                    height: 1,
                    color: Colors.black,
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  DrawerItem(
                      imagePath: "assets/images/top-left-menu/compte.png",
                      title: "Compte",
                      onTap: () {}),
                  DrawerItem(
                      imagePath: "assets/images/top-left-menu/compte.png",
                      title: "Famille Polytechnicienne",
                      onTap: () {}),
                  DrawerItem(
                      imagePath: "assets/images/top-left-menu/jumelles.png",
                      title: "Objets perdus",
                      onTap: () {
                        changerPage(context, ObjetsPerdus());
                      }),
                  DrawerItem(
                      imagePath: "assets/images/top-left-menu/paramètres.png",
                      title: "Paramètres",
                      onTap: () {}),
                  if (role == RoleType.ADMIN.toString().split(".").last ||
                      role ==
                          RoleType.ADMIN_FOOTBALL.toString().split(".").last ||
                      role == RoleType.ADMIN_BASKET.toString().split(".").last)
                    DrawerItem(
                      imagePath: "assets/images/top-left-menu/paramètres.png",
                      title: Text('Administraion ${role.toLowerCase()}'),
                      onTap: () {
                        changerPage(context,
                            HomeAdminFootballPage(role.split("_").last));
                      },
                    ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 200,
                    height: 1,
                    color: Colors.black,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  DrawerItem(
                    imagePath: "assets/images/top-left-menu/facebook.png",
                    title: "compte",
                    onTap: () {},
                    isLink: true,
                  ),
                  DrawerItem(
                    imagePath: "assets/images/top-left-menu/instagram.png",
                    title: "compte",
                    onTap: () {},
                    isLink: true,
                  ),
                  DrawerItem(
                    imagePath: "assets/images/top-left-menu/x.png",
                    title: "compte",
                    onTap: () {},
                    isLink: true,
                  ),
                  DrawerItem(
                    imagePath: "assets/images/top-left-menu/internet.png",
                    title: "compte",
                    onTap: () {},
                    isLink: true,
                  ),
                  // SizedBox(height: 15,),
                  InkWell(
                    onTap: () {
                      _userService.signOut();
                      changerPage(context, LoginScreen());
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      width: 150,
                      height: 40,
                      decoration: BoxDecoration(
                          color: eptOrange,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(children: [
                        Image.asset(
                          "assets/images/top-left-menu/sortie.png",
                          scale: 4,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Déconnexion",
                          style: TextStyle(fontFamily: "Inter", fontSize: 12),
                        ),
                      ]),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "PolyApp version 1.0.0",
                    style: TextStyle(
                        fontFamily: "Inter", fontSize: 10, color: eptDarkGrey),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 5,
                    color: eptOrange,
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String imagePath;
  final title;
  Function onTap;
  bool isLink;
  DrawerItem(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.onTap,
      this.isLink = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { onTap(); },
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
        color: Colors.white,
        width: 250,
        height: 40,
        child: Row(
          children: [
            Image.asset(
              imagePath,
              scale: 4,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              title,
              style: const TextStyle(fontFamily: "Inter", fontSize: 12),
            ),
            if (isLink) ...[
              Spacer(),
              Image.asset(
                "assets/images/top-left-menu/external_link.png",
                scale: 1,
              )
            ]
          ],
        ),
      ),
    );
  }
}
