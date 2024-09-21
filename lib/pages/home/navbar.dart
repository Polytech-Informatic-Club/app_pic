import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/pages/annonces.dart';
import 'package:new_app/pages/home/home_page.dart';
import 'package:new_app/pages/shop/shop.dart';
import 'package:new_app/pages/sports/interclasse.dart';
import 'package:new_app/pages/xoss/xoss.dart';
import 'package:new_app/utils/AppColors.dart';

class navbar extends StatefulWidget {
  const navbar({super.key, required this.pageIndex});
  final int pageIndex;
  @override
  State<navbar> createState() => _navbarState();
}

class _navbarState extends State<navbar> {
  List pageList = [Xoss(), Annonces(), HomePage(), Interclasse(), Shop()];

  void _onSelected(newIndex) {
    if (Navigator.of(context).canPop()) {
      Navigator.pop(context);
    }
    changerPage(context, pageList[newIndex]);
  }

  NavigationDestination _destination(
      String imagePath, String finalPath, String label, double width) {
    return NavigationDestination(
      icon: Image.asset(imagePath, width: width),
      selectedIcon: Image.asset(
        finalPath,
        width: width,
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: BorderDirectional(
          top: BorderSide(color: Colors.black, width: 2),
        ),
      ),
      child: NavigationBar(
        overlayColor: WidgetStatePropertyAll(Colors.white),
        backgroundColor: Colors.white,
        indicatorColor: Colors.white,
        indicatorShape: CircleBorder(),
        selectedIndex: widget.pageIndex,
        onDestinationSelected: _onSelected,
        destinations: [
          _destination('assets/images/Navbar-Icons/xoss.png',
              'assets/images/Navbar-Icons/xoss1.png', '', 30),
          _destination("assets/images/Navbar-Icons/megaphone.png",
              "assets/images/Navbar-Icons/megaphone1.png", '', 30),
          _destination('assets/images/Navbar-Icons/home.png',
              'assets/images/Navbar-Icons/home1.png', '', 30),
          _destination('assets/images/Navbar-Icons/interclasse.png',
              'assets/images/Navbar-Icons/interclasse1.png', '', 30),
          _destination('assets/images/Navbar-Icons/shop.png',
              'assets/images/Navbar-Icons/shop1.png', '', 30),
        ],
      ),
    );
  }
}
