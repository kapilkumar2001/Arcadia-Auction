import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/constants/const_strings.dart';
import 'package:arcadia/provider/teams.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:arcadia/models/models.dart';

class UpcomingMatchCard extends StatefulWidget {
  final Match match;

  const UpcomingMatchCard({required this.match});

  @override
  _UpcomingMatchCardState createState() => _UpcomingMatchCardState();
}

class _UpcomingMatchCardState extends State<UpcomingMatchCard> {
  var team1, team2;
 
 
  @override
 

  @override
  Widget build(BuildContext context) {
    var team1 = Provider.of<Teams>(context, listen: false)
        .getTeam(widget.match.teamId1);
    var team2 = Provider.of<Teams>(context, listen: false)
        .getTeam(widget.match.teamId2);
    return  Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            width: 270,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: CustomColors.secondaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FutureBuilder(
                        future: Provider.of<Teams>(context, listen: false)
                            .getImageUrl(team1.teamUid),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return CircleAvatar(
                              radius: 20,
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
                              radius: 20,
                              backgroundColor: CustomColors.primaryColor,
                              foregroundColor: Colors.white54,
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                            ),
                            Text(
                              team1.teamAbbreviation,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white60,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              flex: 3,
                              child: Text(
                                widget.match.roundsWon![widget.match.teamId1]
                                        ?.toString() ??
                                    '0',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white60,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Flexible(
                              flex: 5,
                              child: Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white60,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: Text(
                                widget.match.roundsWon![widget.match.teamId2]
                                        ?.toString() ??
                                    '0',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white60,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FutureBuilder(
                        future: Provider.of<Teams>(context, listen: false)
                            .getImageUrl(team2.teamUid),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return CircleAvatar(
                              radius: 20,
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
                              radius: 20,
                              backgroundColor: CustomColors.primaryColor,
                              foregroundColor: Colors.white54,
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                            ),
                            Text(
                              team2.teamAbbreviation,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white60,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Divider(
                    height: 2,
                    thickness: 2,
                    color: Colors.white,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat(dateFormat).format(widget.match.matchTime) +
                            ' B03',
                        // '04/06 12:00 B03',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
