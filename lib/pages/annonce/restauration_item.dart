import 'package:flutter/material.dart';

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
