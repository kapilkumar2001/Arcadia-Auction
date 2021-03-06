import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/enums/category.dart';
import 'package:arcadia/enums/player_status.dart';
import 'package:arcadia/enums/weapons.dart';
import 'package:arcadia/models/models.dart';
import 'package:arcadia/provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuctionPlayer extends StatefulWidget {
  static const routeName = '/auction-player';
  final currPlayer;
  const AuctionPlayer(this.currPlayer);

  @override
  _AuctionPlayerState createState() => _AuctionPlayerState();
}

class _AuctionPlayerState extends State<AuctionPlayer> {
  List<Team> teams = [];
  bool isInit = true;
  bool isLoading = true;
  String playerImage = '';
  String imageUrl =
      "https://pbs.twimg.com/profile_images/1372030169985163266/ceCabVlu.jpg";

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

    _playerStatus = PlayerStatus.unassigned;
  }

  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isInit) {
      await Provider.of<Teams>(context, listen: false).fetchAndSetTeams();
      playerImage = await Provider.of<Players>(context, listen: false)
          .getImageUrl(widget.currPlayer.uid);
      setState(() {
        _teams = Provider.of<Teams>(context, listen: false).teams[0].teamUid;
        isLoading = false;
      });
    }
    isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    teams = Provider.of<Teams>(context, listen: false).teams;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // final currPlayer = ModalRoute.of(context)!.settings.arguments as Player;
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: Color(0xffEEEEEE),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: height * 0.4,
                      color: CustomColors.secondaryColor,
                      child: Column(
                        children: [
                          Spacer(
                            flex: 3,
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            flex: 11,
                            child: CircleAvatar(
                              radius: 90,
                              backgroundColor: getCategoryColor(
                                  widget.currPlayer.playerCategory),
                              child: CachedNetworkImage(
                                imageUrl: playerImage,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  height: 160,
                                  width: 160,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: const EdgeInsets.only(top: 20, left: 20),
                            child: Text(
                              widget.currPlayer.name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: getCategoryColor(
                                    widget.currPlayer.playerCategory),
                                fontSize: 35,
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
                                  'IGN    :   ${widget.currPlayer.inGameName}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xffEEEEEE),
                                    fontSize: 20,
                                    // fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  'Category   :   ${widget.currPlayer.playerCategory.toString().split('.').last}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: getCategoryColor(
                                        widget.currPlayer.playerCategory),
                                    fontSize: 20,
                                    // fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  'Hrs Played :   ${widget.currPlayer.hoursPlayed}',
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
                                    getGunImage(
                                        widget.currPlayer.primaryWeapon),
                                    width: width * 0.6,
                                  ),
                                ),
                                Positioned(
                                  right: 40,
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
                                    getGunImage(
                                        widget.currPlayer.secondaryWeapon),
                                    width: width * 0.6,
                                  ),
                                ),
                                Positioned(
                                  right: 30,
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
                              items:
                                  PlayerStatus.values.map((PlayerStatus value) {
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
                                        //updating player
                                        var newPlayer =
                                            widget.currPlayer.copyWith(
                                          soldIn: int.parse(_soldIn.text),
                                          soldTo: _teams,
                                          playerStatus: _playerStatus,
                                        );
                                        await Provider.of<Players>(context,
                                                listen: false)
                                            .updatePlayer(newPlayer);

                                        // updating team
                                        int newnumPlayer = teams
                                            .firstWhere(
                                                (e) => e.teamUid == _teams)
                                            .numPlayer;
                                        int updatedcredits = ((teams
                                                .firstWhere(
                                                    (e) => e.teamUid == _teams)
                                                .credits) -
                                            (int.parse(_soldIn.text)));
                                        List<String> playersuid = [];
                                        int i;
                                        for (i = 0; i < newnumPlayer; i++) {
                                          playersuid.add(teams
                                              .firstWhere(
                                                  (e) => e.teamUid == _teams)
                                              .playerUid[i]);
                                        }
                                        playersuid.add(widget.currPlayer.uid);
                                        Team newTeam = teams
                                            .firstWhere(
                                                (e) => e.teamUid == _teams)
                                            .copyWith(
                                              playerUid: playersuid,
                                              numPlayer: newnumPlayer + 1,
                                              credits: updatedcredits,
                                            );
                                        await Provider.of<Teams>(context,
                                                listen: false)
                                            .updateTeam(newTeam);

                                        Player? nextPlayer =
                                            Provider.of<Players>(context,
                                                    listen: false)
                                                .getNextPlayer;
                                        if (nextPlayer != null) {
                                          Navigator.of(context).popAndPushNamed(
                                            AuctionPlayer.routeName,
                                            arguments: nextPlayer,
                                          );
                                        } else {
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'No more Players available, try reselling!!'),
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
                                var newPlayer = widget.currPlayer.copyWith(
                                  playerStatus: _playerStatus,
                                );
                                await Provider.of<Players>(context,
                                        listen: false)
                                    .updatePlayer(newPlayer);
                                Player? nextPlayer =
                                    Provider.of<Players>(context, listen: false)
                                        .getNextPlayer;
                                if (nextPlayer != null) {
                                  Navigator.of(context).popAndPushNamed(
                                    AuctionPlayer.routeName,
                                    arguments: nextPlayer,
                                  );
                                } else {
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'No Players available, try reselling!!'),
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
                                var newPlayer = widget.currPlayer.copyWith(
                                  playerStatus: _playerStatus,
                                );
                                await Provider.of<Players>(context,
                                        listen: false)
                                    .updatePlayer(newPlayer);
                                Player? nextPlayer =
                                    Provider.of<Players>(context, listen: false)
                                        .getNextPlayer;
                                if (nextPlayer != null) {
                                  Navigator.of(context).popAndPushNamed(
                                    AuctionPlayer.routeName,
                                    arguments: nextPlayer,
                                  );
                                } else {
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'No Players available, try reselling!!'),
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
          );
  }
}
