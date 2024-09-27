// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'dart:async';

class blousonPage extends StatefulWidget {
  const blousonPage({super.key});

  @override
  _Blouson_PageState createState() => _Blouson_PageState();
}

class _Blouson_PageState extends State<blousonPage> {
  final List<String> carouselImages = [
    'assets/images/market/photo_2024-05-24_12-27-39.jpg',
    'assets/images/market/photo_2024-05-24_12-27-53.jpg',
    'assets/images/market/photo_2024-05-24_12-27-08.jpg',
    'assets/images/market/photo_2024-05-24_12-28-09.jpg',
  ];

  int _currentPage = 0;
  late Timer _timer;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < carouselImages.length - 1) {
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
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _nextImage() {
    _currentPage = (_currentPage + 1) % carouselImages.length;
    _pageController.animateToPage(
      _currentPage,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousImage() {
    _currentPage =
        (_currentPage - 1 + carouselImages.length) % carouselImages.length;
    _pageController.animateToPage(
      _currentPage,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _showProductDetails() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(carouselImages[_currentPage], height: 200),
              SizedBox(height: 10),
              Text("Blouson 2024",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Catégorie: Classe Polytechnicienne'),
              Text('Prix: 5000 CFA'),
              SizedBox(height: 10),
              Text('Description du blouson: Un blouson stylé et confortable.'),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Commander'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _showOrderConfirmation();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showOrderConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/checked.png', height: 100),
              SizedBox(height: 20),
              Text('Commande passée avec succès', textAlign: TextAlign.center),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Carousel
            Positioned.fill(
              child: PageView.builder(
                controller: _pageController,
                itemCount: carouselImages.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return Image.asset(
                    carouselImages[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  );
                },
              ),
            ),
            // Left Arrow
            Positioned(
              left: 10,
              top: MediaQuery.of(context).size.height * 0.5 - 20,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                onPressed: _previousImage,
              ),
            ),
            // Right Arrow
            Positioned(
              right: 10,
              top: MediaQuery.of(context).size.height * 0.5 - 20,
              child: IconButton(
                icon: Icon(Icons.arrow_forward_ios,
                    color: Colors.white, size: 30),
                onPressed: _nextImage,
              ),
            ),
            // Back Button
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            // Product Information and Order Button
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100.withOpacity(0.7),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Blousons 2024",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cursive'),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Classe Polytechnicienne",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _showProductDetails,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Commander',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                          SizedBox(width: 5),
                          Icon(Icons.shopping_cart, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
