import 'package:flutter/material.dart';
import 'package:new_app/pages/home/navbar.dart';

class Xoss extends StatefulWidget {
  const Xoss({super.key});

  @override
  State<Xoss> createState() => _XossState();
}

class _XossState extends State<Xoss> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Xoss'),
      ),
      bottomNavigationBar: navbar(pageIndex: 0),
    );
  }
}
