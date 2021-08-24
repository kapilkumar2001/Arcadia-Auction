import 'package:arcadia/enums/category.dart';
import 'package:arcadia/enums/player_status.dart';
import 'package:arcadia/enums/weapons.dart';
import 'package:arcadia/provider/player.dart';
import 'package:arcadia/provider/players.dart';
import 'package:arcadia/provider/team.dart';
import 'package:arcadia/provider/teams.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuctionPlayerResell extends StatefulWidget {
  static const routeName = '/auction-player-resell';
  const AuctionPlayerResell({Key? key}) : super(key: key);

  @override
  _AuctionPlayerState createState() => _AuctionPlayerState();
}

class _AuctionPlayerState extends State<AuctionPlayerResell> {
  List<Team> teams = [];


  Color getCategoryColor(PlayerCategory cat) {
    switch (cat) {
      case PlayerCategory.gold:
        return Color(0xffd4af37);
      case PlayerCategory.silver:
        return Color(0xffc0c0c0);
      case PlayerCategory.bronze:
        return Color(0xffcd7f32);
      default:
        return Colors.white24;
    }
  }

  late PlayerStatus _playerStatus;
  late String _teams;
  TextEditingController _soldIn = TextEditingController();
  String getGunImage(Weapons weapon) {
    return 'assets/guns/${weapon.toString().split('.').last}.png';
  }

  @override
  void initState() {
    super.initState();
    _teams = '0';
    _playerStatus = PlayerStatus.unassigned;
  }

  @override
  Widget build(BuildContext context) {
    teams = Provider.of<Teams>(context, listen: false).teams;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final currPlayer = ModalRoute.of(context)!.settings.arguments as Player;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffEEEEEE),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  color: Color(0xff787A91),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: CircleAvatar(
                          minRadius: 90,
                          backgroundColor:
                              getCategoryColor(currPlayer.playerCategory),
                          child: CircleAvatar(
                            minRadius: 80,
                            backgroundColor: Colors.greenAccent,
                            foregroundColor: Colors.white54,
                            child: IconButton(
                              icon: Icon(Icons.add_a_photo_rounded),
                              onPressed: () {
                                // this._getImage();
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          currPlayer.name,
                          style: TextStyle(
                            color: getCategoryColor(currPlayer.playerCategory),
                            fontSize: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Column(
                    children: [
                      Container(
                        width: width * 0.9,
                        height: height * 0.2,
                        decoration: BoxDecoration(
                          color: Color(0xff141E61),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'IGN    :   ${currPlayer.inGameName}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xffEEEEEE),
                                fontSize: 20,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              'Category   :   ${currPlayer.playerCategory.toString().split('.').last}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    getCategoryColor(currPlayer.playerCategory),
                                fontSize: 20,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              'Hrs Played :   ${currPlayer.hoursPlayed}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xffEEEEEE),
                                fontSize: 20,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        height: height * 0.15,
                        child: Stack(
                          children: [
                            Positioned(
                              width: width * 0.9,
                              height: height * 0.1,
                              top: 20,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xff5089C6),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              left: -15,
                              child: Image.asset(
                                getGunImage(currPlayer.primaryWeapon),
                                width: width * 0.6,
                              ),
                            ),
                            Positioned(
                              right: 20,
                              top: 50,
                              child: Text(
                                'Primary Weapon',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        height: height * 0.15,
                        child: Stack(
                          children: [
                            Positioned(
                              width: width * 0.9,
                              height: height * 0.1,
                              top: 20,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xff5089C6),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              left: -15,
                              child: Image.asset(
                                getGunImage(currPlayer.secondaryWeapon),
                                width: width * 0.6,
                              ),
                            ),
                            Positioned(
                              right: 15,
                              top: 50,
                              child: Text(
                                'Secondary Weapon',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 28,
                        decoration: BoxDecoration(
                          color: Colors.white54,
                          border: Border.all(
                            color: Colors.grey,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: DropdownButton<PlayerStatus>(
                          underline: Container(color: Colors.transparent),
                          value: _playerStatus,
                          items: <PlayerStatus>[
                            PlayerStatus.sold,
                            PlayerStatus.unsold,
                            PlayerStatus.resell,
                            PlayerStatus.unassigned,
                          ].map((PlayerStatus value) {
                            return DropdownMenuItem<PlayerStatus>(
                              value: value,
                              child: Text(value.toString().split('.').last),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              // print('value is : $value');
                              _playerStatus = value!;
                            });
                          },
                          // hint: Text(_playerStatus.toString().split('.').last),
                        ),
                      ),
                      if (_playerStatus == PlayerStatus.sold)
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: DropdownButton<String>(
                                  value: _teams,
                                  onChanged: (newVal) {
                                    setState(() {
                                      _teams = newVal!;
                                    });
                                  },
                                  items: [
                                    ...teams
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e.teamUid.toString(),
                                            child: Text('${e.teamName}'),
                                          ),
                                        )
                                        .toList(),
                                  ],
                                ),
                              ),
                              Container(
                                height: height * 0.2,
                                padding: EdgeInsets.all(20),
                                child: TextField(
                                  controller: _soldIn,
                                  decoration: InputDecoration(
                                    labelText: 'Sold In',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    // updating player
                                    var newPlayer = currPlayer.copyWith(
                                      soldIn: int.parse(_soldIn.text),
                                      soldTo: _teams,
                                      playerStatus: _playerStatus,
                                    );
                                    await Provider.of<Players>(context,
                                            listen: false)
                                        .updatePlayer(newPlayer);

                                    // updating team
                                    int newnumPlayer =
                                        teams[int.parse(_teams)].numPlayer;
                                    int updatedcredits =
                                        ((teams[int.parse(_teams)].credits) -
                                            (int.parse(_soldIn.text)));
                                    List<String> playersuid = [];
                                    int i;
                                    for (i = 0; i < newnumPlayer; i++) {
                                      playersuid.add(teams[int.parse(_teams)]
                                          .playerUid[i]);
                                    }
                                    playersuid.add(currPlayer.uid);
                                    Team newTeam =
                                        teams[int.parse(_teams)].copyWith(
                                      playerUid: playersuid,
                                      numPlayer: newnumPlayer + 1,
                                      credits: updatedcredits,
                                    );
                                    await Provider.of<Teams>(context,
                                            listen: false)
                                        .updateTeam(newTeam);

                                    Player? nextPlayer = Provider.of<Players>(
                                            context,
                                            listen: false)
                                        .getNextResellPlayer;
                                    if (nextPlayer != null) {
                                      Navigator.of(context).popAndPushNamed(
                                        AuctionPlayerResell.routeName,
                                        arguments: nextPlayer,
                                      );
                                    } else {
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'All Players reselled or sold'),
                                        ),
                                      );
                                    }
                                  },
                                  icon: Icon(Icons.navigate_next),
                                  label: Text('Next Player'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (_playerStatus == PlayerStatus.unsold)
                        ElevatedButton.icon(
                          onPressed: () async {
                            var newPlayer = currPlayer.copyWith(
                              playerStatus: _playerStatus,
                            );
                            await Provider.of<Players>(context, listen: false)
                                .updatePlayer(newPlayer);
                            Player? nextPlayer =
                                Provider.of<Players>(context, listen: false)
                                    .getNextResellPlayer;
                            if (nextPlayer != null) {
                              Navigator.of(context).popAndPushNamed(
                                AuctionPlayerResell.routeName,
                                arguments: nextPlayer,
                              );
                            } else {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('All Players reselled or sold'),
                                ),
                              );
                            }
                          },
                          icon: Icon(Icons.navigate_next),
                          label: Text('Next Player'),
                        ),
                      if (_playerStatus == PlayerStatus.resell)
                        ElevatedButton.icon(
                          onPressed: () async {
                            var newPlayer = currPlayer.copyWith(
                              playerStatus: _playerStatus,
                            );
                            await Provider.of<Players>(context, listen: false)
                                .updatePlayer(newPlayer);
                            Player? nextPlayer =
                                Provider.of<Players>(context, listen: false)
                                    .getNextResellPlayer;
                            if (nextPlayer != null) {
                              Navigator.of(context).popAndPushNamed(
                                AuctionPlayerResell.routeName,
                                arguments: nextPlayer,
                              );
                            } else {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('All Players reselled or sold'),
                                ),
                              );
                            }
                          },
                          icon: Icon(Icons.navigate_next),
                          label: Text('Next Player'),
                        ),
                    ],
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
