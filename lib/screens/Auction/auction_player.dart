import 'package:arcadia/provider/player.dart';
import 'package:flutter/material.dart';

class AuctionPlayer extends StatefulWidget {
  static const routeName = '/auction-player';
  const AuctionPlayer({Key? key}) : super(key: key);

  @override
  _AuctionPlayerState createState() => _AuctionPlayerState();
}

class _AuctionPlayerState extends State<AuctionPlayer> {
  @override
  Widget build(BuildContext context) {
    final currPlayer = ModalRoute.of(context)!.settings.arguments as Player;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(currPlayer.name),
          ),
          Expanded(
            flex: 1,
            child: Text(currPlayer.playerCategory.toString()),
          ),
          Expanded(
            flex: 1,
            child: Text(currPlayer.primaryWeapon.toString()),
          )
        ],
      ),
    );
  }
}
