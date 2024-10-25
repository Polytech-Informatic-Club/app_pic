import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/models/enums/statut_xoss.dart';
import 'package:new_app/models/xoss.dart';
import 'package:new_app/pages/drawer/drawer.dart';
import 'package:new_app/pages/drawer/xoss/create_xoss.dart';
import 'package:new_app/pages/drawer/xoss/detail_xoss.dart';
import 'package:new_app/pages/home/navbar.dart';
import 'package:new_app/pages/drawer/xoss/historique_xoss.dart';
import 'package:new_app/services/xoss_service.dart';
import 'package:new_app/utils/app_colors.dart';

class HistoriqueXoss extends StatelessWidget {
  HistoriqueXoss({Key? key}) : super(key: key);
  XossService _xossService = XossService();
  final ValueNotifier<List<Xoss>> _xossProvider = ValueNotifier<List<Xoss>>([]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Historique"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: FutureBuilder<List<Xoss>>(
                future: _xossService.getAllXossOfUserByEmail(
                    FirebaseAuth.instance.currentUser!.email!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Erreur lors de la récupération des données');
                  } else {
                    List<Xoss> xoss = snapshot.data ?? [];
                    _xossProvider.value = xoss;
                    return Column(
                      children: [
                        for (var xoss in _xossProvider.value)
                          xossWidget(context, xoss),
                      ],
                    );
                  }
                }),
          ),
        ));
  }
}

Widget xossWidget(BuildContext context, Xoss xoss) {
  return GestureDetector(
      onTap: () => changerPage(context, DetailXoss(xoss.id)),
      child: Padding(
          padding: EdgeInsets.all(20),
          child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          " Xossna",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Image.asset(xoss.statut.toString().split(".").last ==
                                StatutXoss.PAYEE.toString().split(".").last
                            ? "assets/images/xoss/Ellipse_green.png"
                            : xoss.statut.toString().split(".").last ==
                                    StatutXoss.ATTENTE
                                        .toString()
                                        .split(".")
                                        .last
                                ? "assets/images/xoss/Ellipse_white.png"
                                : "assets/images/xoss/Ellipse_red.png")
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(127, 127, 127, 1),
                              borderRadius: BorderRadius.circular(10)),
                          width: MediaQuery.sizeOf(context).width * 0.45,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          // height: 110,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Scrollbar(
                              trackVisibility: true,
                              thumbVisibility: true,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    for (var produit in xoss.produit)
                                      Row(
                                        children: [
                                          SizedBox(width: 20),
                                          Image.asset(
                                            "assets/images/xoss/Ellipse_white.png",
                                          ),
                                          SizedBox(width: 10),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            child: Text(
                                              produit,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          )
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: Text(
                            "${xoss.montant} FCFA",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.01,
                    ),
                    Text(
                      dateCustomformat(xoss.date),
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )
                  ],
                ),
              ))));
}
