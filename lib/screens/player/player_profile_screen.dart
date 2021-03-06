import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/enums/category.dart';
import 'package:arcadia/enums/weapons.dart';
import 'package:arcadia/models/models.dart';
import 'package:arcadia/provider/provider.dart';
import 'package:arcadia/screens/onboarding/signin_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerProfileScreen extends StatefulWidget {
  static const routeName = '/profile';
  const PlayerProfileScreen({Key? key}) : super(key: key);

  @override
  _PlayerProfileScreenState createState() => _PlayerProfileScreenState();
}

class _PlayerProfileScreenState extends State<PlayerProfileScreen> {
  bool _isInit = true;
  bool _isLoading = true;

  final User? auth = FirebaseAuth.instance.currentUser;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<Players>(context, listen: false)
          .fetchAndSetPlayers()
          .then((value) {
        currPlayer = Provider.of<Players>(context, listen: false).getPlayer(
          Auth.uid!,
        );
        setState(() {
          _isLoading = false;
          // print(currPlayer);
        });
      });
    }
    _isInit = false;
  }

  Player? currPlayer;

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

  String getGunImage(Weapons weapon) {
    return 'assets/guns/${weapon.toString().split('.').last}.png';
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: CustomColors.primaryColor,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text('Player Proflie'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  // mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: double.infinity,
                      color: CustomColors.secondaryColor,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 30),
                            child: CircleAvatar(
                              minRadius: 90,
                              maxRadius: 90,
                              backgroundColor:
                                  getCategoryColor(currPlayer!.playerCategory),
                              child: FutureBuilder(
                                future:
                                    Provider.of<Players>(context, listen: false)
                                        .getImageUrl(currPlayer!.uid),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return CircleAvatar(
                                      minRadius: 80,
                                      maxRadius: 80,
                                      backgroundColor: Colors.greenAccent,
                                      foregroundColor: Colors.white54,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        snapshot.data.toString(),
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Icon(
                                        Icons.image_not_supported_sharp);
                                  } else {
                                    return CircleAvatar(
                                      minRadius: 80,
                                      maxRadius: 80,
                                      backgroundColor: Colors.greenAccent,
                                      foregroundColor: Colors.white54,
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              currPlayer!.name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: getCategoryColor(
                                    currPlayer!.playerCategory),
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.white24,
                    ),
                    Container(
                      height: height * 0.65,
                      color: CustomColors.secondaryColor,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            width: width * 0.9,
                            height: height * 0.2,
                            decoration: BoxDecoration(
                              color: CustomColors.firebaseNavy,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'IGN    :   ${currPlayer!.inGameName}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xffEEEEEE),
                                    fontSize: 20,
                                    // fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  'Category   :   ${currPlayer!.playerCategory.toString().split('.').last}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: getCategoryColor(
                                        currPlayer!.playerCategory),
                                    fontSize: 20,
                                    // fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  'Hrs Played :   ${currPlayer!.hoursPlayed}',
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
                                      color: CustomColors.primaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  left: -15,
                                  child: Image.asset(
                                    getGunImage(currPlayer!.primaryWeapon),
                                    width: width * 0.6,
                                  ),
                                ),
                                Positioned(
                                  right: 40,
                                  top: 50,
                                  child: Text(
                                    'Primary Weapon',
                                    style: TextStyle(
                                      color: Colors.white,
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
                                      color: CustomColors.primaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  left: -15,
                                  child: Image.asset(
                                    getGunImage(currPlayer!.secondaryWeapon),
                                    width: width * 0.6,
                                  ),
                                ),
                                Positioned(
                                  right: 30,
                                  top: 50,
                                  child: Text(
                                    'Secondary Weapon',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton.icon(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                            ),
                            onPressed: () async {
                              await Provider.of<Auth>(context, listen: false)
                                  .signOut();
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return SignInScreen();
                              }), (route) => false);
                            },
                            icon: Icon(Icons.arrow_forward),
                            label: Text('Sign Out'),
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
