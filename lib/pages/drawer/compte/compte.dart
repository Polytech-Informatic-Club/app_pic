import 'package:flutter/material.dart';
import 'package:new_app/utils/app_colors.dart';

class Compte extends StatelessWidget {
  const Compte({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compte'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Forme en cercle
                      border: Border.all(
                        color: orange, // Couleur de la bordure
                        width: 4.0, // Largeur de la bordure
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage(''),
                      backgroundColor: grisClair,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.black,
                    height: 2,
                    width: 100,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text('Prénom(s)'),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: eptLighterOrange,
                  borderRadius: BorderRadius.circular(10)),
              child: Text('Mohamed El Amine'),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Nom'),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: eptLighterOrange,
                  borderRadius: BorderRadius.circular(10)),
              child: Text('Sembene'),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Numéro'),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: eptLighterOrange,
                  borderRadius: BorderRadius.circular(10)),
              child: Text('777777777'),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Mot de passe'),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: eptLighterOrange,
                  borderRadius: BorderRadius.circular(10)),
              child: Text('*********'),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
