import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/screens/admin/admin_dashboard.dart';
import 'package:arcadia/screens/admin/auction_details.dart';
import 'package:arcadia/screens/admin/auction_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminMainPage extends StatefulWidget {
  static const routeName = '\auction-overview';
  @override
  _AdminMainPageState createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  int _currentIndex = 0;
  List<BottomNavigationBarItem> _item = [
    BottomNavigationBarItem(
        icon: Icon(Icons.edit_attributes),
        label: "DashBoard",
        backgroundColor: Colors.black),
    BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Auction",
        backgroundColor: Colors.black),
    BottomNavigationBarItem(
        icon: Icon(Icons.query_stats_outlined),
        label: "Status",
        backgroundColor: Colors.black),
  ];

  static List<Widget> _tabs = <Widget>[
    AdminDashboard(),
    AuctionHome(),
    AuctionDetails(),
  ];

  void _onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primaryColor,
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
