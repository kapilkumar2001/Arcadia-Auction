import 'package:flutter/material.dart';

class SplashScree extends StatelessWidget {
  const SplashScree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff211B61),
      body: Center(
        child: Container(
          height: 160,
          width: 160,
          child: Image.asset(
            'assets/arcadia-logo1-test2.png',
          ),
        ),
      ),
    );
  }
}
