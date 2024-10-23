import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_app/models/article_shop.dart';
import 'package:new_app/models/categorie_shop.dart';
import 'package:new_app/services/shop_service.dart';
import 'package:new_app/utils/app_colors.dart';
import 'package:new_app/widgets/alerte_message.dart';
import 'package:new_app/widgets/reusable_description_input.dart';
import 'package:new_app/widgets/reusable_widgets.dart';
import 'package:new_app/widgets/submited_button.dart';

class EditArticleShop extends StatefulWidget {
  final ArticleShop article;
  EditArticleShop({required this.article});

  @override
  _EditArticleShopState createState() => _EditArticleShopState();
}

class _EditArticleShopState extends State<EditArticleShop> {
  final TextEditingController _descriptionTextController =
      TextEditingController();
  final TextEditingController _titreController = TextEditingController();
  final TextEditingController _prixController = TextEditingController();

  final ShopService _shopService = ShopService();

  final ValueNotifier<CategorieShop?> _selectedCategorieShop =
      ValueNotifier(null);
  final ValueNotifier<DateTime?> _selectedDate = ValueNotifier(DateTime.now());
  final ValueNotifier<String> _url = ValueNotifier("");

  @override
  void initState() {
    super.initState();
    _descriptionTextController.text = widget.article.description;
    _titreController.text = widget.article.titre;
    _prixController.text = widget.article.prix.toString();
    _selectedCategorieShop.value = widget.article.categorie;
    _selectedDate.value = widget.article.dateCreation;
    _url.value = widget.article.image;
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate.value!,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDate.value!),
      );

      if (pickedTime != null) {
        final DateTime pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        _selectedDate.value = pickedDateTime;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text("Modifier l'article"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            ValueListenableBuilder<String>(
              valueListenable: _url,
              builder: (context, url, child) {
                return url.isNotEmpty
                    ? Image.network(url)
                    : Container(
                        height: 200,
                        width: double.infinity,
                        color: AppColors.gray,
                        child: Center(child: Text("Pas d'image")),
                      );
              },
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => _selectDateTime(context),
              child: Row(children: [
                Icon(Icons.calendar_today),
                SizedBox(width: 10),
                ValueListenableBuilder<DateTime?>(
                  valueListenable: _selectedDate,
                  builder: (context, selectedDate, child) {
                    return Text(
                      DateFormat('dd MMMM yyyy').format(selectedDate!),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    );
                  },
                ),
              ]),
            ),
            SizedBox(height: 20),
            reusableTextFormField("Titre", _titreController, (value) {
              return null;
            }),
            SizedBox(height: 20),
            reusableTextFormField("Prix", _prixController, (value) {
              return null;
            }),
            SizedBox(height: 20),
            ReusableDescriptionInput("Description", _descriptionTextController,
                (value) {
              return null;
            }),
            SizedBox(height: 20),
            SubmittedButton("Modifier l'article", () async {
              ArticleShop updatedArticle = ArticleShop(
                id: widget.article.id,
                dateCreation: _selectedDate.value!,
                description: _descriptionTextController.text,
                titre: _titreController.text,
                prix: int.parse(_prixController.text),
                image: _url.value,
                categorie: _selectedCategorieShop.value!,
                commandes: widget.article.commandes,
                partageLien: widget.article.partageLien,
              );

              try {
                // String result = await _shopService.updateArticleShop(updatedArticle);
                // if (result == "OK") {
                //   alerteMessageWidget(context, "Article modifié avec succès !", AppColors.success);
                // }
              } catch (e) {
                alerteMessageWidget(context,
                    "Erreur lors de la modification : $e", AppColors.echec);
              }
            }),
          ],
        ),
      ),
    );
  }
}
