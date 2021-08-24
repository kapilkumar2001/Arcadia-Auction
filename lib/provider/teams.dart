import 'package:arcadia/provider/team.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Teams with ChangeNotifier {
  List<Team> teams = [];

  Future<void> fetchAndSetTeams() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('Team');

    QuerySnapshot allDataQuerySnapshot = await _collectionRef.get();

    teams = allDataQuerySnapshot.docs
        .map((doc) => doc.data())
        .toList()
        .map((e) => Team.fromMap(e as Map<String, dynamic>))
        .toList();
    notifyListeners();
  }

  Future<void> updateTeam(Team t) async {
    CollectionReference teams = FirebaseFirestore.instance.collection('Team');
    await teams.doc(t.teamUid).update(t.toMap()).then((_) {
      // print("Data Updated in firebase for team id - " + t.teamUid);
    });
    await fetchAndSetTeams();
    notifyListeners();
  }
}
