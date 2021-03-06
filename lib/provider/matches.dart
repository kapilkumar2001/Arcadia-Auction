import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/match.dart';

class Matches with ChangeNotifier {
  List<Match> matches = [];
  List<Match> upcomingMatches = [];
  List<Match> completedMatches = [];

  Future<void> fetchAndSetMatches() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('Match');

    QuerySnapshot allDataQuerySnapshot = await _collectionRef.get();

    matches = allDataQuerySnapshot.docs
        .map((doc) => doc.data())
        .toList()
        .map((e) => Match.fromMap(e as Map<String, dynamic>))
        .toList();
    upcomingMatches =
        matches.where((element) => element.isCompleted == false).toList();
    completedMatches =
        matches.where((element) => element.isCompleted == true).toList();
    notifyListeners();
  }

  Future<void> updateMatches(Match m) async {
    CollectionReference match = FirebaseFirestore.instance.collection('Match');
    await match.doc(m.matchId).update(m.toMap()).then((_) {
      print("Data Updated in firebase for team id - " + m.matchId);
    });
    await fetchAndSetMatches();
    notifyListeners();
  }

  Future<void> addMatches(Match m) async {
    CollectionReference players =
        FirebaseFirestore.instance.collection('Match');
    String uid = m.matchId;
    await players.doc(uid).set(m.toMap());
    await fetchAndSetMatches();
    notifyListeners();
    return;
  }
}
