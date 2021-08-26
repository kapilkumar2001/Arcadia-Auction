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
    return match.isCompleted
        ? Container(
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
              trailing: CircleAvatar(
                child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                ),
                backgroundColor: Colors.blueAccent,
              ),
              title: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Center(
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
                          teams[int.parse(match.teamId1)].teamName,
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
                          teams[int.parse(match.teamId2)].teamName,
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
                    (match.points![match.teamId1] ==
                            match.points![match.teamId2])
                        ? Text(
                            "Match Draw",
                            style: TextStyle(color: Colors.white60),
                          )
                        : ((match.points![match.teamId1]!.toInt()) >
                                (match.points![match.teamId2]!.toInt()))
                            ? Text(
                                teams[int.parse(match.teamId1)].teamName +
                                    " won the match",
                                style: TextStyle(color: Colors.white60),
                              )
                            : Text(
                                teams[int.parse(match.teamId2)].teamName +
                                    " won the match",
                                style: TextStyle(color: Colors.white60),
                              )
                  ]),
                ),
              ),
            ))
        : Container(
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
              trailing: CircleAvatar(
                child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                ),
                backgroundColor: Colors.blueAccent,
              ),
              title: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Center(
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
                          teams[int.parse(match.teamId1)].teamName,
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
                          teams[int.parse(match.teamId2)].teamName,
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
                      "Live at " +
                          DateFormat('hh:mm dMMM').format(match.matchTime),
                      style: TextStyle(color: Colors.white60),
                    ),
                  ]),
                ),
              ),
            ));
  }
}
