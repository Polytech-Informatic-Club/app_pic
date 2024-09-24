import 'package:flutter/material.dart';
import 'package:new_app/fonctions.dart';
import 'package:new_app/utils/AppColors.dart';

Widget buildMatchCard(
    BuildContext context,
    String id,
    String title,
    DateTime date,
    String equipe1,
    String equipe2,
    String score1,
    String score2,
    String photo1,
    String photo2,
    Widget destination) {
  return GestureDetector(
      onTap: () => changerPage(context, destination),
      child: Column(
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          Container(
            decoration: BoxDecoration(
                color: grisClair, borderRadius: BorderRadius.circular(6)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(dateCustomformat(date)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                              radius: MediaQuery.sizeOf(context).width * 0.08,
                              backgroundImage: NetworkImage(
                                photo2,
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Row(
                            children: [
                              Text(equipe1 + " : "),
                              Text(score1),
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Text(equipe2 + " : "),
                              Text(score2),
                            ],
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          CircleAvatar(
                              radius: MediaQuery.sizeOf(context).width * 0.08,
                              backgroundImage: NetworkImage(
                                photo2,
                              )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ));
}
