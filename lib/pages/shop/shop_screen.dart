import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/models/article_shop.dart';
import 'package:new_app/models/categorie_shop.dart';
import 'package:new_app/models/collection.dart';
import 'package:new_app/pages/drawer/drawer.dart';
import 'package:new_app/pages/home/navbar.dart';
import 'package:new_app/pages/shop/mes_commandes.dart';
import 'package:new_app/pages/shop/shopCaroussel.dart';
import 'package:new_app/services/shop_service.dart';
import 'package:new_app/utils/app_colors.dart';
import 'package:new_app/widgets/alerte_message.dart';
import 'dart:async';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final ShopService _shopService = ShopService();

  List<String> carouselImages = [];
  Collection? _collection;
  String searchQuery = '';
  CategorieShop selectedCategory = CategorieShop(id: "", libelle: "Tous");
  List<CategorieShop> categories = [
    CategorieShop(id: "", libelle: "Tous"),
  ];

  @override
  void initState() {
    super.initState();
    _loadCarouselImages();
    _loadCategories();
  }

  Future<void> _loadCarouselImages() async {
    Collection? collection = await _shopService.getNewCollection();
    if (collection != null) {
      setState(() {
        _collection = collection;
        carouselImages =
            collection.articleShops.map((article) => article.image).toList();
      });

      print('Images chargées pour le carrousel :');
      for (String imageUrl in carouselImages) {
        print(imageUrl);
      }
    } else {
      print('Aucune collection trouvée.');
    }
  }

  Future<void> _loadCategories() async {
    List<CategorieShop>? loadedCategories =
        await _shopService.getAllCategorieShop();
    setState(() {
      categories.addAll(loadedCategories);
    });
  }

  Future<List<ArticleShop>> getFilteredProducts() async {
    List<ArticleShop> products = await _shopService.getAllArticle();
    List<ArticleShop> filteredProducts = List.from(products);

    // Trier les produits commandés en premier
    filteredProducts.sort((a, b) {
      if (a.commandes == b.commandes) return 0;
      if (a.commandes.isEmpty) return -1;
      return 1;
    });

    return filteredProducts.where((product) {
      bool categoryMatch = selectedCategory.libelle == 'Tous' ||
          product.categorie.id == selectedCategory.id;
      bool searchMatch =
          product.titre.toLowerCase().contains(searchQuery.toLowerCase());
      return categoryMatch && searchMatch;
    }).toList();
  }

  void _showProductDetails(ArticleShop product) {
    int quantity = 1;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(product.image, height: 200),
                  SizedBox(height: 10),
                  Text(product.titre,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Catégorie: ${product.categorie.libelle}'),
                  Text('Prix: ${product.prix} CFA'),
                  SizedBox(height: 10),
                  Text(product.description),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Bouton "-"
                      IconButton(
                        onPressed: quantity > 1
                            ? () {
                                setState(() {
                                  quantity--;
                                });
                              }
                            : null, // Désactivé si quantité est 1
                        icon: Icon(Icons.remove),
                        color: quantity > 1 ? Colors.black : Colors.grey,
                      ),
                      Text(
                        '$quantity', // Affiche la quantité actuelle
                        style: TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        icon: Icon(Icons.add),
                        color: Colors.black,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    child: Text('Commander'),
                    onPressed: () async {
                      // Gestion de la commande avec la quantité
                      String code = await _shopService.postCommande(
                          product, quantity); // Ajout de la quantité
                      if (code == "OK") {
                        Navigator.of(context).pop();
                        alerteMessageWidget(
                            context,
                            "Votre commande a été bien prise en compte.",
                            AppColors.success);
                      } else {
                        alerteMessageWidget(context,
                            "Échec lors de la commande.", AppColors.echec);
                      }
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title : Text('Shop'),
        centerTitle : true,
        forceMaterialTransparency: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.black,
                size: 35,
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () {
              changerPage(context, UserCommandeListPage());
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: navbar(pageIndex: 4),
      drawer: EptDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (_collection != null)
              ShopCarousel(
                imagePaths: carouselImages,
                collection: _collection!,
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: screenWidth * 0.4,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xffd9d9d9),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 5),
                              child: Icon(Icons.search,
                                  color: Color(0xff777777), size: 20),
                            ),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Chercher',
                                  hintStyle: TextStyle(
                                      fontSize: 15, color: Color(0xff777777)),
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10),
                                ),
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                                onChanged: (value) {
                                  setState(() {
                                    searchQuery = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuButton<CategorieShop>(
                        onSelected: (CategorieShop value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                        itemBuilder: (BuildContext context) {
                          return categories.map((CategorieShop choice) {
                            return PopupMenuItem<CategorieShop>(
                              value: choice,
                              child: Text(choice.libelle),
                            );
                          }).toList();
                        },
                        child: Row(
                          children: [
                            Text(
                              'Catégories',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/categorie.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    selectedCategory.libelle,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Nouveautés',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<List<ArticleShop>>(
              future: getFilteredProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Erreur: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('Aucun produit trouvé');
                }

                List<ArticleShop> products = snapshot.data!;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 5,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final produit = products[index];
                    return _buildProductItem(produit);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(ArticleShop produit) {
    return GestureDetector(
      onTap: () => _showProductDetails(produit),
      child: Column(
        children: [
          Container(
            width: 150,
            height: 150, // Taille fixe pour l'image
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(produit.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            produit.titre,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4),
          Text(
            '${produit.prix} FCFA',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
