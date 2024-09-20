import 'package:flutter/material.dart';
import 'package:new_app/pages/navbar.dart';

class Annonces extends StatefulWidget {
  const Annonces({super.key});

  @override
  State<Annonces> createState() => _AnnoncesState();
}

class _AnnoncesState extends State<Annonces> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Annonces'),
      ),
      bottomNavigationBar: navbar(pageIndex: 1),
    );
  }
}
