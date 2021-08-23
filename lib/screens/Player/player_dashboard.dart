import 'package:arcadia/provider/auth.dart';
import 'package:arcadia/provider/players.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../signin_screen.dart';

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

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignInScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: ElevatedButton.icon(
            onPressed: () async {
              await Provider.of<Auth>(context, listen: false).signOut();
              Navigator.of(context)
                  .pushAndRemoveUntil(_routeToSignInScreen(), (route) => false);
            },
            icon: Icon(Icons.arrow_forward),
            label: Text('Sign Out'),
          ),
        ),
      ),
    );
  }
}
