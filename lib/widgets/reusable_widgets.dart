import 'package:flutter/material.dart';
import 'package:new_app/utils/AppColors.dart';

Widget reusableTextFormField(String label, TextEditingController controller,
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


Widget buildMatchCard(String title, String date, String logoteam1,
    String score1, String logoteam2, String score2) {
  return Column(
    children: [
      Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      Container(
        decoration: BoxDecoration(
            color: grisClair, borderRadius: BorderRadius.circular(6)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(date),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: grisClair,
                        backgroundImage: AssetImage(logoteam1),
                      ),
                      Text(score1),
                    ],
                  ),
                  Row(
                    children: [
                      Text(score2),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: grisClair,
                        backgroundImage: AssetImage(logoteam2),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
