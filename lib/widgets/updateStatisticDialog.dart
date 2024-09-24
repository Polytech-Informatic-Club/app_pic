import 'package:flutter/material.dart';

Widget updateStatisticDialog(BuildContext context) {
  return AlertDialog(
    title: Text("Statistique "),
    content: Text("Voulez-vous faire une mise à jour ?"),
    actions: [
      TextButton(
        child: Text("Annuler"),
        onPressed: () {
          Navigator.of(context).pop(); // Ne pas supprimer
        },
      ),
      TextButton(
        child: Text("-"),
        onPressed: () {
          Navigator.of(context).pop(false); // Ne pas supprimer
        },
      ),
      TextButton(
        child: Text("+"),
        onPressed: () {
          Navigator.of(context).pop(true); // Confirmer la suppression
        },
      ),
    ],
  );
}
