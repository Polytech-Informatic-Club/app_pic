import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/login/inscription.dart';
import 'package:new_app/models/role.dart';
import 'package:new_app/models/utilisateur.dart';
import 'package:new_app/pages/home/home_page.dart';
import 'package:new_app/services/UserService.dart';
import 'package:new_app/utils/AppColors.dart';
import 'package:new_app/widgets/alerteMessage.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final UserService _userService = UserService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 350,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          'assets/images/connection-inscription/logo_ept_baobab.png',
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          'assets/images/connection-inscription/cercles_login.png',
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Connexion',
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Tous les services des polytechniciens à portée de main.',
                        style: TextStyle(
                          fontSize: MediaQuery.sizeOf(context).width * 0.035,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Entrer un mail valide';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Mail EPT',
                              labelStyle: TextStyle(fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Entrer un mot de passe valide valide';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Mot de passe',
                              labelStyle: TextStyle(fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () async {},
                              child: Text(
                                'Mot de passe oublié ?',
                                style: TextStyle(color: orange),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  User? user = await _userService
                                      .signInWithEmailAndPassword(
                                    _emailController.text.trim(),
                                    _passwordController.text.trim(),
                                  );
                                  String? role = await _userService
                                      .getUserRole(_emailController.text);
                                  if (user != null && role != null) {
                                    _userService.setRole(role);
                                    changerPage(context, HomePage());
                                  }
                                } catch (e) {
                                  alerteMessageWidget(
                                      context,
                                      "Mot de passe ou email invalide.",
                                      AppColors.echec);
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: orange,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 110, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              'Se connecter',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          )
                        ],
                      )),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Pas de compte? "),
                      TextButton(
                        onPressed: () {
                          changerPage(context, Inscription());
                        },
                        child: Text(
                          'Inscrivez vous',
                          style: TextStyle(
                            color: orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
