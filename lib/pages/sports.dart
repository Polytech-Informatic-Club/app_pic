import 'package:flutter/material.dart';
import 'package:new_app/pages/navbar.dart';

class Sports extends StatefulWidget {
  const Sports({super.key});

  @override
  State<Sports> createState() => _SportsState();
}

class _SportsState extends State<Sports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sports'),
      ),
      bottomNavigationBar: navbar(pageIndex: 3),
    );
  }
}
