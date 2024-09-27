import 'package:flutter/material.dart';

class ObjetsPerdus extends StatefulWidget {
  const ObjetsPerdus({super.key});

  @override
  State<ObjetsPerdus> createState() => _ObjetsPerdusState();
}

class _ObjetsPerdusState extends State<ObjetsPerdus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Objets Perdus",
          style: TextStyle(
              fontSize: 20,
              fontFamily: "Inter",
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(),
    );
  }
}
