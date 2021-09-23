import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/enums/category.dart';
import 'package:arcadia/models/models.dart';
import 'package:arcadia/provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerCard extends StatelessWidget {
  final Player currPlayer;
  PlayerCard(this.currPlayer);

  Color getCategoryColor(PlayerCategory cat) {
    switch (cat) {
      case PlayerCategory.gold:
        return Color(0xffd4af37);
      case PlayerCategory.silver:
        return Color(0xffc0c0c0);
      case PlayerCategory.bronze:
        return Color(0xffcd7f32);
      default:
        return Colors.white24;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: CustomColors.secondaryColor,
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(
          currPlayer.inGameName,
          style: TextStyle(
            color: getCategoryColor(
              currPlayer.playerCategory,
            ),
          ),
        ),
        subtitle: Text(
          currPlayer.name,
          style: TextStyle(
            color: getCategoryColor(
              currPlayer.playerCategory,
            ),
          ),
        ),
        trailing: Stack(
          children: <Widget>[
            Icon(
              Icons.timer,
              size: 42,
              color: Colors.white30,
            ),
            Positioned(
              right: 0,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  //color: Color(0xFF89CA72),
                  color: Color(0xFF2368F8),
                  borderRadius: BorderRadius.circular(20),
                ),
                constraints: BoxConstraints(
                  minWidth: 18,
                  minHeight: 18,
                ),
                child: Text(
                  currPlayer.hoursPlayed.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
        leading: FutureBuilder(
          future: Provider.of<Players>(context, listen: false)
              .getImageUrl(currPlayer.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CircleAvatar(
                radius: 20,
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.white54,
                backgroundImage: CachedNetworkImageProvider(
                  snapshot.data.toString(),
                ),
              );
            } else if (snapshot.hasError) {
              return Icon(Icons.image_not_supported_sharp);
            } else {
              return CircleAvatar(
                radius: 20,
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.white54,
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
