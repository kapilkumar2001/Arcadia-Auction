import 'package:flutter/material.dart';

class UpdateCard extends StatelessWidget {
  final String date,title,message;

  UpdateCard({required this.date,required this.title,required this.message});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(child: Text(title,style: TextStyle(fontSize: 20),)),
                Flexible(child: Text(date,style: TextStyle(fontSize: 12)))
              ],
            ),
            Divider(height: 20,color: Colors.black,),
            Text(message,style: TextStyle(fontSize: 15,
            fontWeight: FontWeight.w300)),
          ],
        ),
      ),
    );
  }
}