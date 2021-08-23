import 'package:arcadia/provider/player.dart';
import 'package:arcadia/provider/players.dart';
import 'package:arcadia/provider/team.dart';
import 'package:arcadia/provider/teams.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuctionDetails extends StatefulWidget {
  static const routeName = '/auction-details';
  @override
  _AuctionDetailsState createState() => _AuctionDetailsState();
}

class _AuctionDetailsState extends State<AuctionDetails> {
  List<Team> teams = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<Teams>(context).fetchAndSetTeams();
  }
  //TODO: create UI
  @override
  Widget build(BuildContext context) {
    teams = Provider.of<Teams>(context, listen: false).teams;
    return Material(
      color: Colors.deepPurpleAccent,
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return TeamCard(teams[index]);
        },
      ),
    );
  }
}

class TeamCard extends StatelessWidget {
  final Team team;
  TeamCard(this.team);
  @override
  Widget build(BuildContext context) {
    //TODO: expansion tile
    return ExpansionTile(
      title: Text(team.teamName),
      children: [
        if (team.playerUid.isEmpty) Text('empty'),
        ...team.playerUid.map((e) {
          return PlayerTile(player: Provider.of<Players>(context).getPlayer(e));
        }).toList(),
      ],
    );
  }
}

class PlayerTile extends StatelessWidget {
  final Player player;

  const PlayerTile({required this.player});

  @override
  Widget build(BuildContext context) {
    return Text(player.name);
  }
}
