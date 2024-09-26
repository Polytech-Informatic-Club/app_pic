import 'package:flutter/material.dart';
import 'package:new_app/pages/home/navbar.dart';
import 'dart:async';

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  final List<String> carouselImages = [
    'assets/images/market/photo_2024-05-24_12-27-39.jpg',
    'assets/images/market/photo_2024-05-24_12-27-53.jpg',
    'assets/images/market/photo_2024-05-24_12-27-08.jpg',
    'assets/images/market/photo_2024-05-24_12-28-09.jpg',
  ];

  String selectedCategory = 'Tous';
  List<String> categories = ['Tous', 'Tasse', 'Bloc-Notes', 'Porte-Clé', 'Gourde'];
  String searchQuery = '';

  List<Map<String, dynamic>> getFilteredProducts() {
    List<Map<String, dynamic>> filteredProducts = List.from(products);

    // Trier les produits commandés en premier
    filteredProducts.sort((a, b) {
      if (a['commande'] == b['commande']) return 0;
      if (a['commande']) return -1;
      return 1;
    });

    return filteredProducts.where((product) {
      bool categoryMatch = selectedCategory == 'Tous' || product['categorie'] == selectedCategory;
      bool searchMatch = product['produit'].toLowerCase().contains(searchQuery.toLowerCase());
      return categoryMatch && searchMatch;
    }).toList();
  }

  void _showProductDetails(Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(product['image_path'] ?? '', height: 200),
              SizedBox(height: 10),
              Text(product['produit'] ?? '', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Catégorie: ${product['categorie'] ?? ''}'),
              Text('Prix: ${product['prix'] ?? ''} CFA'),
              SizedBox(height: 10),
              Text(product['description'] ?? ''),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text(product['commande'] == true ? 'Retirer' : 'Commander'),
                onPressed: () {
                  setState(() {
                    product['commande'] = !(product['commande'] ?? false);
                  });
                  Navigator.of(context).pop();
                  _showOrderConfirmation(product['commande'] ?? false);
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
                isOrdered ? 'Commande passée avec succès' : 'Commande retirée avec succès',
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
      bottomNavigationBar: navbar(pageIndex: 4),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ShopCarousel(imagePaths: carouselImages),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: screenWidth * 0.6,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xffd9d9d9),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10, right: 5),
                              child: Icon(Icons.search, color: Color(0xff777777), size: 20),
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
                                  contentPadding: EdgeInsets.symmetric(vertical: 10),
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
                      PopupMenuButton<String>(
                        onSelected: (String value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                        itemBuilder: (BuildContext context) {
                          return categories.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
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
                                  image: AssetImage('assets/images/categorie.png'),
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
                    selectedCategory,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Nouveautés',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = (constraints.maxWidth > 600) ? 3 : 2;

                List<Map<String, dynamic>> filteredProducts = getFilteredProducts();

                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return GestureDetector(
                      onTap: () => _showProductDetails(product),
                      child: ProductCard(
                        imagePath: product['image_path'],
                        productName: product['produit'],
                        price: product['prix'],
                        isOrdered: product['commande'],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ShopCarousel extends StatefulWidget {
  final List<String> imagePaths;

  const ShopCarousel({super.key, required this.imagePaths});

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
      height: 650,
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
              return Image.asset(
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
                        fontSize: MediaQuery.of(context).size.width * 0.08,
                        color: Colors.black,
                        fontFamily: 'LeagueGothicRegular-Regular',
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        // Action lorsque l'utilisateur clique sur "Tout voir"
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
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

class ProductCard extends StatelessWidget {
  final String imagePath;
  final String productName;
  final String price;
  final bool isOrdered;

  const ProductCard({
    super.key,
    required this.imagePath,
    required this.productName,
    required this.price,
    required this.isOrdered,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              productName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Text(
                  '$price CFA',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                if (isOrdered) ...[
                  SizedBox(width: 5),
                  Image.asset('assets/images/checked.png', height: 20),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

}

final List<Map<String, dynamic>> products = [
  {
    'produit': 'Tasse en Céramique',
    'categorie': 'Tasse',
    'prix': '3000',
    'image_path': 'assets/images/objets-perdus/WhatsApp Image 2024-06-09 at 00.36.10_223e85e0.jpg',
    'description': 'Une tasse en céramique élégante et durable, parfaite pour vos boissons chaudes préférées.',
    'commande': false,
  },
  {
    'produit': 'Bloc-Notes Écologique',
    'categorie': 'Bloc-Notes',
    'prix': '2000',
    'image_path': 'assets/images/objets-perdus/WhatsApp Image 2024-06-09 at 00.36.10_223e85e0.jpg',
    'description': 'Un bloc-notes fabriqué à partir de matériaux recyclés, idéal pour prendre des notes tout en respectant l\'environnement.',
    'commande': false,
  },
  {
    'produit': 'Porte-Clé en Bois',
    'categorie': 'Porte-Clé',
    'prix': '1500',
    'image_path': 'assets/images/objets-perdus/WhatsApp Image 2024-06-09 at 00.36.10_223e85e0.jpg',
    'description': 'Un porte-clé élégant en bois naturel, léger et résistant pour garder vos clés organisées.',
    'commande': false,
  },
  {
    'produit': 'Gourde Isotherme',
    'categorie': 'Gourde',
    'prix': '5000',
    'image_path': 'assets/images/objets-perdus/WhatsApp Image 2024-06-09 at 00.36.10_223e85e0.jpg',
    'description': 'Une gourde isotherme de haute qualité qui maintient vos boissons chaudes ou froides pendant des heures.',
    'commande': false,
  },
  {
    'produit': 'Tasse à Café Vintage',
    'categorie': 'Tasse',
    'prix': '3500',
    'image_path': 'assets/images/objets-perdus/WhatsApp Image 2024-06-09 at 00.36.10_223e85e0.jpg',
    'description': 'Une tasse à café au design rétro, parfaite pour ajouter une touche de nostalgie à votre pause café.',
    'commande': false,
  },
  {
    'produit': 'Carnet de Voyage',
    'categorie': 'Bloc-Notes',
    'prix': '2500',
    'image_path': 'assets/images/objets-perdus/WhatsApp Image 2024-06-09 at 00.36.10_223e85e0.jpg',
    'description': 'Un carnet élégant pour consigner vos aventures et souvenirs de voyage.',
    'commande': false,
  },
];
