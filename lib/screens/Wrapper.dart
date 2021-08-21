import 'package:arcadia/provider/auth.dart';
import 'package:arcadia/screens/auction_overview.dart';
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
  @override
  void initState() {
    super.initState();
    String uid = auth.currentUser!.uid.toString();
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
  Widget build(BuildContext context) {
    return isAdmin
        ? AuctionOverview()
        : Center(
            child: Scaffold(
              body: ElevatedButton.icon(
                onPressed: () async {
                  await Provider.of<Auth>(context, listen: false).signOut();
                },
                icon: Icon(Icons.arrow_forward),
                label: Text('Sign Out'),
              ),
            ),
          );
  }
}
