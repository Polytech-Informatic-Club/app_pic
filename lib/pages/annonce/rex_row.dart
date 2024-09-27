import 'package:flutter/material.dart';
import 'package:new_app/pages/annonce/rex_item.dart';

class Rex extends StatefulWidget {
  const Rex({super.key});

  @override
  State<Rex> createState() => _RexState();
}

class _RexState extends State<Rex> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            RexItem(
                name: "Mamadou Dieng",
                title: "#33 GC",
                image: Image.asset(
                    "assets/images/polytech-Info/WhatsApp Image 2024-06-02 at 12.01.28_4d890e8e.jpg")),
            const SizedBox(
              width: 20,
            ),
            RexItem(
                name: "Mamadou Dieng",
                title: "#33 GC",
                image: Image.asset(
                    "assets/images/polytech-Info/WhatsApp Image 2024-06-02 at 12.01.28_4d890e8e.jpg")),
            const SizedBox(
              width: 20,
            ),
            RexItem(
                name: "Mamadou Dieng",
                title: "#33 GC",
                image: Image.asset(
                    "assets/images/polytech-Info/WhatsApp Image 2024-06-02 at 12.01.28_4d890e8e.jpg")),
            const SizedBox(
              width: 20,
            ),
            RexItem(
                name: "Mamadou Dieng",
                title: "#33 GC",
                image: Image.asset(
                    "assets/images/polytech-Info/WhatsApp Image 2024-06-02 at 12.01.28_4d890e8e.jpg")),
            const SizedBox(
              width: 20,
            ),
            RexItem(
                name: "Mamadou Dieng",
                title: "#33 GC",
                image: Image.asset(
                    "assets/images/polytech-Info/WhatsApp Image 2024-06-02 at 12.01.28_4d890e8e.jpg")),
            const SizedBox(
              width: 20,
            ),
            RexItem(
                name: "Mamadou Dieng",
                title: "#33 GC",
                image: Image.asset(
                    "assets/images/polytech-Info/WhatsApp Image 2024-06-02 at 12.01.28_4d890e8e.jpg")),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
