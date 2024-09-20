import 'package:flutter/material.dart';
import 'package:new_app/pages/home/navbar.dart';
import 'package:new_app/pages/sports/PagesSports/foot.dart';

class Sports extends StatefulWidget {
  const Sports({super.key});

  @override
  State<Sports> createState() => _SportsState();
}

class _SportsState extends State<Sports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sports'),
      ),
      bottomNavigationBar:
          navbar(pageIndex: 3), // Assuming you have a navbar widget
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.sports_soccer, color: Colors.green),
            title: Text('Football'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FootballPage()),
              );
            },
          ),
          // Add more sports as needed
        ],
      ),
    );
  }
}
