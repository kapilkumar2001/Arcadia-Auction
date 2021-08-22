import 'package:arcadia/provider/players.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerDashBoard extends StatefulWidget {
  const PlayerDashBoard({Key? key}) : super(key: key);

  static const routeName = '\playerDashBoard';

  @override
  _PlayerDashBoardState createState() => _PlayerDashBoardState();
}

class _PlayerDashBoardState extends State<PlayerDashBoard> {
  @override
  void didChangeDependencies() {
    Provider.of<Players>(context, listen: false).fetchAndSetPlayers();
    super.didChangeDependencies();
  }

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
