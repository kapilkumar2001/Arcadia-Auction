import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/provider/team.dart';
import 'package:arcadia/provider/teams.dart';
import 'package:arcadia/screens/Auction/widgets/team_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateTeams extends StatefulWidget {
  const UpdateTeams({Key? key}) : super(key: key);

  @override
  _UpdateTeamsState createState() => _UpdateTeamsState();
}

class _UpdateTeamsState extends State<UpdateTeams> {
  List<Team> teams = [];
  bool _isInit = true;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<Teams>(context, listen: false).fetchAndSetTeams().then(
            (value) => setState(() {
              _isLoading = false;
            }),
          );
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    teams = Provider.of<Teams>(context, listen: false).teams;
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Material(
            color: CustomColors.primaryColor,
            child: ListView.builder(
              itemCount: teams.length,
              itemBuilder: (BuildContext context, int index) {
                return TeamCard(teams[index]);
              },
            ),
          );
  }
}
