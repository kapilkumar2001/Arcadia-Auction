import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/provider/teams.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../provider/match.dart';

class UpcomingMatchCard extends StatelessWidget {
  final Match match;

  final String teamImage = 'assets/AWP.png';

  const UpcomingMatchCard({required this.match});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          height: 60,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.blueAccent,
            ),
            color: CustomColors.taskez1,
          ),
          // margin: EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 0),
          child: ListTile(
            contentPadding:
                EdgeInsets.only(top: 25, bottom: 25, right: 15, left: 15),

            // trailing: Column(children: [
            //   CircleAvatar(
            //   minRadius: 25,
            //   maxRadius: 25,
            //   child: Image.network(
            //     "https://upload.wikimedia.org/wikipedia/en/thumb/2/2b/Chennai_Super_Kings_Logo.svg/1200px-Chennai_Super_Kings_Logo.svg.png",
            //   ),
            // ),
            // ],),
            leading: Column(
              children: [
                CircleAvatar(
                  minRadius: 25,
                  maxRadius: 25,
                  child: Image.asset(
                    teamImage,
                  ),
                ),
              ],
            ),
            trailing: Column(
              children: [
                CircleAvatar(
                  minRadius: 25,
                  maxRadius: 25,
                  child: Image.asset(
                    teamImage,
                  ),
                ),
              ],
            ),
            title: Center(
              child: Column(children: [
                Text(
                  "Match " + match.matchId,
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white60),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Provider.of<Teams>(context)
                          .getTeam(int.parse(match.teamId1))
                          .teamName,
                      style: TextStyle(fontSize: 28, color: Colors.white60),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "vs",
                      style: TextStyle(fontSize: 24, color: Colors.white60),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      Provider.of<Teams>(context)
                          .getTeam(int.parse(match.teamId2))
                          .teamName,
                      style: TextStyle(fontSize: 24, color: Colors.white60),
                    )
                  ],
                ),
                Divider(
                  height: 20,
                  color: Colors.white,
                ),
                Text(
                  "On " +
                      match.matchTime.toLocal().day.toString() +
                      "/" +
                      match.matchTime.toLocal().month.toString() +
                      "/" +
                      match.matchTime.toLocal().year.toString() +
                      " at " +
                      match.matchTime.hour.toString() +
                      ":" +
                      match.matchTime.toLocal().minute.toString(),
                  style: TextStyle(color: Colors.white60),
                ),
              ]),
            ),
          )),
    );
    // Container(
    //   margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    //   height: 80,
    //   width: 180,
    //   decoration: BoxDecoration(
    //     color: Colors.white24,
    //     borderRadius: BorderRadius.circular(20),
    //   ),
    //   child: Column(
    //     children: [
    //       SizedBox(
    //         height: 10,
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.fromLTRB(54, 10, 30, 0),
    //         child: Row(
    //           children: [
    //             Text(
    //               Provider.of<Teams>(context).getTeam(int.parse(match.teamId1)).teamName,
    //               style: TextStyle(color: Colors.white, fontSize: 10),
    //             ),
    //             SizedBox(
    //               width: 10,
    //             ),
    //             Text(
    //               'VS',
    //               style: TextStyle(color: Colors.white),
    //             ),
    //             SizedBox(
    //               width: 10,
    //             ),
    //             Text(match.teamId2,
    //                 style: TextStyle(color: Colors.white, fontSize: 30)),
    //           ],
    //         ),
    //       ),
    //       Divider(
    //         height: 10,
    //       ),
    //       Text(
    //         'Live @ ' + DateFormat('hh:mm dMMM').format(match.matchTime),
    //         style: TextStyle(color: Colors.white, fontSize: 20),
    //         textAlign: TextAlign.start,
    //       ),
    //     ],
    //   ),
    // );
  }
}
