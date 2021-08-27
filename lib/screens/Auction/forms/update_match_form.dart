import 'dart:io';
import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/provider/matches.dart';
import 'package:arcadia/provider/player.dart';
import 'package:arcadia/provider/players.dart';
import 'package:arcadia/provider/team.dart';
import 'package:arcadia/provider/teams.dart';
import 'package:arcadia/screens/Auction/admin_dashboard.dart';
import 'package:arcadia/widgets/blue_box.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:arcadia/provider/match.dart';

class UpdateMatchForm extends StatefulWidget {
  Match match;
  UpdateMatchForm(this.match);

  @override
  UpdateMatchFormstate createState() => UpdateMatchFormstate();
}

class UpdateMatchFormstate extends State<UpdateMatchForm> {
  List<Team> teams = [];
  String _winner = '-1';
  String _mvp = '-2';
  List<Player> players = [];
  final point1Controller = new TextEditingController();
  final point2Controller = new TextEditingController();
  final rounddiffController = new TextEditingController();
  final roundswon1Controller = new TextEditingController();
  final roundswon2Controller = new TextEditingController();

  bool _isInit = true;
  bool _isLoading = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<Players>(context, listen: false)
          .fetchAndSetPlayers()
          .then((value) {
        Provider.of<Teams>(context, listen: false).fetchAndSetTeams();
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    teams = Provider.of<Teams>(context, listen: false).teams;
    players = Provider.of<Players>(context, listen: false).allPlayers;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Match",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 24),
                alignment: Alignment.topCenter,
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 32.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Select Winner",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: DropdownButton<String>(
                                value: _winner,
                                onChanged: (newVal) {
                                  setState(() {
                                    _winner = newVal!;
                                  });
                                },
                                items: [
                                  DropdownMenuItem(
                                    value: widget.match.teamId1.toString(),
                                    child: Text(
                                        '${Provider.of<Teams>(context, listen: false).getTeam(int.parse(widget.match.teamId1)).teamName}'),
                                  ),
                                  DropdownMenuItem(
                                    value: widget.match.teamId2.toString(),
                                    child: Text(
                                        '${Provider.of<Teams>(context, listen: false).getTeam(int.parse(widget.match.teamId2)).teamName}'),
                                  ),
                                  DropdownMenuItem(
                                    value: '-1',
                                    child: Text('draw'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              controller: rounddiffController,
                              decoration: InputDecoration(
                                hintText: "Rounds Difference",
                                labelText: "Rounds Difference",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Cannot be empty";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              controller: roundswon1Controller,
                              decoration: InputDecoration(
                                hintText: "RoundsWon",
                                labelText:
                                    "RoundsWon (${Provider.of<Teams>(context, listen: false).getTeam(int.parse(widget.match.teamId1)).teamName})",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Cannot be empty";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              controller: roundswon2Controller,
                              decoration: InputDecoration(
                                hintText: "RoundsWon",
                                labelText:
                                    "RoundsWon (${Provider.of<Teams>(context, listen: false).getTeam(int.parse(widget.match.teamId2)).teamName})",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Cannot be empty";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              controller: point1Controller,
                              decoration: InputDecoration(
                                hintText: "points",
                                labelText:
                                    "Points (${Provider.of<Teams>(context, listen: false).getTeam(int.parse(widget.match.teamId1)).teamName})",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Cannot be empty";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              controller: point2Controller,
                              decoration: InputDecoration(
                                hintText: "points",
                                labelText:
                                    "Points (${Provider.of<Teams>(context, listen: false).getTeam(int.parse(widget.match.teamId2)).teamName})",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Cannot be empty";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Select MVP",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: DropdownButton<String>(
                                value: _mvp,
                                onChanged: (newVal) {
                                  setState(() {
                                    _mvp = newVal!;
                                  });
                                },
                                items: [
                                  ...teams[int.parse(widget.match.teamId1)]
                                      .playerUid
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e.toString(),
                                          child: Text(
                                              '${Provider.of<Players>(context, listen: false).getPlayer(e.toString()).name}'),
                                        ),
                                      )
                                      .toList(),
                                  ...teams[int.parse(widget.match.teamId2)]
                                      .playerUid
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e.toString(),
                                          child: Text(
                                              '${Provider.of<Players>(context, listen: false).getPlayer(e.toString()).name}'),
                                        ),
                                      )
                                      .toList(),
                                  DropdownMenuItem(
                                    value: '-2',
                                    child: Text('none'),
                                  ),
                                ],
                              ),
                            ),

                            // mvp id
                            SizedBox(
                              height: 40.0,
                            ),
                            GestureDetector(
                              child: blueButton(
                                  context: context,
                                  label: "Save",
                                  buttonWidth:
                                      MediaQuery.of(context).size.width / 2),
                              onTap: () async {
                                Match m = widget.match.copyWith(
                                    mvpId: _mvp,
                                    isCompleted: true,
                                    points: {
                                      '${widget.match.teamId1.toString()}':
                                          int.parse(point1Controller.text),
                                      '${widget.match.teamId2.toString()}':
                                          int.parse(point2Controller.text)
                                    },
                                    roundsWon: {
                                      '${widget.match.teamId1.toString()}':
                                          int.parse(roundswon1Controller.text),
                                      '${widget.match.teamId2.toString()}':
                                          int.parse(roundswon2Controller.text)
                                    },
                                    roundDiff:
                                        int.parse(rounddiffController.text));
                                await Provider.of<Matches>(context,
                                        listen: false)
                                    .updateMatches(m);
                                if (_formKey.currentState!.validate()) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AdminDashboard()));
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
