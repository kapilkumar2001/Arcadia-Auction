import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/provider/matches.dart';
import 'package:arcadia/provider/player.dart';
import 'package:arcadia/provider/players.dart';
import 'package:arcadia/provider/team.dart';
import 'package:arcadia/provider/teams.dart';
import 'package:arcadia/screens/Auction/admin_dashboard.dart';
import 'package:arcadia/screens/Auction/auction_overview.dart';
import 'package:arcadia/widgets/blue_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arcadia/provider/match.dart';

class UpdateMatchForm extends StatefulWidget {
  final Match match;
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
        Provider.of<Teams>(context, listen: false)
            .fetchAndSetTeams()
            .then((value) => setState(() {
                  _isLoading = false;
                }));
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
                color: CustomColors.primaryColor,
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
                            // Text(
                            //   "Select Winner",
                            //   style: TextStyle(fontSize: 20),
                            // ),
                            // SizedBox(
                            //   height: 2,
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.all(10),
                            //   child: DropdownButton<String>(
                            //     value: _winner,
                            //     onChanged: (newVal) {
                            //       setState(() {
                            //         _winner = newVal!;
                            //       });
                            //     },
                            //     items: [
                            //       DropdownMenuItem(
                            //         value: widget.match.teamId1.toString(),
                            //         child: Text(
                            //             '${Provider.of<Teams>(context, listen: false).getTeam(widget.match.teamId1).teamName}'),
                            //       ),
                            //       DropdownMenuItem(
                            //         value: widget.match.teamId2.toString(),
                            //         child: Text(
                            //             '${Provider.of<Teams>(context, listen: false).getTeam(widget.match.teamId2).teamName}'),
                            //       ),
                            //       DropdownMenuItem(
                            //         value: '-1',
                            //         child: Text('draw'),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              controller: rounddiffController,
                              decoration: InputDecoration(
                                hintText: "Rounds Difference",
                                labelText: "Rounds Difference",
                                filled: true,
                                fillColor: CustomColors.firebaseGrey,
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14,
                                    color: Colors.blueAccent),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.blueAccent,
                                    width: 2.0,
                                  ),
                                ),
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
                            TextFormField(
                              controller: roundswon1Controller,
                              decoration: InputDecoration(
                                hintText: "RoundsWon",
                                labelText:
                                    "RoundsWon (${Provider.of<Teams>(context, listen: false).getTeam(widget.match.teamId1).teamName})",
                                filled: true,
                                fillColor: CustomColors.firebaseGrey,
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14,
                                    color: Colors.blueAccent),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.blueAccent,
                                    width: 2.0,
                                  ),
                                ),
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
                            TextFormField(
                              controller: roundswon2Controller,
                              decoration: InputDecoration(
                                hintText: "RoundsWon",
                                labelText:
                                    "RoundsWon (${Provider.of<Teams>(context, listen: false).getTeam(widget.match.teamId2).teamName})",
                                filled: true,
                                fillColor: CustomColors.firebaseGrey,
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14,
                                    color: Colors.blueAccent),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.blueAccent,
                                    width: 2.0,
                                  ),
                                ),
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
                            TextFormField(
                              controller: point1Controller,
                              decoration: InputDecoration(
                                hintText: "points",
                                labelText:
                                    "Points (${Provider.of<Teams>(context, listen: false).getTeam(widget.match.teamId1).teamName})",
                                filled: true,
                                fillColor: CustomColors.firebaseGrey,
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14,
                                    color: Colors.blueAccent),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.blueAccent,
                                    width: 2.0,
                                  ),
                                ),
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
                            TextFormField(
                              controller: point2Controller,
                              decoration: InputDecoration(
                                hintText: "points",
                                labelText:
                                    "Points (${Provider.of<Teams>(context, listen: false).getTeam(widget.match.teamId2).teamName})",
                                filled: true,
                                fillColor: CustomColors.firebaseGrey,
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14,
                                    color: Colors.blueAccent),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.blueAccent,
                                    width: 2.0,
                                  ),
                                ),
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
                              style: TextStyle(
                                  fontSize: 20, color: Colors.blueAccent),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: DropdownButton<String>(
                                value: _mvp,
                                focusColor: Colors.blueAccent,
                                iconDisabledColor: Colors.blueAccent,
                                iconEnabledColor: Colors.blueAccent,
                                onChanged: (newVal) {
                                  setState(() {
                                    _mvp = newVal!;
                                  });
                                },
                                items: [
                                  ...teams
                                      .firstWhere((e) =>
                                          e.teamUid == widget.match.teamId1)
                                      .playerUid
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e.toString(),
                                          child: Text(
                                            '${Provider.of<Players>(context, listen: false).getPlayer(e.toString()).name}',
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  ...teams
                                      .firstWhere((e) =>
                                          e.teamUid == widget.match.teamId2)
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
                              child: AnimatedContainer(
                                duration: Duration(seconds: 1),
                                width: MediaQuery.of(context).size.width / 2,
                                height: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
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
                                              AdminMainPage()));
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
