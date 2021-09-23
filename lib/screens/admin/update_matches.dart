import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/models/models.dart';
import 'package:arcadia/provider/provider.dart';
import 'package:arcadia/screens/admin/forms/add_match_form.dart';
import 'package:arcadia/screens/admin/widgets/match_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateMatches extends StatefulWidget {
  const UpdateMatches({Key? key}) : super(key: key);

  @override
  _UpdateMatchesState createState() => _UpdateMatchesState();
}

class _UpdateMatchesState extends State<UpdateMatches> {
  List<Match> matches = [];
  List<Team> teams = [];
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
              (value) => setState(() {
                _isLoading = false;
              }),
            );
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    teams = Provider.of<Teams>(context, listen: false).teams;
    matches = Provider.of<Matches>(context, listen: false).matches;
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Material(
            color: CustomColors.primaryColor,
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddMatchForm()),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(15, 20, 15, 5),
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.height / 14,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blueAccent,
                      ),
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: Colors.white),
                            Text(
                              "  Add Match",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ]),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Center(
                //   child: Text(
                //     "Matches",
                //     style: TextStyle(
                //         fontSize: 20,
                //         color: Colors.white54,
                //         fontWeight: FontWeight.bold),
                //   ),
                // ),
                ...matches.map((e) => MatchCard(e, teams)).toList(),
              ],
            ),
          );
  }
}
