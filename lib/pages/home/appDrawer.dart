import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/login/login.dart';
import 'package:new_app/services/UserService.dart';

class Appdrawer extends StatelessWidget {
  UserService _userService = new UserService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
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
              backgroundImage: AssetImage(
                  'assets/profile_picture.png'), // Remplace par l'image
            ),
            accountName: Text(
              'Gnatam Gaye',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: null,
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
            padding: EdgeInsets.symmetric(horizontal: 16.0),
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
      ),
    );
  }
}
