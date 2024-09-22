import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

Widget ReusableTextFormField(String label, TextEditingController controller,
    FormFieldValidator function) {
  return TextFormField(
    controller: controller,
    validator: function,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(fontSize: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
  );
}
