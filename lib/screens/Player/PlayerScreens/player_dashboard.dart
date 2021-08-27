import 'package:arcadia/screens/Player/PlayerScreens/schedule_screen.dart';
import 'package:arcadia/screens/Player/PlayerScreens/team_standings.dart';
import 'package:arcadia/screens/Player/PlayerScreens/home_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
    // PlayerProfileScreen(),
    PlayerHomeScreen(),
    TeamStandings(),
    ScheduleScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Notification"),
              content: Text(event.notification!.body!),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 30,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.shifting,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
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
    );
  }
}
