import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:new_app/models/annonce.dart';
import 'package:new_app/models/match.dart';
import 'package:new_app/pages/annonce/infocard.dart';
import 'package:new_app/pages/annonce/p_info_nouveaute.dart';
import 'package:new_app/pages/home/section_selector.dart';
import 'package:new_app/services/annonce_service.dart';
import 'package:new_app/services/sport_service.dart';
import 'package:new_app/utils/app_colors.dart';

class Nouveaute extends StatefulWidget {
  const Nouveaute({super.key});

  @override
  State<Nouveaute> createState() => _NouveauteState();
}

class _NouveauteState extends State<Nouveaute> {
  AnnonceService _annonceService = AnnonceService();
  SportService _sportService = SportService();
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
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
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
              if (_value == 1)
                FutureBuilder<List<Annonce>>(
                  future: _annonceService.getAllAnnonces(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Erreur lors du chargement des annonces');
                    } else {
                      List<Annonce> annonces = snapshot.data ?? [];
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var annonce in annonces)
                              annonce.image.isNotEmpty
                                  ? Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 20, 0),
                                      padding: const EdgeInsets.all(3),
                                      width: MediaQuery.sizeOf(context).height *
                                          0.18,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.25,
                                      decoration: BoxDecoration(
                                          color: eptOrange,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).height *
                                                0.18,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.25,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        clipBehavior: Clip.hardEdge,
                                        child: Image.network(
                                          annonce.image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 0,
                                    )
                          ],
                        ),
                      );
                    }
                  },
                ),
              if (_value == 2)
                FutureBuilder<List<Matches>>(
                  future: _sportService.getNextMatch(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Erreur lors du chargement des annonces');
                    } else {
                      List<Matches> matches = snapshot.data ?? [];
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (var match in matches)
                              match.photo!.isNotEmpty
                                  ? Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 20, 0),
                                      padding: const EdgeInsets.all(3),
                                      width: MediaQuery.sizeOf(context).height *
                                          0.18,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.25,
                                      decoration: BoxDecoration(
                                          color: eptOrange,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).height *
                                                0.18,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.25,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        clipBehavior: Clip.hardEdge,
                                        child: Image.network(
                                          match.photo!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 0,
                                    )
                          ],
                        ),
                      );
                    }
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}
