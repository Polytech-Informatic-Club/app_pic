import 'package:flutter/material.dart';
import 'package:new_app/models/joueur.dart';

Widget updateGoldDialog(BuildContext context, List<Joueur> joueurs) {
  ValueNotifier<Joueur?> _selectedPlayer = ValueNotifier<Joueur?>(null);
  ValueNotifier<int?> _selectedMinute =
      ValueNotifier<int?>(null); // Ajout du notifier pour la minute

  return AlertDialog(
    title: Text("Statistique"),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Voulez-vous faire une mise à jour ?"),
        ValueListenableBuilder<Joueur?>(
          valueListenable: _selectedPlayer,
          builder: (context, selectedPlayer, child) {
            return DropdownButton<Joueur>(
              hint: Text('Joueur'),
              value: joueurs.contains(selectedPlayer) ? selectedPlayer : null,
              onChanged: (Joueur? newValue) {
                _selectedPlayer.value = newValue;
              },
              items: joueurs.map<DropdownMenuItem<Joueur>>((Joueur joueur) {
                return DropdownMenuItem<Joueur>(
                  value: joueur,
                  child: Text(joueur.nom),
                );
              }).toList(),
            );
          },
        ),
        SizedBox(height: 16), // Ajout d'un espace
        ValueListenableBuilder<int?>(
          valueListenable: _selectedMinute,
          builder: (context, selectedMinute, child) {
            return ElevatedButton(
              onPressed: () async {
                int? selected =
                    await showMinutePicker(context); // Sélection de la minute
                if (selected != null) {
                  _selectedMinute.value = selected;
                }
              },
              child: Text(_selectedMinute.value != null
                  ? "Minute: ${_selectedMinute.value}"
                  : "Choisir minute"),
            );
          },
        ),
      ],
    ),
    actions: [
      TextButton(
        child: Text("Annuler"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      TextButton(
        child: Text("+"),
        onPressed: () {
          if (_selectedPlayer.value != null && _selectedMinute.value != null) {
            Navigator.of(context).pop({
              'joueur': _selectedPlayer.value,
              'minute': _selectedMinute.value,
            }); // Renvoyer joueur et minute
          } else {
            // Gérer le cas où l'utilisateur n'a pas sélectionné un joueur ou une minute
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text('Veuillez sélectionner un joueur et une minute')),
            );
          }
        },
      ),
    ],
  );
}

// Fonction pour afficher le sélecteur de minute
Future<int?> showMinutePicker(BuildContext context) async {
  return await showDialog<int>(
    context: context,
    builder: (context) {
      int selectedMinute = 0; // Minute par défaut
      return AlertDialog(
        title: Text("Choisir la minute"),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Sélectionnez la minute où le joueur a marqué."),
                Slider(
                  value: selectedMinute.toDouble(),
                  min: 0,
                  max: 120, // Considérant le temps supplémentaire possible
                  divisions: 120,
                  label: selectedMinute.toString(),
                  onChanged: (double value) {
                    setState(() {
                      selectedMinute = value.toInt();
                    });
                  },
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            child: Text("Annuler"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop(selectedMinute);
            },
          ),
        ],
      );
    },
  );
}