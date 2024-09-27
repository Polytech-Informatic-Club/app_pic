import 'package:flutter/material.dart';
import 'package:new_app/pages/annonce/restauration_item.dart';

class Restauration extends StatefulWidget {
  const Restauration({super.key});

  @override
  State<Restauration> createState() => _RestaurationState();
}

class _RestaurationState extends State<Restauration> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RestaurationItem(
                title: "Title",
                content:
                    "Lorem ipsum dolor sit amet consectetur. Massa mauris lectus vitae purus erat adipiscing sed cum. Neque nullam quis nulla id."),
            RestaurationItem(
                title: "Title",
                content:
                    "Lorem ipsum dolor sit amet consectetur. Massa mauris lectus vitae purus erat adipiscing sed cum. Neque nullam quis nulla id."),
            RestaurationItem(
                title: "Title",
                content:
                    "Lorem ipsum dolor sit amet consectetur. Massa mauris lectus vitae purus erat adipiscing sed cum. Neque nullam quis nulla id."),
            RestaurationItem(
                title: "Title",
                content:
                    "Lorem ipsum dolor sit amet consectetur. Massa mauris lectus vitae purus erat adipiscing sed cum. Neque nullam quis nulla id."),
          ],
        ),
      ),
    );
  }
}
