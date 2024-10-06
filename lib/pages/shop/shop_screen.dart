import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/models/article_shop.dart';
import 'package:new_app/models/categorie_shop.dart';
import 'package:new_app/models/collection.dart';
import 'package:new_app/pages/home/navbar.dart';
import 'dart:async';

import 'package:new_app/pages/shop/shop_blouson.dart';
import 'package:new_app/services/shop_service.dart';
import 'package:new_app/utils/app_colors.dart';
import 'package:new_app/widgets/alerte_message.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final ShopService _shopService = ShopService();

  List<String> carouselImages = [];
  Collection? _collection = null;

  @override
  void initState() {
    super.initState();
    _loadCarouselImages();
  }

  Future<void> _loadCarouselImages() async {
    Collection? collection = await _shopService.getNewCollection();
    if (collection != null) {
      setState(() {
        _collection = collection;
        carouselImages =
            collection.articleShops.map((article) => article.image).toList();
      });
    }
  }

  CategorieShop selectedCategory =
      CategorieShop(id: "", libelle: "Tous", logo: "");
  List<CategorieShop> categories = [
    CategorieShop(id: "", libelle: "Tous", logo: ""),
  ];
  String searchQuery = '';

  Future<List<ArticleShop>> getFilteredProducts() async {
    List<ArticleShop> products = await _shopService.getAllArticle();
    print(products);

    List<ArticleShop> filteredProducts = List.from(products);

    // Trier les produits commandés en premier
    filteredProducts.sort((a, b) {
      if (a.commandes == b.commandes) return 0;
      if (a.commandes.isEmpty) return -1;
      return 1;
    });

    return filteredProducts.where((product) {
      bool categoryMatch =
          selectedCategory == 'Tous' || product.categorie == selectedCategory;
      bool searchMatch =
          product.titre.toLowerCase().contains(searchQuery.toLowerCase());
      return categoryMatch && searchMatch;
    }).toList();
  }

  void _showProductDetails(ArticleShop product, Collection collection) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(product.image, height: 200),
              SizedBox(height: 10),
              Text(product.titre,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Catégorie: ${product.categorie.libelle}'),
              Text('Prix: ${product.prix} CFA'),
              SizedBox(height: 10),
              Text(product.description),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Commander'),
                onPressed: () async {
                  String code =
                      await _shopService.postCommande(product, collection);
                  if (code == "OK") {
                    Navigator.of(context).pop();
                    alerteMessageWidget(
                        context,
                        "Votre commande a été bien prise en compte.",
                        AppColors.success);
                  } else {
                    alerteMessageWidget(
                        context, "Echec lors de la commande.", AppColors.echec);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showOrderConfirmation(bool isOrdered) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/checked.png', height: 100),
              SizedBox(height: 20),
              Text(
                isOrdered
                    ? 'Commande passée avec succès'
                    : 'Commande retirée avec succès',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: navbar(pageIndex: 4),
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
                                    fontSize: 15,
                                    color: Color(0xff777777),
                                  ),
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10),
                                ),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
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
                                color: Colors.black,
                              ),
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
                  Text(
                    selectedCategory.libelle,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Nouveautés',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(child: LayoutBuilder(builder: (context, constraints) {
              return FutureBuilder<List<Collection>>(
                  future: _shopService.getAllCollection(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Erreur: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('Aucun produit trouvé');
                    }

                    List<Collection> listCollection = snapshot.data!;

                    return Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: listCollection.length,
                          itemBuilder: (context, index) {
                            final collection = listCollection[index];
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(collection.nom),
                                    Text(timeAgoCustom(collection.date)),
                                  ],
                                ),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 5,
                                    childAspectRatio: 0.6,
                                  ),
                                  itemCount: collection.articleShops.length,
                                  itemBuilder: (context, i) {
                                    final produit = collection.articleShops[i];
                                    return GestureDetector(
                                      onTap: () => _showProductDetails(
                                          produit, collection),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            width: 170,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.22,
                                            decoration: BoxDecoration(
                                              color: AppColors.primary,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.network(
                                                produit.image,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Text(produit.titre,
                                              overflow: TextOverflow.ellipsis),
                                          Text("${produit.prix} FCFA",
                                              overflow: TextOverflow.ellipsis),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    );
                  });
            }))
          ],
        ),
      ),
    );
  }
}

class ShopCarousel extends StatefulWidget {
  final List<String> imagePaths;
  Collection collection;

  ShopCarousel({super.key, required this.collection, required this.imagePaths});

  @override
  _ShopCarouselState createState() => _ShopCarouselState();
}

class _ShopCarouselState extends State<ShopCarousel> {
  int _currentPage = 0;
  late Timer _timer;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < widget.imagePaths.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.6,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.imagePaths.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return Image.network(
                widget.imagePaths[index],
                fit: BoxFit.cover,
                height: 650,
                width: double.infinity,
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.imagePaths.map((url) {
                int index = widget.imagePaths.indexOf(url);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.4),
                  ),
                );
              }).toList(),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xffffdead).withOpacity(.7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Nouvelle Collection',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        color: Colors.black,
                        fontFamily: 'LeagueGothicRegular-Regular',
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        // Redirection vers la page du produit
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  blousonPage(widget.collection)),
                        );
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Tout voir',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(Icons.arrow_forward, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget shopItem(imagePath, productName, price, isOrdered) {
//   return Container(
//       height: 1000,
//       color: Colors.green,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(5),
//             width: 170,
//             height: 190,
//             decoration: BoxDecoration(
//                 color: Colors.red,
//                 // color: eptLightGrey,
//                 borderRadius: BorderRadius.circular(15)),
//             child: Container(
//               decoration:
//                   BoxDecoration(borderRadius: BorderRadius.circular(15)),
//               clipBehavior: Clip.hardEdge,
//               child: Image.network(
//                 imagePath,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           Text(
//             productName,
//             style: const TextStyle(fontSize: 12, color: eptDarkGrey),
//           ),
//           Row(
//             children: [
//               Text(
//                 "$price Fcfa",
//                 style: const TextStyle(
//                   fontFamily: "Inter",
//                   fontSize: 16,
//                 ),
//               ),
//               if (isOrdered) ...[
//                 Image.asset('assets/images/checked.png', height: 20),
//               ],
//             ],
//           ),
//         ],
//       ));
// }
