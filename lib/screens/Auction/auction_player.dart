import 'package:arcadia/enums/category.dart';
import 'package:arcadia/enums/player_status.dart';
import 'package:arcadia/provider/player.dart';
import 'package:flutter/material.dart';

class AuctionPlayer extends StatefulWidget {
  static const routeName = '/auction-player';
  const AuctionPlayer({Key? key}) : super(key: key);

  @override
  _AuctionPlayerState createState() => _AuctionPlayerState();
}

class _AuctionPlayerState extends State<AuctionPlayer> {
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
  String getGunImage(String weapon) {
    return 'assets/guns/$weapon.png';
  }

  @override
  void initState() {
    super.initState();
    _playerStatus = PlayerStatus.unassigned;
  }

  @override
  Widget build(BuildContext context) {
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
                      DropdownButton<PlayerStatus>(
                        items: <PlayerStatus>[
                          PlayerStatus.sold,
                          PlayerStatus.unsold,
                          PlayerStatus.unassigned,
                        ].map((PlayerStatus value) {
                          return DropdownMenuItem<PlayerStatus>(
                            value: _playerStatus,
                            child: new Text(value.toString().split('.').last),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            print('value is : $value');
                            _playerStatus = value!;
                          });
                        },
                      )
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
