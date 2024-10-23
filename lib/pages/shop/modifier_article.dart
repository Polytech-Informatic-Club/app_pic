import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  final ImagePicker _imagePicker =
      ImagePicker(); // Ajoutez l'instance d'ImagePicker

  final ValueNotifier<CategorieShop?> _selectedCategorieShop =
      ValueNotifier(null);
  final ValueNotifier<DateTime?> _selectedDate = ValueNotifier(DateTime.now());
  final ValueNotifier<String> _url = ValueNotifier("");

  List<CategorieShop> _categories = []; // Liste des catégories disponibles

  @override
  void initState() {
    super.initState();
    _descriptionTextController.text = widget.article.description;
    _titreController.text = widget.article.titre;
    _prixController.text = widget.article.prix.toString();
    _selectedCategorieShop.value = widget.article.categorie;
    _selectedDate.value = widget.article.dateCreation;
    _url.value = widget.article.image;

    _loadCategories(); // Charger les catégories au démarrage
  }

  // Charger les catégories disponibles (par exemple, à partir d'une API ou d'une base de données)
  Future<void> _loadCategories() async {
    _categories =
        await _shopService.getAllCategorieShop(); // Exécuter la récupération
    setState(
        () {}); // Mettre à jour l'interface après le chargement des catégories
  }

  // Fonction pour sélectionner une nouvelle image à partir de la galerie
  Future<void> _pickImage() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _url.value =
            image.path; // Mettre à jour l'URL avec le chemin de l'image
      });
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
            // Affichage de l'image
            ValueListenableBuilder<String>(
              valueListenable: _url,
              builder: (context, url, child) {
                return url.isNotEmpty
                    ? Column(
                        children: [
                          Image.network(url),
                          SizedBox(height: 10),
                          // Bouton pour changer l'image
                          ElevatedButton.icon(
                            onPressed:
                                _pickImage, // Ouvre la galerie pour sélectionner une nouvelle image
                            icon: Icon(Icons.photo),
                            label: Text("Changer l'image"),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            color: AppColors.gray,
                            child: Center(child: Text("Pas d'image")),
                          ),
                          SizedBox(height: 10),
                          // Bouton pour ajouter une image
                          ElevatedButton.icon(
                            onPressed:
                                _pickImage, // Ouvre la galerie pour sélectionner une nouvelle image
                            icon: Icon(Icons.photo),
                            label: Text("Ajouter une image"),
                          ),
                        ],
                      );
              },
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

            // DropdownButton pour sélectionner une catégorie
            ValueListenableBuilder<CategorieShop?>(
              valueListenable: _selectedCategorieShop,
              builder: (context, selectedCategorie, child) {
                return DropdownButtonFormField<CategorieShop>(
                  value: _categories.firstWhere(
                    (categorie) => categorie.id == selectedCategorie?.id,
                    orElse: () => CategorieShop(id: '', libelle: '', logo: ''),
                  ), // Recherche basée sur l'id
                  hint: Text("Sélectionnez une catégorie"),
                  items: _categories.map((CategorieShop categorie) {
                    return DropdownMenuItem<CategorieShop>(
                      value: categorie,
                      child: Text(categorie.libelle),
                    );
                  }).toList(),
                  onChanged: (CategorieShop? newCategorie) {
                    _selectedCategorieShop.value = newCategorie;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Catégorie',
                  ),
                );
              },
            ),

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
                String result =
                    await _shopService.updateArticleShop(updatedArticle);
                if (result == "OK") {
                  alerteMessageWidget(context, "Article modifié avec succès !",
                      AppColors.success);
                }
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
