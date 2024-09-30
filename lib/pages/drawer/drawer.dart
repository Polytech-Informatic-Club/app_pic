import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/login/login.dart';
import 'package:new_app/models/enums/role_type.dart';
import 'package:new_app/objets_perdus.dart';
import 'package:new_app/pages/drawer/famille.dart';
import 'package:new_app/pages/interclasse/football/home_admin_sport_type_page.dart';
import 'package:new_app/services/user_service.dart';
import 'package:new_app/utils/app_colors.dart';

class EptDrawer extends StatefulWidget {
  EptDrawer({super.key});

  @override
  State<EptDrawer> createState() => _EptDrawerState();
}

class _EptDrawerState extends State<EptDrawer> {
  final UserService _userService = new UserService();

  @override
  Widget build(BuildContext context) {
    double size = 100;
    return Drawer(
      backgroundColor: eptLighterOrange,
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
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          const Text(
                            "Gnatam Gaye",
                            style: TextStyle(
                                fontFamily: "Inter",
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          Text(
                            role,
                            style: TextStyle(fontFamily: "Inter", fontSize: 11),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      Column(
                        children: [
                          Container(
                            width: 200,
                            height: 1,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      drawerItem("assets/images/top-left-menu/compte.png",
                          "Compte", () {}),
                      drawerItem("assets/images/top-left-menu/famille.png",
                          "Famille Polytechnicienne", () {
                        changerPage(context, FamillePolytechnicienneScreen());
                      }),
                      drawerItem("assets/images/top-left-menu/jumelles.png",
                          "Objets perdus", () {
                        changerPage(context, ObjetsPerdus());
                      }),

                      drawerItem("assets/images/top-left-menu/a_propos.png",
                          "A propos", () {}),
                      if (role == RoleType.ADMIN.toString().split(".").last ||
                          role ==
                              RoleType.ADMIN_FOOTBALL
                                  .toString()
                                  .split(".")
                                  .last ||
                          role ==
                              RoleType.ADMIN_BASKETBALL
                                  .toString()
                                  .split(".")
                                  .last ||
                          role ==
                              RoleType.ADMIN_VOLLEYBALL
                                  .toString()
                                  .split(".")
                                  .last ||
                          role ==
                              RoleType.ADMIN_JEUX_ESPRIT
                                  .toString()
                                  .split(".")
                                  .last)
                        drawerItem(
                          "assets/images/top-left-menu/paramètres.png",
                          'Administration ${role.split("_").sublist(1, role.split("_").length).join(" ").toLowerCase()}',
                          () {
                            changerPage(
                                context,
                                HomeAdminSportTypePage(role
                                    .split("_")
                                    .sublist(1, role.split("_").length)
                                    .join("_")));
                          },
                        ),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        children: [
                          Container(
                            width: 200,
                            height: 1,
                            color: Colors.black,
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      drawerItem(
                        "assets/images/top-left-menu/facebook.png",
                        "compte",
                        () {},
                        isLink: true,
                      ),
                      drawerItem(
                        "assets/images/top-left-menu/instagram.png",
                        "compte",
                        () {},
                        isLink: true,
                      ),
                      drawerItem(
                        "assets/images/top-left-menu/x.png",
                        "compte",
                        () {},
                        isLink: true,
                      ),

                      // SizedBox(height: 15,),
                      Column(
                        children: [
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
                                  style: TextStyle(
                                      fontFamily: "Inter", fontSize: 12),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
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
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

Widget drawerItem(final String imagePath, final title, ontap,
    {bool isLink = false}) {
  return Builder(builder: (context) {
    return InkWell(
      onTap: ontap,
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
  });
}
