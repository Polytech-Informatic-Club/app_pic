import 'package:flutter/material.dart';
import 'package:new_app/pages/annonce/infocard.dart';
import 'package:new_app/pages/annonce/p_info_nouveaute.dart';
import 'package:new_app/pages/home/section_selector.dart';

List<InfoCard> listeInfoCard = [
  InfoCard(
      image: Image.asset(
        "assets/images/homepage/annonce1.jpg",
        fit: BoxFit.cover,
      ),
      widget: Container(),
      width: 140,
      height: 200,
      borderRadius: 20),
  InfoCard(
      image: Image.asset(
        "assets/images/homepage/annonce2.jpg",
        fit: BoxFit.cover,
      ),
      widget: Container(),
      width: 140,
      height: 200,
      borderRadius: 20),
  InfoCard(
      image: Image.asset(
        "assets/images/homepage/annonce1.jpg",
        fit: BoxFit.cover,
      ),
      widget: Container(),
      width: 140,
      height: 200,
      borderRadius: 20),
  InfoCard(
      image: Image.asset(
        "assets/images/homepage/annonce2.jpg",
        fit: BoxFit.cover,
      ),
      widget: Container(),
      width: 140,
      height: 200,
      borderRadius: 20),
];
List<InfoCard> listeInfoCard2 = [
  InfoCard(
      image: Image.asset(
        "assets/images/homepage/annonce1.jpg",
        fit: BoxFit.cover,
      ),
      widget: Container(),
      width: 140,
      height: 200,
      borderRadius: 20),
  InfoCard(
      image: Image.asset(
        "assets/images/homepage/annonce1.jpg",
        fit: BoxFit.cover,
      ),
      widget: Container(),
      width: 140,
      height: 200,
      borderRadius: 20),
  InfoCard(
      image: Image.asset(
        "assets/images/homepage/annonce1.jpg",
        fit: BoxFit.cover,
      ),
      widget: Container(),
      width: 140,
      height: 200,
      borderRadius: 20),
  InfoCard(
      image: Image.asset(
        "assets/images/homepage/annonce1.jpg",
        fit: BoxFit.cover,
      ),
      widget: Container(),
      width: 140,
      height: 200,
      borderRadius: 20),
  InfoCard(
      image: Image.asset(
        "assets/images/homepage/annonce1.jpg",
        fit: BoxFit.cover,
      ),
      widget: Container(),
      width: 140,
      height: 200,
      borderRadius: 20),
  InfoCard(
      image: Image.asset(
        "assets/images/homepage/annonce1.jpg",
        fit: BoxFit.cover,
      ),
      widget: Container(),
      width: 140,
      height: 200,
      borderRadius: 20),
];
List<InfoCard> listeInfoCard3 = [
  InfoCard(
      image: Image.asset(
        "assets/images/homepage/annonce2.jpg",
        fit: BoxFit.cover,
      ),
      widget: Container(),
      width: 140,
      height: 200,
      borderRadius: 20),
  InfoCard(
      image: Image.asset(
        "assets/images/homepage/annonce2.jpg",
        fit: BoxFit.cover,
      ),
      widget: Container(),
      width: 140,
      height: 200,
      borderRadius: 20),
  InfoCard(
      image: Image.asset(
        "assets/images/homepage/annonce2.jpg",
        fit: BoxFit.cover,
      ),
      widget: Container(),
      width: 140,
      height: 200,
      borderRadius: 20),
  InfoCard(
      image: Image.asset(
        "assets/images/homepage/annonce2.jpg",
        fit: BoxFit.cover,
      ),
      widget: Container(),
      width: 140,
      height: 200,
      borderRadius: 20),
  InfoCard(
      image: Image.asset(
        "assets/images/homepage/annonce2.jpg",
        fit: BoxFit.cover,
      ),
      widget: Container(),
      width: 140,
      height: 200,
      borderRadius: 20),
  InfoCard(
      image: Image.asset(
        "assets/images/homepage/annonce2.jpg",
        fit: BoxFit.cover,
      ),
      widget: Container(),
      width: 140,
      height: 200,
      borderRadius: 20),
];

class Nouveaute extends StatefulWidget {
  const Nouveaute({super.key});

  @override
  State<Nouveaute> createState() => _NouveauteState();
}

class _NouveauteState extends State<Nouveaute> {
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Nouveautés",
                style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: Column(
            children: [
              Row(
                children: [
                  SectionSelector(
                    value: 1,
                    groupValue: _value,
                    onChanged: (int? value) {
                      setState(() {
                        _value = value!;
                      });
                    },
                    text: "Polytech-info",
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  SectionSelector(
                    value: 2,
                    groupValue: _value,
                    onChanged: (int? value) {
                      setState(() {
                        _value = value!;
                      });
                    },
                    text: "Interclasses",
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  SectionSelector(
                    value: 3,
                    groupValue: _value,
                    onChanged: (int? value) {
                      setState(() {
                        _value = value!;
                      });
                    },
                    text: "Commerce",
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CategorySelection(
                value: _value - 1,
                itemLists: [listeInfoCard, listeInfoCard2, listeInfoCard3],
              )
            ],
          ),
        ),
      ],
    );
  }
}
