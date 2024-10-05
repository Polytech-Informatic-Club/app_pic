import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/models/enums/statut_xoss.dart';
import 'package:new_app/models/utilisateur.dart';
import 'package:new_app/models/xoss.dart';
import 'package:new_app/pages/drawer/xoss/xoss_screen.dart';
import 'package:new_app/services/xoss_service.dart';
import 'package:new_app/utils/app_colors.dart';
import 'package:new_app/widgets/alerte_message.dart';
import 'package:new_app/widgets/reusable_widgets.dart';
import 'package:new_app/widgets/submited_button.dart';

class CreateXoss extends StatelessWidget {
  CreateXoss({super.key});

  TextEditingController _produitController = new TextEditingController();
  TextEditingController _montantController = new TextEditingController();
  ValueNotifier _listProduit = new ValueNotifier([]);
  XossService _xossService = XossService();
  final _formKey = GlobalKey<FormState>();
  ValueNotifier<List<String>> _produits = ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              ValueListenableBuilder<List<String>>(
                valueListenable: _produits,
                builder: (context, produits, _) {
                  return Column(
                    children: List.generate(produits.length, (index) {
                      return ListTile(
                        title: Text(produits[index]),
                      );
                    }),
                  );
                },
              ),
              // Bouton pour ajouter le produit
              Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      if (_produitController.value.text.isNotEmpty) {
                        _produits.value = [
                          ..._produits.value,
                          _produitController.text
                        ];
                        _produitController
                            .clear(); // Vider le champ après l'ajout
                      }
                    },
                  )),
              reusableTextFormField(
                "Produits",
                _produitController,
                (value) {
                  // Vérifier si le produit est déjà dans la liste
                  if (_produits.value.contains(value)) {
                    return 'Ce produit existe déjà'; // Produit déjà ajouté
                  }

                  return null; // Validation réussie
                },
              ),

              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              reusableTextFormField("Montant total", _montantController,
                  (value) {
                if (value == null || value.isEmpty) {
                  return 'Entrer un montant';
                }
                return null;
              }),
              SizedBox(
                height: 10,
              ),
              SubmittedButton("Xoss", () async {
                if (_formKey.currentState!.validate() &&
                    _produits.value != [] &&
                    _produitController.text.isNotEmpty) {
                  _produits.value = [
                    ..._produits.value,
                    _produitController.text
                  ];
                  try {
                    Xoss xoss = Xoss(
                        date: DateTime.now(),
                        id: DateTime.now().toString(),
                        montant: double.parse(_montantController.value.text),
                        produit: _produits.value,
                        versement: 0,
                        statut: StatutXoss.IMPAYEE);
                    String code = await _xossService.postXoss(xoss);
                    if (code == "OK") {
                      alerteMessageWidget(context, "Xoss crée avec succès !",
                          AppColors.success);
                      changerPage(context, XossScreen());
                    }
                  } catch (e) {
                    alerteMessageWidget(
                        context,
                        "Une erreur est survie lors de la création.$e",
                        AppColors.echec);
                  }
                } else {
                  alerteMessageWidget(context,
                      "Vous n'avez pas rempli le formulaire.", AppColors.echec);
                }
              })
            ],
          ),
        ));
  }
}
