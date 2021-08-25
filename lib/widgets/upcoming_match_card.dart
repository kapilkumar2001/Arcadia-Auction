import 'package:arcadia/provider/teams.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../provider/match.dart';

class UpcomingMatchCard extends StatelessWidget {
  final Match match;

  const UpcomingMatchCard({required this.match});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      height: 80,
      width: 180,
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(54, 10, 30, 0),
            child: Row(
              children: [
                Text(
                  Provider.of<Teams>(context).getTeam(int.parse(match.teamId1)).teamName,
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'VS',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(match.teamId2,
                    style: TextStyle(color: Colors.white, fontSize: 30)),
              ],
            ),
          ),
          Divider(
            height: 10,
          ),
          Text(
            'Live @ ' + DateFormat('hh:mm dMMM').format(match.matchTime),
            style: TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
