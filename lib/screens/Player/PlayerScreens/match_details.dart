import 'dart:ui';

import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/provider/matches.dart';
import 'package:arcadia/provider/match.dart';
import 'package:arcadia/provider/players.dart';
import 'package:arcadia/provider/team.dart';
import 'package:arcadia/provider/teams.dart';
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
            appBar: AppBar(
              title: Text("Match " + match.matchId),
              backgroundColor: CustomColors.primaryColor,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Container(
                color: CustomColors.primaryColor,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(children: [
                          CircleAvatar(
                            minRadius: 50,
                            maxRadius: 50,
                            child: Image.network(
                                "https://upload.wikimedia.org/wikipedia/en/thumb/2/2b/Chennai_Super_Kings_Logo.svg/1200px-Chennai_Super_Kings_Logo.svg.png"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            teams[int.parse(match.teamId1)].teamName[0] +
                                teams[int.parse(match.teamId1)].teamName[1] +
                                teams[int.parse(match.teamId1)].teamName[2] +
                                "...",
                            style: TextStyle(
                                color: Colors.amberAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
                        ]),
                        Text(
                          "Vs",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        Column(children: [
                          CircleAvatar(
                            minRadius: 50,
                            maxRadius: 50,
                            child: Image.network(
                                "https://upload.wikimedia.org/wikipedia/en/thumb/2/2b/Chennai_Super_Kings_Logo.svg/1200px-Chennai_Super_Kings_Logo.svg.png"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            teams[int.parse(match.teamId2)].teamName[0] +
                                teams[int.parse(match.teamId2)].teamName[1] +
                                teams[int.parse(match.teamId2)].teamName[2] +
                                "...",
                            style: TextStyle(
                                color: Colors.amberAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
                        ]),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      height: 5,
                      color: Colors.blueGrey,
                    ),
                    // Card(
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.all(Radius.circular(50))),
                    //   color: CustomColors.taskez1,
                    //   margin:
                    //       EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(
                    //         top: 20, bottom: 20, right: 20, left: 20),
                    //     child: Text(
                    //       "Team 2 Won the Match by pointDiff 3",
                    //       style: TextStyle(
                    //           color: Colors.white54,
                    //           fontSize: 20,
                    //           fontWeight: FontWeight.bold),
                    //     ),
                    //   ),
                    // ),
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
                                          teams[int.parse(match.teamId1)]
                                              .teamName,
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
                                          teams[int.parse(match.teamId2)]
                                              .teamName,
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
                                            teams[int.parse(match.teamId1)]
                                                    .teamName +
                                                " won the match",
                                            style: TextStyle(
                                                color: Colors.white60,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )
                                        : Text(
                                            teams[int.parse(match.teamId2)]
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
                                      DateFormat('hh:mm dMMM')
                                          .format(match.matchTime),
                                  style: TextStyle(
                                      color: Colors.amberAccent,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),

                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   height: MediaQuery.of(context).size.height,
                    //   child: Card(
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius:
                    //             BorderRadius.all(Radius.circular(20))),
                    //     color: CustomColors.taskez1,
                    //     margin: EdgeInsets.only(
                    //         left: 20, right: 20, top: 30, bottom: 10),
                    //     child: Padding(
                    //       padding: const EdgeInsets.only(
                    //           top: 20, bottom: 20, right: 20, left: 20),
                    //       child: DefaultTabController(
                    //           length: 2,
                    //           initialIndex: 0,
                    //           child: Column(
                    //             children: [
                    //               TabBar(
                    //                 indicatorColor: Colors.white70,
                    //                 tabs: [
                    //                   Tab(
                    //                     child: Text(
                    //                         teams[int.parse(match.teamId1)]
                    //                             .teamName
                    //                             .toString()),
                    //                   ),
                    //                   Tab(
                    //                     child: Text(
                    //                         teams[int.parse(match.teamId2)]
                    //                             .teamName
                    //                             .toString()),
                    //                   )
                    //                 ],
                    //               ),
                    //               TabBarView(
                    //                   physics: ScrollPhysics(),
                    //                   children: [
                    //                     Column(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.center,
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment.start,
                    //                       children: [
                    //                         Text(
                    //                           teams[int.parse(match.teamId1)]
                    //                               .teamName,
                    //                           style: TextStyle(
                    //                               color: Colors.amberAccent,
                    //                               fontSize: 20,
                    //                               fontWeight: FontWeight.bold),
                    //                         ),
                    //                         SizedBox(
                    //                           height: 25,
                    //                         ),
                    //                         SizedBox(
                    //                             height: 50,
                    //                             child: Column(
                    //                               children: [
                    //                                 ...teams[int.parse(
                    //                                         match.teamId1)]
                    //                                     .playerUid
                    //                                     .map(
                    //                                       (e) => (Column(
                    //                                           children: [
                    //                                             Text(
                    //                                                 Provider.of<Players>(
                    //                                                         context,
                    //                                                         listen:
                    //                                                             false)
                    //                                                     .getPlayer(e
                    //                                                         .toString())
                    //                                                     .inGameName
                    //                                                     .toString(),
                    //                                                 style: TextStyle(
                    //                                                     color: Colors
                    //                                                         .white60,
                    //                                                     fontSize:
                    //                                                         20,
                    //                                                     fontWeight:
                    //                                                         FontWeight.bold)),
                    //                                             SizedBox(
                    //                                               height: 4,
                    //                                             )
                    //                                           ])),
                    //                                     )
                    //                                     .toList(),
                    //                               ],
                    //                             )),
                    //                       ],
                    //                     ),
                    //                     Column(
                    //                       children: [
                    //                         Text(
                    //                           teams[int.parse(match.teamId2)]
                    //                               .teamName,
                    //                           style: TextStyle(
                    //                               color: Colors.amberAccent,
                    //                               fontSize: 20,
                    //                               fontWeight: FontWeight.bold),
                    //                         ),
                    //                         SizedBox(
                    //                           height: 20,
                    //                         ),
                    //                         // ...teams[int.parse(match.teamId2)]
                    //                         //     .playerUid
                    //                         //     .map(
                    //                         //       (e) => (Column(children: [
                    //                         //         Text(
                    //                         //             Provider.of<Players>(
                    //                         //                     context,
                    //                         //                     listen: false)
                    //                         //                 .getPlayer(
                    //                         //                     e.toString())
                    //                         //                 .inGameName
                    //                         //                 .toString(),
                    //                         //             style: TextStyle(
                    //                         //                 color:
                    //                         //                     Colors.white60,
                    //                         //                 fontSize: 20,
                    //                         //                 fontWeight:
                    //                         //                     FontWeight
                    //                         //                         .bold)),
                    //                         //         SizedBox(height: 4)
                    //                         //       ])),
                    //                         //     )
                    //                         //     .toList(),
                    //                         SizedBox(
                    //                             height: 50,
                    //                             child: Column(
                    //                               children: [
                    //                                 ...teams[int.parse(
                    //                                         match.teamId1)]
                    //                                     .playerUid
                    //                                     .map(
                    //                                       (e) => (Column(
                    //                                           children: [
                    //                                             Text(
                    //                                                 Provider.of<Players>(
                    //                                                         context,
                    //                                                         listen:
                    //                                                             false)
                    //                                                     .getPlayer(e
                    //                                                         .toString())
                    //                                                     .inGameName
                    //                                                     .toString(),
                    //                                                 style: TextStyle(
                    //                                                     color: Colors
                    //                                                         .white60,
                    //                                                     fontSize:
                    //                                                         20,
                    //                                                     fontWeight:
                    //                                                         FontWeight.bold)),
                    //                                             SizedBox(
                    //                                               height: 4,
                    //                                             )
                    //                                           ])),
                    //                                     )
                    //                                     .toList(),
                    //                               ],
                    //                             )),
                    //                       ],
                    //                     ),
                    //                   ])
                    //             ],
                    //           )

                    //       //                           child: Row(
                    //       //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //       //   children: [
                    //       //     Column(
                    //       //       children: [
                    //       //         Text(
                    //       //           teams[int.parse(match.teamId1)].teamName,
                    //       //           style: TextStyle(
                    //       //               color: Colors.amberAccent,
                    //       //               fontSize: 20,
                    //       //               fontWeight: FontWeight.bold),
                    //       //         ),
                    //       //         SizedBox(
                    //       //           height: 25,
                    //       //         ),
                    //       //         ...teams[int.parse(match.teamId1)]
                    //       //             .playerUid
                    //       //             .map(
                    //       //               (e) => (Column(children: [
                    //       //                 Text(
                    //       //                     Provider.of<Players>(context,
                    //       //                             listen: false)
                    //       //                         .getPlayer(e.toString())
                    //       //                         .inGameName
                    //       //                         .toString(),
                    //       //                     style: TextStyle(
                    //       //                         color: Colors.white60,
                    //       //                         fontSize: 20,
                    //       //                         fontWeight: FontWeight.bold)),
                    //       //                 SizedBox(
                    //       //                   height: 4,
                    //       //                 )
                    //       //               ])),
                    //       //             )
                    //       //             .toList(),
                    //       //       ],
                    //       //     ),
                    //       //     Column(
                    //       //       children: [
                    //       //         Text(
                    //       //           teams[int.parse(match.teamId2)].teamName,
                    //       //           style: TextStyle(
                    //       //               color: Colors.amberAccent,
                    //       //               fontSize: 20,
                    //       //               fontWeight: FontWeight.bold),
                    //       //         ),
                    //       //         SizedBox(
                    //       //           height: 20,
                    //       //         ),
                    //       //         ...teams[int.parse(match.teamId2)]
                    //       //             .playerUid
                    //       //             .map(
                    //       //               (e) => (Column(children: [
                    //       //                 Text(
                    //       //                     Provider.of<Players>(context,
                    //       //                             listen: false)
                    //       //                         .getPlayer(e.toString())
                    //       //                         .inGameName
                    //       //                         .toString(),
                    //       //                     style: TextStyle(
                    //       //                         color: Colors.white60,
                    //       //                         fontSize: 20,
                    //       //                         fontWeight: FontWeight.bold)),
                    //       //                 SizedBox(height: 4)
                    //       //               ])),
                    //       //             )
                    //       //             .toList(),
                    //       //       ],
                    //       //     ),
                    //       //   ],
                    //       // ),

                    //       //    TabBarView(children: [
                    //       //   Column(
                    //       //     children: [
                    //       //       Text(
                    //       //         teams[int.parse(match.teamId1)].teamName,
                    //       //         style: TextStyle(
                    //       //             color: Colors.amberAccent,
                    //       //             fontSize: 20,
                    //       //             fontWeight: FontWeight.bold),
                    //       //       ),
                    //       //       SizedBox(
                    //       //         height: 25,
                    //       //       ),
                    //       //       ...teams[int.parse(match.teamId1)]
                    //       //           .playerUid
                    //       //           .map(
                    //       //             (e) => (Column(children: [
                    //       //               Text(
                    //       //                   Provider.of<Players>(context,
                    //       //                           listen: false)
                    //       //                       .getPlayer(e.toString())
                    //       //                       .inGameName
                    //       //                       .toString(),
                    //       //                   style: TextStyle(
                    //       //                       color: Colors.white60,
                    //       //                       fontSize: 20,
                    //       //                       fontWeight: FontWeight.bold)),
                    //       //               SizedBox(
                    //       //                 height: 4,
                    //       //               )
                    //       //             ])),
                    //       //           )
                    //       //           .toList(),
                    //       //     ],
                    //       //   ),
                    //       //   Column(
                    //       //     children: [
                    //       //       Text(
                    //       //         teams[int.parse(match.teamId2)].teamName,
                    //       //         style: TextStyle(
                    //       //             color: Colors.amberAccent,
                    //       //             fontSize: 20,
                    //       //             fontWeight: FontWeight.bold),
                    //       //       ),
                    //       //       SizedBox(
                    //       //         height: 20,
                    //       //       ),
                    //       //       ...teams[int.parse(match.teamId2)]
                    //       //           .playerUid
                    //       //           .map(
                    //       //             (e) => (Column(children: [
                    //       //               Text(
                    //       //                   Provider.of<Players>(context,
                    //       //                           listen: false)
                    //       //                       .getPlayer(e.toString())
                    //       //                       .inGameName
                    //       //                       .toString(),
                    //       //                   style: TextStyle(
                    //       //                       color: Colors.white60,
                    //       //                       fontSize: 20,
                    //       //                       fontWeight: FontWeight.bold)),
                    //       //               SizedBox(height: 4)
                    //       //             ])),
                    //       //           )
                    //       //           .toList(),
                    //       //     ],
                    //       //   ),
                    //       // ])
                    //       ),
                    // ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
