import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/provider/team.dart';
import 'package:arcadia/provider/teams.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeamCard extends StatefulWidget {
  Team team;
  TeamCard(this.team);

  @override
  _TeamCardState createState() => _TeamCardState();
}

class _TeamCardState extends State<TeamCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.blueAccent,
        ),
        color: CustomColors.taskez1,
      ),
      margin: EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          minRadius: 20,
          maxRadius: 20,
          child: FutureBuilder(
            future: Provider.of<Teams>(context, listen: false)
                .getImageUrl(widget.team.teamUid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return CircleAvatar(
                  minRadius: 20,
                  maxRadius: 20,
                  backgroundColor: CustomColors.primaryColor,
                  foregroundColor: Colors.white54,
                  backgroundImage: CachedNetworkImageProvider(
                    snapshot.data.toString(),
                  ),
                );
              } else if (snapshot.hasError) {
                return Icon(Icons.image_not_supported_sharp);
              } else {
                return CircleAvatar(
                  minRadius: 20,
                  maxRadius: 20,
                  backgroundColor: CustomColors.primaryColor,
                  foregroundColor: Colors.white54,
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
        title: Text(
          widget.team.teamName,
          style: TextStyle(
              color: Colors.amberAccent,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        subtitle: Text(
          "Owner: " + widget.team.ownerName,
          style: TextStyle(
              color: Colors.white60, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        // trailing: CircleAvatar(
        //   child: IconButton(
        //     icon: Icon(Icons.edit),
        //     onPressed: () {},
        //   ),
        // ),
      ),
    );
  }
}
