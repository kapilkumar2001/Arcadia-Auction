import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String text;
  final IconData icon;
  

  InfoCard({required this.text, required this.icon,});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.teal,
        ),
        title: Text(
          text,
          style: TextStyle(
            color: Colors.teal,
            fontSize: 18.0,
            fontFamily: 'Source Sans Pro',
          ),
        ),
      ),
    );
  }
}