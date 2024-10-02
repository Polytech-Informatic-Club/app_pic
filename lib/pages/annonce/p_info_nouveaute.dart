import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/models/annonce.dart';
import 'package:new_app/models/categorie.dart';
import 'package:new_app/pages/annonce/create_annonce.dart';
import 'package:new_app/pages/annonce/infocard.dart';
import 'package:new_app/pages/annonce/p_info_section_selector.dart';
import 'package:new_app/pages/annonce/restauration.dart';
import 'package:new_app/services/annonce_service.dart';
import 'package:new_app/utils/app_colors.dart';

class PInfoNouveaute extends StatefulWidget {
  const PInfoNouveaute({super.key});

  @override
  State<PInfoNouveaute> createState() => _PInfoNouveauteState();
}

class _PInfoNouveauteState extends State<PInfoNouveaute> {
  AnnonceService _annonceService = AnnonceService();
  int groupValue = 0;
  @override
  Widget build(BuildContext context) {
    bool isAdmin = true;
    return Column(
      children: [
        Row(
          children: [
            const Text(
              "Nouveautés",
              style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            if (isAdmin) ...[
              const SizedBox(
                width: 5,
              ),
              InkWell(
                  onTap: () {
                    changerPage(context, CreateAnnonce());
                  },
                  child: Image.asset(
                    "assets/images/polytech-Info/plus.png",
                    scale: 5,
                  )),
            ]
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FutureBuilder<List<Categorie>>(
                    future: _annonceService.getAllCategories(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Erreur lors du chargement');
                      } else {
                        List<Categorie> categories = snapshot.data ?? [];
                        return Row(
                          children: [
                            for (var category in categories)
                              PInfoSectionSelector(
                                  value: int.parse(category.id),
                                  groupValue: groupValue,
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue = value!;
                                    });
                                  },
                                  image: Image.network(
                                    category.logo,
                                    scale: 3,
                                  )),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        FutureBuilder<List<Annonce>>(
          future: _annonceService.getAnnoncesByCategorie(
              Categorie(id: groupValue.toString(), libelle: "", logo: "")),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Erreur lors du chargement des annonces');
            } else {
              List<Annonce> annonces = snapshot.data ?? [];
              return CategorySelection(
                items: annonces,
                value: groupValue,
              );
            }
          },
        ),
      ],
    );
  }
}

class CategorySelection extends StatelessWidget {
  final List<Annonce> items;
  final int value;

  CategorySelection({
    super.key,
    required this.items,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: items
              .map(
                (Annonce annonce) => annonce.image.isEmpty
                    ? Restauration(annonce.categorie)
                    : Container(
                        padding: const EdgeInsets.all(5),
                        width: 170,
                        height: MediaQuery.sizeOf(context).height * 0.3,
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(15)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          clipBehavior: Clip.hardEdge,
                          child: Image.network(
                            annonce.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              )
              .toList(),
        ),
      ),
    );
  }
}

double width = 200;
double height = 320;
