import 'package:flutter/material.dart';
import 'package:new_app/pages/annonce/bourses_items.dart';

class Bourses extends StatefulWidget {
  const Bourses({super.key});

  @override
  State<Bourses> createState() => _BoursesState();
}

class _BoursesState extends State<Bourses> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            BoursesItems(
                title: "Bourses",
                content:
                    "Lorem ipsum dolor sit amet consectetur. Massa mauris lectus vitae purus erat adipiscing sed cum. Neque nullam quis nulla id."),
            BoursesItems(
                title: "Bourses",
                content:
                    "Lorem ipsum dolor sit amet consectetur. Massa mauris lectus vitae purus erat adipiscing sed cum. Neque nullam quis nulla id."),
            BoursesItems(
                title: "Bourses",
                content:
                    "Lorem ipsum dolor sit amet consectetur. Massa mauris lectus vitae purus erat adipiscing sed cum. Neque nullam quis nulla id."),
            BoursesItems(
                title: "Bourses",
                content:
                    "Lorem ipsum dolor sit amet consectetur. Massa mauris lectus vitae purus erat adipiscing sed cum. Neque nullam quis nulla id."),
            BoursesItems(
                title: "Bourses",
                content:
                    "Lorem ipsum dolor sit amet consectetur. Massa mauris lectus vitae purus erat adipiscing sed cum. Neque nullam quis nulla id."),
            BoursesItems(
                title: "Bourses",
                content:
                    "Lorem ipsum dolor sit amet consectetur. Massa mauris lectus vitae purus erat adipiscing sed cum. Neque nullam quis nulla id."),
          ],
        ),
      ),
    );
  }
}
