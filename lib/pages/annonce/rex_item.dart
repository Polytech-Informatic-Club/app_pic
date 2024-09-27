import 'package:flutter/material.dart';
import 'package:new_app/pages/annonce/constante.dart';

class RexItem extends StatelessWidget {
  String name;
  String title;
  Image image;
  GestureTapCallback? onTap;
  RexItem({
    super.key,
    required this.name,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            name,
            style: const TextStyle(fontFamily: "Inter", fontSize: 12),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.all(5),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: adeptPurple),
            child: Container(
              decoration: BoxDecoration(
                  color: adeptYellow, borderRadius: BorderRadius.circular(10)),
              child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: image),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: const TextStyle(fontFamily: "Inter", fontSize: 12),
          ),
        ],
      ),
    );
  }
}
