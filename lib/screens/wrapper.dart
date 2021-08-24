import 'package:arcadia/provider/auth.dart';
import 'package:arcadia/provider/matches.dart';
import 'package:arcadia/screens/Auction/auction_overview.dart';
import 'package:arcadia/screens/Player/formPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'Player/PlayerScreens/player_dashboard.dart';
import '../provider/match.dart';

class Wrapper extends StatefulWidget {
  static const routeName = '/wrapper';

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool isAdmin = false;
  bool isData = false;
  bool isLoading = true;

  void initiate() async {
    var uid = Auth.uid;
    await FirebaseFirestore.instance.collection('Player').doc(uid).get().then(
      (DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
        print('testing -- match model');
        Provider.of<Matches>(context, listen: false)
            .addMatches(
              Match(
                isCompleted: false,
                matchId: '1',
                matchTime: DateTime.now(),
                teamId1: '5',
                teamId2: '6',
                mvpId: '0WrQ52PM2zMakLXoa6XJRS0j1wQ2',
                roundDiff: 3,
                roundsWon: {
                  '5':15,
                  '6':16
                },
                points: {
                  '5':0,
                  '6':2
                },
                
              ),
            )
            .then(
              (value) =>
                  print(Provider.of<Matches>(context, listen: false).matches),
            );

        if (documentSnapshot.exists) {
          setState(() {
            isData = true;
            isAdmin = documentSnapshot.data()!['isAdmin'];
          });
        }
        setState(() {
          isLoading = false;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    initiate();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (isData) {
      return isAdmin ? AuctionOverview() : PlayerDashBoard();
    } else {
      return PlayerForm();
    }
  }
}
