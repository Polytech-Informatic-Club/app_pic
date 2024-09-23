import 'package:flutter/material.dart';

Widget deleteConfirmedDialog(BuildContext context) {
  return AlertDialog(
    title: Text("Confirmer la suppression"),
    content: Text("Voulez-vous vraiment supprimer ce commentaire ?"),
    actions: [
      TextButton(
        child: Text("Annuler"),
        onPressed: () {
          Navigator.of(context).pop(false); // Ne pas supprimer
        },
      ),
      TextButton(
        child: Text("Supprimer"),
        onPressed: () {
          Navigator.of(context).pop(true); // Confirmer la suppression
        },
      ),
    ],
  );
}
