import 'package:flutter/material.dart';

class PlayerDashBoard extends StatelessWidget {
  const PlayerDashBoard({Key? key}) : super(key: key);

  static const routeName = '\playerDashBoard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("hello"),
        ),
      ),
    );
  }
}
