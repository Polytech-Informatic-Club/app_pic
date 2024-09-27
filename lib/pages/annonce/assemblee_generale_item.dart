import 'package:flutter/material.dart';
import 'dart:io';

import 'package:new_app/utils/app_colors.dart';

class AssembleeGeneraleItem extends StatelessWidget {
  final String date;
  final String time;
  final String location;
  final String topic;
  File? communique;

  AssembleeGeneraleItem(
      {super.key,
      required this.date,
      required this.time,
      required this.location,
      required this.topic,
      this.communique});

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
          width: 370,
          height: 180,
          decoration: BoxDecoration(
              color: jauneClair, borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Assemblée générale",
                style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/images/polytech-Info/icons8-calendrier-60.png",
                    scale: 5,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    date,
                    style: const TextStyle(fontFamily: "Inter", fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/images/polytech-Info/icons8-calendrier-60.png",
                    scale: 5,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    time,
                    style: const TextStyle(fontFamily: "Inter", fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/images/polytech-Info/icons8-marqueur-90.png",
                    scale: 5,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    location,
                    style: const TextStyle(fontFamily: "Inter", fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/images/polytech-Info/icons8-analyse-de-reconnaissance-vocale-90.png",
                    scale: 5,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    topic,
                    style: const TextStyle(fontFamily: "Inter", fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 150,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                    child: Text(
                      "Voir communiqué",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      Positioned(
          right: -45,
          top: -30,
          child: Image.asset(
            "assets/images/polytech-Info/schedule.png",
            scale: 7,
          )),
    ]);
  }
}
