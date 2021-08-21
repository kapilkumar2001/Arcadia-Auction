import 'package:flutter/material.dart';

Widget blueButton({BuildContext? context, required String label, buttonWidth}) {
  return AnimatedContainer(
    duration: Duration(seconds: 1),
    width: 250,
    height: 50,
    alignment: Alignment.center,
    child: Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),
    decoration: BoxDecoration(
      color: Color(0xff403b58),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}