import 'dart:ui';

import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/constants/const_strings.dart';
import 'package:arcadia/models/models.dart';
import 'package:arcadia/provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MatchDetails extends StatefulWidget {
  static const routeName = '/match-details';
  final String matchId;
  MatchDetails(this.matchId);

  @override
  _MatchDetailsState createState() => _MatchDetailsState();
}

class _MatchDetailsState extends State<MatchDetails> {
  List<Team> teams = [];
  List<Match> matches = [];
  String mvp = "MVP";
  late Match match;
  bool _isInit = true;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<Matches>(context, listen: false)
          .fetchAndSetMatches()
          .then((value) {
        Provider.of<Teams>(context, listen: false).fetchAndSetTeams().then(
          (value) {
            Provider.of<Players>(context, listen: false)
                .fetchAndSetPlayers()
                .then((value) {
              setState(() {
                _isLoading = false;
                // print(currPlayer);
              });
            });
          },
        );
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    teams = Provider.of<Teams>(context, listen: false).teams;
    matches = Provider.of<Matches>(context, listen: false).matches;
    match = matches[int.parse(widget.matchId)];
    mvp = match.isCompleted
        ? Provider.of<Players>(context, listen: false)
            .getPlayer(match.mvpId.toString())
            .inGameName
        : "NA";
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: CustomColors.primaryColor,
            appBar: AppBar(
              title: Text("Match " + match.matchId),
              backgroundColor: CustomColors.primaryColor,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Container(
                color: CustomColors.firebaseNavy,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Column(children: [
                              CircleAvatar(
                                minRadius: 50,
                                maxRadius: 50,
                                child: FutureBuilder(
                                  future: Provider.of<Teams>(context,
                                          listen: false)
                                      .getImageUrl(teams
                                          .firstWhere(
                                              (e) => e.teamUid == match.teamId1)
                                          .teamUid),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return CircleAvatar(
                                        radius: 50,
                                        backgroundColor:
                                            CustomColors.primaryColor,
                                        foregroundColor: Colors.white54,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                          snapshot.data.toString(),
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Icon(
                                          Icons.image_not_supported_sharp);
                                    } else {
                                      return CircleAvatar(
                                        radius: 20,
                                        backgroundColor:
                                            CustomColors.primaryColor,
                                        foregroundColor: Colors.white54,
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                teams
                                    .firstWhere(
                                        (e) => e.teamUid == match.teamId1)
                                    .teamAbbreviation,
                                // overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.amberAccent,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                          ),
                          Flexible(
                            flex: 2,
                            child: Text(
                              "Vs",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Column(children: [
                              CircleAvatar(
                                minRadius: 50,
                                maxRadius: 50,
                                child: FutureBuilder(
                                  future: Provider.of<Teams>(context,
                                          listen: false)
                                      .getImageUrl(teams
                                          .firstWhere(
                                              (e) => e.teamUid == match.teamId2)
                                          .teamUid),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return CircleAvatar(
                                        radius: 50,
                                        backgroundColor:
                                            CustomColors.primaryColor,
                                        foregroundColor: Colors.white54,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                          snapshot.data.toString(),
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Icon(
                                          Icons.image_not_supported_sharp);
                                    } else {
                                      return CircleAvatar(
                                        radius: 20,
                                        backgroundColor:
                                            CustomColors.primaryColor,
                                        foregroundColor: Colors.white54,
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                teams
                                    .firstWhere(
                                        (e) => e.teamUid == match.teamId2)
                                    .teamAbbreviation,
                                // overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.amberAccent,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      height: 5,
                      color: Colors.blueGrey,
                    ),
                    match.isCompleted
                        ? Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            color: CustomColors.taskez1,
                            margin: EdgeInsets.only(
                                left: 20, right: 20, top: 30, bottom: 10),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, bottom: 20, right: 20, left: 20),
                              child: Column(children: [
                                Text(
                                  "Match Result",
                                  style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          teams
                                              .firstWhere((e) =>
                                                  e.teamUid == match.teamId1)
                                              .teamAbbreviation,
                                          style: TextStyle(
                                              color: Colors.amberAccent,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          match.roundsWon![(match.teamId1)]
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          teams
                                              .firstWhere((e) =>
                                                  e.teamUid == match.teamId2)
                                              .teamAbbreviation,
                                          style: TextStyle(
                                              color: Colors.amberAccent,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          match.roundsWon![(match.teamId2)]
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                (match.points![match.teamId1] ==
                                        match.points![match.teamId2])
                                    ? Text(
                                        "Match Draw",
                                        style: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : ((match.points![match.teamId1]!.toInt()) >
                                            (match.points![match.teamId2]!
                                                .toInt()))
                                        ? Text(
                                            teams
                                                    .firstWhere((e) =>
                                                        e.teamUid ==
                                                        match.teamId1)
                                                    .teamName +
                                                " won the match",
                                            style: TextStyle(
                                                color: Colors.white60,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )
                                        : Text(
                                            teams
                                                    .firstWhere((e) =>
                                                        e.teamUid ==
                                                        match.teamId2)
                                                    .teamName +
                                                " won the match",
                                            style: TextStyle(
                                                color: Colors.white60,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Round Difference :    " +
                                      match.roundDiff.toString(),
                                  style: TextStyle(
                                      color: Colors.white60,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "MVP :  " + mvp,
                                  style: TextStyle(
                                      color: Colors.white60,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                            ),
                          )
                        : Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            color: CustomColors.taskez1,
                            margin: EdgeInsets.only(
                                left: 20, right: 20, top: 30, bottom: 10),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, bottom: 20, right: 30, left: 30),
                              child: Text(
                                  "Match will be live at " +
                                      DateFormat(dateFormat)
                                          .format(match.matchTime),
                                  style: TextStyle(
                                      color: Colors.amberAccent,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          );
  }
}
