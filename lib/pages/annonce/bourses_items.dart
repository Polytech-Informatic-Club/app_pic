import 'package:flutter/material.dart';
import 'package:new_app/pages/annonce/ept_button.dart';

class BoursesItems extends StatelessWidget {
  final String title;
  final String content;
  const BoursesItems({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
      padding: const EdgeInsets.all(15),
      width: 350,
      height: 150,
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
          )),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              EptButton(
                title: "Voir communiqué",
                width: 150,
                height: 30,
                borderRadius: 5,
                color: Colors.white,
                fontColor: Colors.black,
                fontsize: 12,
              )
            ],
          )
        ],
      ),
    );
  }
}
