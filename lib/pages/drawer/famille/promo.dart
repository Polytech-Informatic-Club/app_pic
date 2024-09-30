import 'package:flutter/material.dart';
import 'package:new_app/utils/app_colors.dart';

class PromotionPage extends StatelessWidget {
  const PromotionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
              ),
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/Competition/logo50.png',
                      height: 150,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Promotion 50',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Devise: "Douma Meusseu bayi EPT ba dé"',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: SizedBox(
                  height: 26,
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'chercher',
                      hintStyle: TextStyle(
                        fontSize: 12,
                      ),
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(style: BorderStyle.none),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              eleveWidget('image', 'Abdou Salam Mboup', 'GIT', '777777777'),
              eleveWidget('image', 'Abdou Salam Mboup', 'GIT', '777777777'),
              eleveWidget('image', 'Abdou Salam Mboup', 'GIT', '777777777'),
              eleveWidget('image', 'Abdou Salam Mboup', 'GIT', '777777777'),
              eleveWidget('image', 'Abdou Salam Mboup', 'GIT', '777777777'),
              eleveWidget('image', 'Abdou Salam Mboup', 'GIT', '777777777'),
              eleveWidget('image', 'Abdou Salam Mboup', 'GIT', '777777777'),
              eleveWidget('image', 'Abdou Salam Mboup', 'GIT', '777777777'),
              eleveWidget('image', 'Abdou Salam Mboup', 'GIT', '777777777'),
            ],
          ),
        ),
      ),
    );
  }
}

Widget eleveWidget(image, nom, genie, numero) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: 5),
    elevation: 0,
    color: eptLighterOrange,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    child: ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(image),
        radius: 30,
      ),
      title: Text(
        nom,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(genie),
          Row(
            children: [
              Icon(Icons.phone, size: 14),
              SizedBox(width: 5),
              Text(numero),
            ],
          ),
        ],
      ),
    ),
  );
}
