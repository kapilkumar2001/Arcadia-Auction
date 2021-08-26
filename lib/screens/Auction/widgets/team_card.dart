import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/provider/team.dart';
import 'package:flutter/material.dart';

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
          child: Image.network(
              "https://upload.wikimedia.org/wikipedia/en/thumb/2/2b/Chennai_Super_Kings_Logo.svg/1200px-Chennai_Super_Kings_Logo.svg.png"),
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
        trailing: CircleAvatar(
          child: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
