import 'package:arcadia/provider/auth.dart';
import 'package:arcadia/provider/player.dart';
import 'package:arcadia/provider/players.dart';
import 'package:arcadia/screens/auction_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuctionHome extends StatefulWidget {
  static const routeName = '/auction-home';
  @override
  _AuctionHomeState createState() => _AuctionHomeState();
}

class _AuctionHomeState extends State<AuctionHome> {
  @override
  Widget build(BuildContext context) {
    List<Player> soldPlayers = Provider.of<Players>(context).getSoldPlayers;
    List<Player> unsoldPlayers = Provider.of<Players>(context).getUnsoldPlayers;
    return Material(
      color: Colors.deepPurpleAccent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () async {
                await Provider.of<Auth>(context, listen: false).signOut();
              },
              icon: Icon(Icons.arrow_forward),
              label: Text('Sign Out'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Player nextPlayer =  Provider.of<Players>(context, listen: false).getNextUnsoldPlayer;
                Navigator.of(context).pushNamed(AuctionPlayer.routeName, arguments: nextPlayer );
              },
              icon: Icon(Icons.arrow_forward),
              label: Text('Start Auction'),
            ),
          ],
        ),
      ),
    );
  }
}
