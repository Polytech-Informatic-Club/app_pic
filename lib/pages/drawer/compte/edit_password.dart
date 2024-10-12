import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/pages/drawer/compte/compte.dart';
import 'package:new_app/utils/app_colors.dart';
import 'package:new_app/widgets/alerte_message.dart';
import 'package:new_app/widgets/reusable_widgets.dart';
import 'package:new_app/widgets/submited_button.dart';

class EditPassword extends StatefulWidget {
  const EditPassword({super.key});

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();
  bool _isCurrentPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmNewPasswordVisible = false;
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  final ValueNotifier<double> _strengthNotifier = ValueNotifier(0.0);
  bool _hasStartedTypingPassword = false;
  final ValueNotifier<bool> _passwordsMatchNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text("Modification du mot de passe"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.02, 20, 0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _currentPasswordController,
                  obscureText: !_isCurrentPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe actuel',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isCurrentPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isCurrentPasswordVisible =
                              !_isCurrentPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre mot de passe actuel';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                _buildNewPasswordField(),
                SizedBox(height: 20),
                _buildConfirmPasswordField(),
                SizedBox(height: 20),
                SubmittedButton("Valider", () async {
                  if (_newPasswordController.text.isEmpty ||
                      _confirmNewPasswordController.text.isEmpty ||
                      _newPasswordController.text !=
                          _confirmNewPasswordController.text) {
                    alerteMessageWidget(
                      context,
                      "Les nouveaux mots de passe ne correspondent pas.",
                      AppColors.echec,
                    );
                    return;
                  }
                  changerPage(context, CompteScreen());
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNewPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _newPasswordController,
          obscureText: !_isNewPasswordVisible,
          onChanged: (value) {
            setState(() {
              _hasStartedTypingPassword = value.isNotEmpty;
            });
            _checkPasswordStrength(value);
            _checkPasswordsMatch();
          },
          decoration: InputDecoration(
            labelText: 'Nouveau mot de passe',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            suffixIcon: IconButton(
              icon: Icon(
                _isNewPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isNewPasswordVisible = !_isNewPasswordVisible;
                });
              },
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer un mot de passe valide';
            } else if (value.length < 8) {
              return 'Le mot de passe doit contenir au moins 8 caractères';
            } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
              return 'Le mot de passe doit contenir au moins une majuscule';
            } else if (!RegExp(r'[0-9]').hasMatch(value)) {
              return 'Le mot de passe doit contenir au moins un chiffre';
            } else if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
              return 'Le mot de passe doit contenir au moins un caractère spécial';
            }
            return null;
          },
        ),
        if (_hasStartedTypingPassword) ...[
          SizedBox(height: 10),
          ValueListenableBuilder<double>(
            valueListenable: _strengthNotifier,
            builder: (context, strength, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(
                    value: strength,
                    backgroundColor: Colors.grey[300],
                    color: strength <= 0.5
                        ? Colors.red
                        : (strength <= 0.75 ? Colors.orange : Colors.green),
                    minHeight: 10,
                  ),
                  SizedBox(height: 10),
                  Text(
                    strength <= 0.25
                        ? 'Mot de passe faible'
                        : (strength <= 0.5
                            ? 'Mot de passe moyen'
                            : (strength <= 0.75
                                ? 'Mot de passe fort'
                                : 'Mot de passe très fort')),
                    style: TextStyle(
                        color: strength <= 0.5
                            ? Colors.red
                            : (strength <= 0.75
                                ? Colors.orange
                                : Colors.green)),
                  ),
                ],
              );
            },
          ),
        ],
      ],
    );
  }

  Widget _buildConfirmPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _confirmNewPasswordController,
          obscureText: !_isConfirmNewPasswordVisible,
          onChanged: (value) {
            _checkPasswordsMatch();
          },
          decoration: InputDecoration(
            labelText: 'Confirmer nouveau mot de passe',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            suffixIcon: IconButton(
              icon: Icon(
                _isConfirmNewPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isConfirmNewPasswordVisible = !_isConfirmNewPasswordVisible;
                });
              },
            ),
          ),
        ),
        SizedBox(height: 10),
        ValueListenableBuilder<bool>(
          valueListenable: _passwordsMatchNotifier,
          builder: (context, passwordsMatch, child) {
            return Text(
              passwordsMatch
                  ? 'Les mots de passe correspondent'
                  : 'Les mots de passe ne correspondent pas',
              style: TextStyle(
                color: passwordsMatch ? Colors.green : Colors.red,
              ),
            );
          },
        ),
      ],
    );
  }

  void _checkPasswordStrength(String password) {
    double strength = 0.0;
    if (password.length >= 8) strength += 0.25;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength += 0.25;
    if (RegExp(r'[0-9]').hasMatch(password)) strength += 0.25;
    if (RegExp(r'[!@#\$&*~]').hasMatch(password)) strength += 0.25;
    _strengthNotifier.value = strength;
  }

  void _checkPasswordsMatch() {
    _passwordsMatchNotifier.value =
        _newPasswordController.text == _confirmNewPasswordController.text;
  }
}
