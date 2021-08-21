import 'package:auctions/provider/player.dart';
import 'package:auctions/provider/players.dart';
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
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context).pushNamed();
        },
        icon: Icon(Icons.arrow_forward),
        label: Text('Start Auction'),
      ),
    );
  }
}
