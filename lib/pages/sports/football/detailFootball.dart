import 'package:flutter/material.dart';
import 'package:new_app/utils/AppColors.dart';

class DetailFootballScreen extends StatefulWidget {
  const DetailFootballScreen({super.key});

  @override
  State<DetailFootballScreen> createState() => _DetailFootballScreenState();
}

class _DetailFootballScreenState extends State<DetailFootballScreen> {
  int likes = 0;
  bool liked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.orange[50],
      appBar: AppBar(
        backgroundColor: jauneClair,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Détails du match",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: jauneClair),
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  // Match Information
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                AssetImage('assets/team1_logo.png'),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "#47",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(
                        "VS",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                AssetImage('assets/team2_logo.png'),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "#50",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Score
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 35),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    decoration: BoxDecoration(
                      color: orange,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "2",
                                  style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  "Elimane Sall",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text("Modou Ndiaye",
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                            Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Column(
                              children: [
                                Text(
                                  "1",
                                  style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text("Elimane Sall",
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Statistiques
            Text(
              "Statistiques",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Statistics Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Team 1 Stats
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              "0",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              "0",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text("Cartons"),
                    ],
                  ),
                  // Statistics Icons
                  Column(
                    children: [
                      Icon(Icons.sports_soccer, size: 32),
                      Text("tirs"),
                      Text("3 - 1"),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.sports, size: 32),
                      Text("tirs cadrés"),
                      Text("0 - 0"),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.error_outline, size: 32),
                      Text("fautes"),
                      Text("0 - 0"),
                    ],
                  ),
                  // Team 2 Stats
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              "0",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              "0",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text("Cartons"),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              child: Divider(
                color: Colors.black,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.thumb_up,
                    color: liked ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () {
                    if (liked) {
                      setState(() {
                        liked = false;
                        likes--;
                      });
                    } else {
                      setState(() {
                        liked = true;
                        likes++;
                      });
                    }
                  },
                ),
                Text(likes.toString()),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.message,
                      color: Colors.grey,
                    ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            // Comment Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Commentaires",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  // Comment 1
                  CommentWidget(
                    name: "Elimane Sall",
                    comment: "Lorem ipsum dolor sit amet consectetur.",
                    timeAgo: "Il y a 1 jour",
                  ),
                  // Comment 2
                  CommentWidget(
                    name: "Elimane Sall",
                    comment: "Lorem ipsum dolor sit amet consectetur.",
                    timeAgo: "Il y a 1 jour",
                  ),
                  CommentWidget(
                    name: "Elimane Sall",
                    comment: "Lorem ipsum dolor sit amet consectetur.",
                    timeAgo: "Il y a 1 jour",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentWidget extends StatelessWidget {
  final String name;
  final String comment;

  final String timeAgo;

  const CommentWidget({
    super.key,
    required this.name,
    required this.comment,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/avatar.png'),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(comment),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        timeAgo,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(),
      ],
    );
  }
}
