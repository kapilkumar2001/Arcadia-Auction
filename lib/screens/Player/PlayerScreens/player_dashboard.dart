import 'package:arcadia/screens/Player/PlayerScreens/auction_results.dart';
import 'package:arcadia/screens/Player/PlayerScreens/player_profile_screen.dart';
import 'package:arcadia/screens/Player/PlayerScreens/schedule_screen.dart';
import 'package:arcadia/screens/Player/PlayerScreens/team_standings.dart';
import 'package:arcadia/screens/Player/PlayerScreens/update_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayerDashBoard extends StatefulWidget {
  const PlayerDashBoard({Key? key}) : super(key: key);

  static const routeName = '\playerDashBoard';

  @override
  _PlayerDashBoardState createState() => _PlayerDashBoardState();
}

class _PlayerDashBoardState extends State<PlayerDashBoard> {

  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    PlayerProfileScreen(),
    UpdateScreen(),
    AuctionResults(),
    TeamStandings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            iconSize: 30,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.shifting,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.profile_circled),
                  label: 'Profile',
                  backgroundColor: Colors.black),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_alert),
                  label: 'Updates',
                  backgroundColor: Colors.black),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.app_badge_fill),
                  label: 'Standings',
                  backgroundColor: Colors.black),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.table_badge_more_fill),
                  label: 'Schedule',
                  backgroundColor: Colors.black),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            onTap: _onItemTapped,
            backgroundColor: Colors.white38,
          ),
        ),
      ),
    );
  }
}
