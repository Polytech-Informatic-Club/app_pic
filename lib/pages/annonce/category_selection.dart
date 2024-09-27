import 'package:flutter/material.dart';
import 'package:new_app/pages/annonce/infocard.dart';

class CategorySelection extends StatelessWidget {
  final List<List<InfoCard>> itemLists;
  int value;
  CategorySelection({
    super.key,
    required this.itemLists,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: itemLists[value],
          ),
        ));
  }
}
