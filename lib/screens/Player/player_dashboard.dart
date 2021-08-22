import 'package:arcadia/provider/auth.dart';
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
          child: ElevatedButton.icon(
            onPressed: () async {
              await Provider.of<Auth>(context, listen: false).signOut();
            },
            icon: Icon(Icons.arrow_forward),
            label: Text('Sign Out'),
          ),
        ),
      ),
    );
  }
}
