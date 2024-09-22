import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:new_app/utils/AppColors.dart';

Widget SubmittedButton(String label, Function() _onSubmited) {
  return ElevatedButton(
    onPressed: _onSubmited,
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    child: Text(
      label,
      style: TextStyle(fontSize: 16, color: Colors.black),
    ),
  );
}
