import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/provider/matches.dart';
import 'package:arcadia/provider/match.dart';
import 'package:arcadia/provider/team.dart';
import 'package:arcadia/provider/teams.dart';
import 'package:arcadia/screens/Auction/widgets/match_card.dart';
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
            child: ListView.builder(
              itemCount: matches.length,
              itemBuilder: (BuildContext context, int index) {
                return MatchCard(matches[index], teams);
              },
            ),
          );
  }
}
