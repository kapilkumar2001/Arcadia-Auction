import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/provider/team.dart';
import 'package:arcadia/screens/Player/PlayerScreens/team_details.dart';
import 'package:flutter/material.dart';

class TeamStandingCard extends StatelessWidget {
  final Team team;
  const TeamStandingCard(this.team);

  @override
  Widget build(BuildContext context) {
    TextStyle standingTextStyle = TextStyle(
      fontSize: 22,
      color: CustomColors.firebaseGrey,
    );
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(TeamDetails.routeName, arguments: team);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Material(
          color: CustomColors.secondaryColor,
          borderRadius: BorderRadius.circular(20),
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    team.teamName,
                    textAlign: TextAlign.center,
                    style: standingTextStyle,
                  ),
                ),
                // Expanded(
                //   flex: 1,
                //   child: Container(),
                // ),
                Expanded(
                  flex: 1,
                  child: Text(
                    (team.matchesDraw + team.matchesLost + team.matchesWon)
                        .toString(),
                    style: standingTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    team.matchesWon.toString(),
                    style: standingTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    team.matchesLost.toString(),
                    style: standingTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    team.points.toString(),
                    style: standingTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    team.roundDifference.toString(),
                    style: standingTextStyle,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
