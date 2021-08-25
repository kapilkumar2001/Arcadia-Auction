import 'package:arcadia/provider/team.dart';
import 'package:flutter/material.dart';

class TeamDetails extends StatefulWidget {
  static const routeName = '/team-details';

  @override
  _TeamDetailsState createState() => _TeamDetailsState();
}

class _TeamDetailsState extends State<TeamDetails> {
  @override
  Widget build(BuildContext context) {
    Team team = ModalRoute.of(context)!.settings.arguments as Team;
    return Scaffold(
      
    );
  }
}
