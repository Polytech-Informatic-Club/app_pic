import 'package:flutter/material.dart';

class Articles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Articles();
}

class _Articles extends State<Articles> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // Image en arrière-plan
                Container(
                  height: 650,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/market/photo_2024-05-24_12-27-39.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                // Contenu centré par-dessus l'image
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xffffdead),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Nouvelle Collection',
                            style: TextStyle(
                              fontSize: screenWidth * 0.08,
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 24),
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
            // Partie Nouveautés avec produits
            Positioned(
              top: 50,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Barre de recherche
                  Padding(
                    padding: const EdgeInsets.all(8.0), // Ajoute du padding ici
                    child: Container(
                      width: screenWidth * 0.6,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xffd9d9d9),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: Color(0xff777777), size: 20),
                            SizedBox(width: 5),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Chercher',
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff777777),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Bouton "Catégories"
                  Padding(
                    padding: const EdgeInsets.all(8.0), // Ajoute du padding ici aussi
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

                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(
                      imagePath: product['image_path'] ?? 'assets/default_image.png',
                      productName: product['produit'] ?? 'Nom du produit',
                      price: product['prix'] ?? '0',
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

class ProductCard extends StatelessWidget {
  final String imagePath;
  final String productName;
  final String price;

  const ProductCard({
    required this.imagePath,
    required this.productName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              productName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              price + ' FCFA',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

// Liste des produits
final List<Map<String, String>> products = [
  {
    'image_path': 'assets/images/objets-perdus/WhatsApp Image 2024-06-09 at 00.36.10_223e85e0.jpg',
    'produit': 'Tasse Cinquantenaire',
    'prix': '5000',
  },
  {
    'image_path': 'assets/images/objets-perdus/WhatsApp Image 2024-06-09 at 00.36.10_223e85e0.jpg',
    'produit': 'Bloc-Notes EPT',
    'prix': '3000',
  },
  {
    'image_path': 'assets/images/objets-perdus/WhatsApp Image 2024-06-09 at 00.36.10_223e85e0.jpg',
    'produit': 'Porte-Clé EPT',
    'prix': '1500',
  },
  {
    'image_path': 'assets/images/objets-perdus/WhatsApp Image 2024-06-09 at 00.36.10_223e85e0.jpg',
    'produit': 'Gourde Cinquantenaire',
    'prix': '6000',
  },
  {
    'image_path': 'assets/images/objets-perdus/WhatsApp Image 2024-06-09 at 00.36.10_223e85e0.jpg',
    'produit': 'Tasse Cinquantenaire Jaune',
    'prix': '5000',
  },
  {
    'image_path': 'assets/images/objets-perdus/WhatsApp Image 2024-06-09 at 00.36.10_223e85e0.jpg',
    'produit': 'Tasse Cinquantenaire Noir',
    'prix': '5000',
  },
];
