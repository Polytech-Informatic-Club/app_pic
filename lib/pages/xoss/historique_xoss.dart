import 'package:flutter/material.dart';

class HistoriqueXoss extends StatelessWidget {
  const HistoriqueXoss({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historiques'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Retour à la page précédente
          },
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
    );
  }
}
