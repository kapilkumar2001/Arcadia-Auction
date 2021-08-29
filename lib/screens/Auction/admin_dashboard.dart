import 'package:arcadia/constants/app_theme.dart';
import 'package:arcadia/screens/Auction/update_announcements.dart';
import 'package:arcadia/screens/Auction/update_matches.dart';
import 'package:arcadia/screens/Auction/update_teams.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard>
    with SingleTickerProviderStateMixin {
  // late TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
         backgroundColor: CustomColors.primaryColor,
        appBar: AppBar(
          title: Text(
            "Admin DashBoard",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.white70,
            //  controller: _tabController,
            tabs: <Tab>[
              Tab(
                child: Text("Announcement"),
              ),
              Tab(
                child: Text("Matches"),
              ),
              Tab(
                child: Text("Teams"),
              )
            ],
          ),
          centerTitle: true,
        ),
        body: Material(
            color: CustomColors.firebaseNavy,
            child: Container(
                child: TabBarView(
              children: [
                UpdateAnnouncements(),
                UpdateMatches(),
                UpdateTeams(),
              ],
            ))),
      ),
    );
  }
}
