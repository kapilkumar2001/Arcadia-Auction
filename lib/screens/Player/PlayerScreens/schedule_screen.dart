import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/provider/matches.dart';
import 'package:arcadia/provider/match.dart';
import 'package:arcadia/provider/team.dart';
import 'package:arcadia/provider/teams.dart';
import 'package:arcadia/screens/Player/PlayerScreens/match_details.dart';
import 'package:flutter/material.dart';
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
  int currindex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<Matches>(context, listen: false)
          .fetchAndSetMatches()
          .then((value) {
        Provider.of<Teams>(context, listen: false)
            .fetchAndSetTeams()
            .then((value) => setState(
                  () {
                    _isLoading = false;
                  },
                ));
      });
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
                      SingleChildScrollView(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: upcomingmatches.length,
                            itemBuilder: (BuildContext context, int index) {
                              return MatchCard(upcomingmatches[index], teams);
                            },
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: completedmatches.length,
                            itemBuilder: (BuildContext context, int index) {
                              return MatchCard(completedmatches[index], teams);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

class MatchCard extends StatefulWidget {
  final Match match;
  List<Team> teams;
  MatchCard(this.match, this.teams);

  @override
  _MatchCardState createState() => _MatchCardState();
}

class _MatchCardState extends State<MatchCard> {
  @override
  Widget build(BuildContext context) {
    // print("teams=" + widget.teams.toString());
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MatchDetails()),
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
                      "https://upload.wikimedia.org/wikipedia/en/thumb/2/2b/Chennai_Super_Kings_Logo.svg/1200px-Chennai_Super_Kings_Logo.svg.png"),
                ),
              ],
            ),
            trailing: Column(
              children: [
                CircleAvatar(
                  minRadius: 25,
                  maxRadius: 25,
                  child: Image.network(
                      "https://upload.wikimedia.org/wikipedia/en/thumb/2/2b/Chennai_Super_Kings_Logo.svg/1200px-Chennai_Super_Kings_Logo.svg.png"),
                ),
              ],
            ),
            title: Center(
              child: Column(children: [
                Text(
                  "Match " + widget.match.matchId,
                  style: TextStyle(color: Colors.white60),
                ),
                Text(
                  widget.teams[int.parse(widget.match.teamId1)].teamName +
                      " Vs " +
                      widget.teams[int.parse(widget.match.teamId2)].teamName,
                  style: TextStyle(color: Colors.white60),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "On " +
                      widget.match.matchTime.toLocal().day.toString() +
                      "/" +
                      widget.match.matchTime.toLocal().month.toString() +
                      "/" +
                      widget.match.matchTime.toLocal().year.toString() +
                      " at " +
                      widget.match.matchTime.hour.toString() +
                      ":" +
                      widget.match.matchTime.toLocal().minute.toString(),
                  style: TextStyle(color: Colors.white60),
                ),
              ]),
            ),
          )),
    );
  }
}
