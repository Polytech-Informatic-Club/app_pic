import 'package:flutter/material.dart';
import 'package:new_app/utils/app_colors.dart';

class InfoCard extends StatelessWidget {
  final Image image;
  final Widget widget;
  final double width;
  final double height;
  final double borderRadius;

  const InfoCard(
      {super.key,
      required this.image,
      required this.widget,
      required this.width,
      required this.height,
      required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
      padding: const EdgeInsets.all(3),
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: eptOrange, borderRadius: BorderRadius.circular(borderRadius)),
      child: Container(
        width: width,
        height: height,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(borderRadius)),
        clipBehavior: Clip.hardEdge,
        child: image,
      ),
    );
  }
}
