import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/provider/match.dart';
import 'package:arcadia/provider/team.dart';
import 'package:arcadia/provider/teams.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MatchCard extends StatelessWidget {
  Match match;
  List<Team> teams;
  MatchCard(this.match, this.teams);

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
          contentPadding:
              EdgeInsets.only(top: 25, bottom: 25, right: 15, left: 15),
          // leading: Column(
          //   children: [
          //     CircleAvatar(
          //       minRadius: 25,
          //       maxRadius: 25,
          //       child: Image.network(
          //         "https://upload.wikimedia.org/wikipedia/en/thumb/2/2b/Chennai_Super_Kings_Logo.svg/1200px-Chennai_Super_Kings_Logo.svg.png",
          //       ),
          //     ),
          //   ],
          // ),
          // trailing: Column(
          //   children: [
          //     CircleAvatar(
          //       minRadius: 25,
          //       maxRadius: 25,
          //       child: Image.network(
          //         "https://upload.wikimedia.org/wikipedia/en/thumb/2/2b/Chennai_Super_Kings_Logo.svg/1200px-Chennai_Super_Kings_Logo.svg.png",
          //       ),
          //     ),
          //   ],
          // ),
          title: Center(
            child: Column(children: [
              Text(
                "Match " + match.matchId,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white60),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    teams[int.parse(match.teamId1)].teamName[0] +
                        teams[int.parse(match.teamId1)].teamName[1] +
                        teams[int.parse(match.teamId1)].teamName[2] +
                        "...",
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                        color: Colors.white60,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  Text(
                    "   Vs   ",
                    style: TextStyle(
                        color: Colors.white60,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  Text(
                    teams[int.parse(match.teamId2)].teamName[0] +
                        teams[int.parse(match.teamId2)].teamName[1] +
                        teams[int.parse(match.teamId2)].teamName[2] +
                        "...",
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                        color: Colors.white60,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ],
              ),
              Divider(
                height: 20,
                color: Colors.white,
              ),
              Text(
                "Live at " + DateFormat('hh:mm dMMM').format(match.matchTime),
                style: TextStyle(color: Colors.white60),
              ),
            ]),
          ),
        ));
  }
}
