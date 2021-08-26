import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/provider/matches.dart';
import 'package:arcadia/provider/match.dart';
import 'package:arcadia/provider/team.dart';
import 'package:arcadia/provider/teams.dart';
import 'package:arcadia/screens/Player/PlayerScreens/match_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ScheduleScreen extends StatefulWidget {
  static const routeName = '/schedule-screen';
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List<Match> upcomingmatches = [];
  List<Match> completedmatches = [];
  List<Team> teams = [];
  bool _isInit = true;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<Matches>(context, listen: false).fetchAndSetMatches().then(
        (value) {
          Provider.of<Teams>(context, listen: false).fetchAndSetTeams().then(
                (value) => setState(() {
                  _isLoading = false;
                }),
              );
        },
      );
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    upcomingmatches =
        Provider.of<Matches>(context, listen: false).upcomingMatches;
    completedmatches =
        Provider.of<Matches>(context, listen: false).completedMatches;
    teams = Provider.of<Teams>(context, listen: false).teams;
    //print("teams in schedscreenstate=" + teams.toString());
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: CustomColors.firebaseNavy,
                title: Text(
                  "Match Schedule",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                bottom: const TabBar(
                  indicatorColor: Colors.white70,
                  tabs: [
                    Tab(
                      child: Text("Upcoming Matches"),
                    ),
                    Tab(
                      child: Text("Matches History"),
                    )
                  ],
                ),
                actions: [
                  Icon(
                    Icons.filter,
                    color: Colors.white60,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
                centerTitle: true,
              ),
              body: Material(
                color: CustomColors.firebaseNavy,
                child: Container(
                  child: TabBarView(
                    children: [
                      ListView.builder(
                        itemCount: upcomingmatches.length,
                        itemBuilder: (BuildContext context, int index) {
                          return UpcomingMatchCard(
                              upcomingmatches[index], teams);
                        },
                      ),
                      ListView.builder(
                        itemCount: completedmatches.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CompletedMatchCard(
                              completedmatches[index], teams);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

class UpcomingMatchCard extends StatelessWidget {
  final Match match;
  final List<Team> teams;
  UpcomingMatchCard(this.match, this.teams);

  @override
  Widget build(BuildContext context) {
    // print("teams=" + teams.toString());
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MatchDetails(match.matchId.toString())),
        );
      },
      child: Container(
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
            leading: Column(
              children: [
                CircleAvatar(
                  minRadius: 25,
                  maxRadius: 25,
                  child: Image.network(
                    "https://upload.wikimedia.org/wikipedia/en/thumb/2/2b/Chennai_Super_Kings_Logo.svg/1200px-Chennai_Super_Kings_Logo.svg.png",
                  ),
                ),
              ],
            ),
            trailing: Column(
              children: [
                CircleAvatar(
                  minRadius: 25,
                  maxRadius: 25,
                  child: Image.network(
                    "https://upload.wikimedia.org/wikipedia/en/thumb/2/2b/Chennai_Super_Kings_Logo.svg/1200px-Chennai_Super_Kings_Logo.svg.png",
                  ),
                ),
              ],
            ),
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
                Text(
                  teams[int.parse(match.teamId1)].teamName +
                      "   Vs   " +
                      teams[int.parse(match.teamId2)].teamName,
                  style: TextStyle(
                      color: Colors.white60,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
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
          )),
    );
  }
}

class CompletedMatchCard extends StatelessWidget {
  final Match match;
  final List<Team> teams;
  CompletedMatchCard(this.match, this.teams);

  @override
  Widget build(BuildContext context) {
    // print("teams=" + teams.toString());
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MatchDetails(match.matchId.toString())),
        );
      },
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.blueAccent,
            ),
            color: CustomColors.taskez1,
          ),
          margin: EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 0),
          child: ListTile(
            contentPadding:
                EdgeInsets.only(top: 25, bottom: 25, right: 15, left: 15),
            leading: Column(
              children: [
                CircleAvatar(
                  minRadius: 25,
                  maxRadius: 25,
                  child: Image.network(
                    "https://upload.wikimedia.org/wikipedia/en/thumb/2/2b/Chennai_Super_Kings_Logo.svg/1200px-Chennai_Super_Kings_Logo.svg.png",
                  ),
                ),
              ],
            ),
            trailing: Column(
              children: [
                CircleAvatar(
                  minRadius: 25,
                  maxRadius: 25,
                  child: Image.network(
                    "https://upload.wikimedia.org/wikipedia/en/thumb/2/2b/Chennai_Super_Kings_Logo.svg/1200px-Chennai_Super_Kings_Logo.svg.png",
                  ),
                ),
              ],
            ),
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
                Text(
                  teams[int.parse(match.teamId1)].teamName +
                      "   Vs   " +
                      teams[int.parse(match.teamId2)].teamName,
                  style: TextStyle(
                      color: Colors.white60,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Divider(
                  height: 20,
                  color: Colors.white,
                ),
                (match.points![match.teamId1] == match.points![match.teamId2])
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
          )),
    );
  }
}
