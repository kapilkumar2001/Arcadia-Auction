import 'dart:math';

import 'package:arcadia/enums/player_status.dart';
import 'package:arcadia/models/player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

/*
deaths
kills

*/
class Players with ChangeNotifier {
  List<Player> allPlayers = [];
  List<Player> soldPlayers = [];
  List<Player> unsoldPlayers = [];
  List<Player> resellPlayers = [];
  List<Player> unassignedPlayers = [];

  List<Player> get getAllPlayers => allPlayers;
  List<Player> get getSoldPlayers => soldPlayers;
  List<Player> get getUnsoldPlayers => unsoldPlayers;
  List<Player> get getResellPlayers => resellPlayers;
  List<Player> get getUnassignedPlayers => unassignedPlayers;

  Player? get getNextPlayer {
    Random random = new Random();
    if (unassignedPlayers.length == 0) {
      return null;
    }
    return unassignedPlayers
        .elementAt(random.nextInt(unassignedPlayers.length));
  }

  Player? get getNextResellPlayer {
    Random random = new Random();
    if (resellPlayers.length == 0) {
      return null;
    }
    return resellPlayers.elementAt(random.nextInt(resellPlayers.length));
  }

  Player getPlayer(String id) {
    return allPlayers.firstWhere((temp) {
      return temp.uid == id;
    });
  }

  List<Player> getTeamPlayer(String teamId) {
    return allPlayers.where((e) => e.soldTo == teamId).toList();
  }

  // void addSoldPlayer(Player p) {
  //   soldPlayers.add(p);
  //   unsoldPlayers.removeWhere((elem) => p.name == elem.name);
  //   notifyListeners();
  // }

  Future<void> addplayerSetup(Player p) async {
    CollectionReference players =
        FirebaseFirestore.instance.collection('Player');

    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    p = p.copyWith(uid: uid);
    await players.doc(uid).set(p.toMap());
    notifyListeners();
    return;
  }

  Future<void> updatePlayer(Player p) async {
    CollectionReference players =
        FirebaseFirestore.instance.collection('Player');
    await players.doc(p.uid).update(p.toMap()).then((_) {
      print("Data Updated in firebase for uid - " + p.uid);
    });
    await fetchAndSetPlayers();
    notifyListeners();
  }

  Future<void> fetchAndSetPlayers() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('Player');

    QuerySnapshot allDataQuerySnapshot =
        await _collectionRef.orderBy('playerCategory').get();

    final allData = allDataQuerySnapshot.docs
        .map((doc) => doc.data())
        .toList()
        .map((e) => Player.fromMap(e as Map<String, dynamic>))
        .toList();

    //   allData.sort((a, b) => a.playerCategory.compareTo(b.playerCategory));
    // print(allData);

    allPlayers = allData.where((element) => element.isAdmin == false).toList();

    resellPlayers = allPlayers
        .where((element) => element.playerStatus == PlayerStatus.resell)
        .toList();

    unsoldPlayers = allPlayers
        .where((element) => element.playerStatus == PlayerStatus.unsold)
        .toList();

    soldPlayers = allPlayers
        .where((element) => element.playerStatus == PlayerStatus.sold)
        .toList();

    unassignedPlayers = allPlayers
        .where((element) => element.playerStatus == PlayerStatus.unassigned)
        .toList();
  }

  Future<String> getImageUrl(String uid) async {
    String imageUrl = await firebase_storage.FirebaseStorage.instance
        .ref('PlayerProfileImages/$uid/image')
        .getDownloadURL();
    // print(imageUrl);
    return imageUrl;
    // Within your widgets:
    // Image.network(downloadURL);
  }
}
