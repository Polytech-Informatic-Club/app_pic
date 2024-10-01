import 'package:flutter/material.dart';

class HistoriqueXoss extends StatelessWidget {
  const HistoriqueXoss({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historiques'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Retour à la page précédente
          },
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          height: 170,
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(" Xossna",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    Image.asset("assets/images/xoss/Ellipse_red.png")
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(127, 127, 127, 1),
                          borderRadius: BorderRadius.circular(10)),
                      width: 200,
                      height: 110,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Scrollbar(
                          trackVisibility: true,
                          thumbVisibility: true,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Image.asset(
                                      "assets/images/xoss/Ellipse_white.png",
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Lait",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Image.asset(
                                      "assets/images/xoss/Ellipse_white.png",
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Lait",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Image.asset(
                                      "assets/images/xoss/Ellipse_white.png",
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Lait",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Image.asset(
                                      "assets/images/xoss/Ellipse_white.png",
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Lait",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Image.asset(
                                      "assets/images/xoss/Ellipse_white.png",
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Lait",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Image.asset(
                                      "assets/images/xoss/Ellipse_white.png",
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Lait",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Image.asset(
                                      "assets/images/xoss/Ellipse_white.png",
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Lait",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Image.asset(
                                      "assets/images/xoss/Ellipse_white.png",
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Lait",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Image.asset(
                                      "assets/images/xoss/Ellipse_white.png",
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Lait",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Image.asset(
                                      "assets/images/xoss/Ellipse_white.png",
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Lait",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Image.asset(
                                      "assets/images/xoss/Ellipse_white.png",
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Lait",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "3000 Fcfa",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "15 fevrier",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
