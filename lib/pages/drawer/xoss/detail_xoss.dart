import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/models/enums/statut_xoss.dart';
import 'package:new_app/models/xoss.dart';
import 'package:new_app/services/xoss_service.dart';
import 'package:new_app/utils/app_colors.dart';

class DetailXoss extends StatelessWidget {
  String id;
  DetailXoss(this.id, {super.key});

  final XossService _xossService = XossService();
  ValueNotifier<Xoss?> _xossProvider = ValueNotifier(null);
  TextEditingController _versementController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.02),
          child: FutureBuilder<Xoss?>(
              future: _xossService.getXossId(id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Erreur lors de la récupération des données');
                }
                final xoss = snapshot.data;
                _xossProvider.value = xoss;
                return xoss == null
                    ? CircularProgressIndicator()
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${_xossProvider.value!.versement - _xossProvider.value!.montant} FCFA",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.sizeOf(context).height *
                                            0.03),
                              ),
                              CircleAvatar(
                                backgroundColor: AppColors.gray,
                                backgroundImage: NetworkImage(
                                    _xossProvider.value!.user!.photo!),
                              )
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.03,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: AppColors.gray,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Montant total"),
                                    Text("${_xossProvider.value!.montant} FCFA")
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.03,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Montant versé"),
                                    Text(
                                        "${_xossProvider.value!.versement} FCFA")
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.03,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Statut"),
                                    Text(
                                      _xossProvider.value!.statut
                                          .toString()
                                          .split(".")
                                          .last,
                                      style: TextStyle(
                                          color: _xossProvider.value!.statut
                                                      .toString()
                                                      .split(".")
                                                      .last ==
                                                  StatutXoss.PAYEE
                                                      .toString()
                                                      .split(".")
                                                      .last
                                              ? AppColors.success
                                              : _xossProvider.value!.statut
                                                          .toString()
                                                          .split(".")
                                                          .last ==
                                                      StatutXoss.ATTENTE
                                                          .toString()
                                                          .split(".")
                                                          .last
                                                  ? Colors.yellow
                                                  : Colors.red),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.03,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Date"),
                                    Text(dateCustomformat(
                                        _xossProvider.value!.date))
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.03,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Produits"),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        for (var produit
                                            in _xossProvider.value!.produit)
                                          Text(produit)
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.03,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("ID"),
                                    Text(_xossProvider.value!.id)
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.03,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (_xossProvider.value!.statut
                                      .toString()
                                      .split(".")
                                      .last !=
                                  StatutXoss.PAYEE.toString().split(".").last)
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              AppColors.success),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Montant versé"),
                                            content: TextField(
                                              controller: _versementController,
                                              decoration: InputDecoration(
                                                  hintText:
                                                      "Entrer le montant"),
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text("Annuler"),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  _xossProvider.value =
                                                      await _xossService.updateXoss(
                                                          id,
                                                          "versement",
                                                          double.parse(
                                                              _versementController
                                                                  .value.text));
                                                  _xossProvider.value =
                                                      await _xossService
                                                          .updateXoss(
                                                              id,
                                                              "statut",
                                                              StatutXoss.ATTENTE
                                                                  .toString()
                                                                  .split(".")
                                                                  .last);
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Confirmer"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Text("PAYER")),
                              if (_xossProvider.value!.statut
                                      .toString()
                                      .split(".")
                                      .last !=
                                  StatutXoss.PAYEE.toString().split(".").last)
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.yellow),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                                Text("Confirmation versement"),
                                            content: Text(
                                                "Voulez-vous confirmer le paiement total."),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text("Annuler"),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  _xossProvider.value =
                                                      await _xossService
                                                          .updateXoss(
                                                              id,
                                                              "statut",
                                                              StatutXoss.PAYEE
                                                                  .toString()
                                                                  .split(".")
                                                                  .last);
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Confirmer"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Text("Valider")),
                            ],
                          )
                        ],
                      );
              }),
        ));
  }
}
