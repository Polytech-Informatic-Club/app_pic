// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:new_app/pages/navbar.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
      ),
      bottomNavigationBar: navbar(pageIndex: 4),
    );
  }
}
