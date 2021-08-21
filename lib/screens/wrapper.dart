import 'package:arcadia/provider/auth.dart';
import 'package:arcadia/screens/auction_overview.dart';
import 'package:arcadia/screens/formPage.dart';
import 'package:arcadia/screens/player_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  static const routeName = '/wrapper';

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool isAdmin = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  static var snapShot;
  static String? uid;

void _getsnapShot()async{
  snapShot =
            await FirebaseFirestore.instance.collection('Player').doc(uid).get();
}

  @override
  void initState()  {
    super.initState();
    _getsnapShot();
    uid = auth.currentUser!.uid.toString();
    FirebaseFirestore.instance.collection('Player').doc(uid).get().then(
      (value) {
        setState(() {
          isAdmin = value.data()!['isAdmin'];
        });
        print('isadmin : ' +
            isAdmin.toString() +
            '\n data : ' +
            value.toString());
      },
    );
  }

  @override
  Widget build(BuildContext context)  {
    // snapShot =
    //     await FirebaseFirestore.instance.collection('Player').doc(uid).get();
    return (isAdmin)
        ? AuctionOverview()
        : (snapShot == null || !snapShot.exists)
            ? PlayerForm()
            : PlayerDashBoard();
  }
}
