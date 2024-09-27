import 'package:flutter/material.dart';
import 'package:new_app/pages/annonce/constante.dart';

class PInfoSectionSelector extends StatefulWidget {
  int value;
  int groupValue;
  void Function(int?)? onChanged;
  Image image;
  PInfoSectionSelector(
      {super.key,
      required this.value,
      required this.groupValue,
      required this.onChanged,
      required this.image});

  @override
  State<PInfoSectionSelector> createState() => _PInfoSectionSelectorState();
}

class _PInfoSectionSelectorState extends State<PInfoSectionSelector> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bool selected = widget.value != widget.groupValue;
        if (selected) {
          widget.onChanged!(widget.value);
        }
      },
      child: Column(
        children: [
          Container(
              width: 50,
              height: 50,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(100)),
              clipBehavior: Clip.hardEdge,
              child: widget.image),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: 30,
            height: 5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: widget.value == widget.groupValue
                    ? eptOrange
                    : Colors.white),
          )
        ],
      ),
    );
  }
}
