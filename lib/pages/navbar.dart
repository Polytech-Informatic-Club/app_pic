import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/pages/annonces.dart';
import 'package:new_app/pages/home_page.dart';
import 'package:new_app/pages/shop.dart';
import 'package:new_app/pages/sports.dart';
import 'package:new_app/pages/xoss.dart';

class navbar extends StatefulWidget {
  const navbar({super.key, required this.pageIndex});
  final int pageIndex;
  @override
  State<navbar> createState() => _navbarState();
}

class _navbarState extends State<navbar> {
  List pageList = [Xoss(), Annonces(), HomePage(), Sports(), Shop()];

  void _onSelected(newIndex) {
    if (Navigator.of(context).canPop()) {
      Navigator.pop(context);
    }
    changerPage(context, pageList[newIndex]);
  }

  NavigationDestination _destination(
      String imagePath, String label, double width) {
    return NavigationDestination(
      icon: Image.asset(imagePath, width: width, color: Colors.yellow),
      selectedIcon: Image.asset(
        imagePath,
        width: width,
        color: Colors.yellow,
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      // indicatorColor: Colors.white,
      selectedIndex: widget.pageIndex,
      onDestinationSelected: _onSelected,
      destinations: [
        _destination('assets/home-icon.png', '', 30),
        _destination("assets/home-icon.png", '', 30),
        _destination('assets/home-icon.png', '', 30),
        _destination('assets/home-icon.png', '', 30),
        _destination('assets/home-icon.png', '', 30),
      ],
    );
  }
}
