import 'package:flutter/material.dart';

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

class RestaurationItem extends StatelessWidget {
  final String title;
  final String content;
  const RestaurationItem(
      {super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
      padding: const EdgeInsets.all(15),
      width: 350,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontFamily: "Inter",
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          RichText(
              text: TextSpan(
            text: content,
            style: const TextStyle(
              fontFamily: "Inter",
              color: Colors.white,
              fontSize: 12,
            ),
          ))
        ],
      ),
    );
  }
}
