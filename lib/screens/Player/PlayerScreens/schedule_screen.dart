import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/provider/matches.dart';
import 'package:arcadia/provider/players.dart';
import 'package:arcadia/provider/team.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScheduleScreen extends StatefulWidget {
  static const routeName = '/schedule-screen';
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List<Match> upcomingMatches = [];
  List<Match> completedMatches = [];
  bool _isInit = true;
  bool _isLoading = true;
  int currindex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<Matches>(context, listen: false).fetchAndSetMatches().then(
            (value) => setState(
              () {
                _isLoading = false;
              },
            ),
          );
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    upcomingMatches = Provider.of<Matches>(context, listen: false)
        .upcomingMatches
        .cast<Match>()
        .toList();
    completedMatches = Provider.of<Matches>(context, listen: false)
        .completedMatches
        .cast<Match>()
        .toList();
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: CustomColors.firebaseNavy,
              title: Text(
                "Match Schedule",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              centerTitle: true,
            ),
            body: Material(
              color: CustomColors.firebaseNavy,
              child: Container(
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currindex = 0;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: CustomColors.firebaseNavy,
                            border: Border.all(
                              color: Colors.blueAccent,
                            ),
                          ),
                          margin: EdgeInsets.only(
                              left: 10, right: 0, top: 10, bottom: 10),
                          child: Text(
                            "Upcoming Matches",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white54),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currindex = 1;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: CustomColors.firebaseNavy,
                            border: Border.all(
                              color: Colors.blueAccent,
                            ),
                          ),
                          margin: EdgeInsets.only(
                              left: 0, right: 10, top: 10, bottom: 10),
                          child: Text(
                            " Matches History ",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white54),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // child: (currindex == 0)
                  //     ? SingleChildScrollView(
                  //         child: Container(
                  //           child: ListView.builder(
                  //             itemCount: upcomingMatches.length,
                  //             itemBuilder: (BuildContext context, int index) {
                  //               return MatchCard(upcomingMatches[index]);
                  //             },
                  //           ),
                  //         ),
                  //       )
                  //     : SingleChildScrollView(
                  //         child: Container(
                  //           child: ListView.builder(
                  //             itemCount: completedMatches.length,
                  //             itemBuilder: (BuildContext context, int index) {
                  //               return MatchCard(completedMatches[index]);
                  //             },
                  //           ),
                  //         ),
                  //       ),
                ]),
              ),
            ),
          );
  }
}

class MatchCard extends StatefulWidget {
  final Match match;
  MatchCard(this.match);

  @override
  _MatchCardState createState() => _MatchCardState();
}

class _MatchCardState extends State<MatchCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        color: CustomColors.taskez1,
        margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: ListTile(
          title: Text("Kapil"),
          // leading: CircleAvatar(
          //     maxRadius: 10,
          //     minRadius: 10,
          //     child: Image.network(
          //         "https://upload.wikimedia.org/wikipedia/en/thumb/2/2b/Chennai_Super_Kings_Logo.svg/1200px-Chennai_Super_Kings_Logo.svg.png")),
        ));
  }
}
