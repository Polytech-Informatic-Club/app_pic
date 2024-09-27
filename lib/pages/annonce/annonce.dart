import 'package:flutter/material.dart';
import 'package:new_app/pages/annonce/assemblee_generale_item.dart';
import 'package:new_app/pages/annonce/hot_topic.dart';
import 'package:new_app/pages/annonce/p_info_nouveaute.dart';
import 'package:new_app/pages/annonce/ept_button.dart';
import 'package:new_app/pages/annonces.dart';
import 'package:new_app/pages/home/app_drawer.dart';
import 'package:new_app/pages/home/navbar.dart';

class Annonce extends StatefulWidget {
  const Annonce({super.key});

  @override
  State<Annonce> createState() => _AnnonceState();
}

class _AnnonceState extends State<Annonce> {
  bool annonceAvailable = true;
  bool isAdmin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Polytech Info'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      drawer: Appdrawer(),
      bottomNavigationBar: navbar(pageIndex: 1),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
        children: [
          widgetAG('Jeudi 15 Octobre', '19h30', 'Case des Polytechniciens',
              'Divers'),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 50),
            child: Column(
              children: [
                // if (annonceAvailable) ...[
                //   Row(
                //     children: [
                //       AssembleeGeneraleItem(
                //           date: "Jeudi 13 Juin",
                //           time: "22h30",
                //           location: "Case de Polytechniciens",
                //           topic: "Divers"),
                //     ],
                //   ),
                //   const SizedBox(
                //     height: 20,
                //   ),
                //   if (isAdmin) ...[
                //     EptButton(
                //       title: "Annoncer",
                //       width: 150,
                //       height: 40,
                //       borderRadius: 5,
                //     )
                //   ],
                //   const SizedBox(
                //     height: 40,
                //   ),
                // ],

                const PInfoNouveaute(),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: 250,
                  height: 3,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 30,
                ),
                const HotTopic(),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
