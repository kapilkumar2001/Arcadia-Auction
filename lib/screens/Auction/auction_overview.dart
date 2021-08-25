import 'package:arcadia/screens/Auction/auction_details.dart';
import 'package:arcadia/screens/Auction/auction_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuctionOverview extends StatefulWidget {
  static const routeName = '\auction-overview';
  @override
  _AuctionOverviewState createState() => _AuctionOverviewState();
}

class _AuctionOverviewState extends State<AuctionOverview> {
  int _currentIndex = 0;
  List<BottomNavigationBarItem> _item = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        label: "Home",
        backgroundColor: Colors.black),
    BottomNavigationBarItem(
        icon: Icon(Icons.query_stats_outlined),
        label: "Status",
        backgroundColor: Colors.black),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.person),
        label: "Profile",
        backgroundColor: Colors.black),
  ];

  static List<Widget> _tabs = <Widget>[
    AuctionHome(),
    AuctionDetails(),
    Center(
      child: Text('profile'),
    )
  ];

  void _onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        backgroundColor: Colors.white38,
        iconSize: 30,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: _item,
        type: BottomNavigationBarType.shifting,
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.white38,
        onTap: _onTapped,
      ),
      body: _tabs[_currentIndex],
    );
  }
}
