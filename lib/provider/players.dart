import 'dart:math';

import 'package:arcadia/enums/category.dart';
import 'package:arcadia/enums/player_status.dart';
import 'package:arcadia/provider/player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Players with ChangeNotifier {
  List<Player> allPlayers = [
    // Player(
    //   name: 'Nishant',
    //   inGameName: 'iauhdslfiahudf',
    //   primaryWeapon: 'lavda',
    //   secondaryWeapon: 'chumt',
    //   hoursPlayed: 1,
    //   steamUrl: 'https://steamcommunity.com/profiles/76561199007256891/',
    //   playerCategory: PlayerCategory.gold,
    //   studentID: '116262',
    // ),
    // Player(
    //   name: 'Kapil',
    //   inGameName: 'aisdhfiawhdf',
    //   primaryWeapon: 'naak',
    //   hoursPlayed: 1,
    //   steamUrl: 'https://steamcommunity.com/profiles/76561199007256891/',
    //   secondaryWeapon: 'gaand',
    //   playerCategory: PlayerCategory.silver,
    //   studentID: '55151',
    // ),
    // Player(
    //   name: 'Nishant-noob',
    //   inGameName: 'XD-Noob',
    //   primaryWeapon: 'lavda',
    //   hoursPlayed: 1,
    //   steamUrl: 'https://steamcommunity.com/profiles/76561199007256891/',
    //   secondaryWeapon: 'chumt',
    //   playerCategory: PlayerCategory.silver,
    //   studentID: '25191',
    // ),
    // Player(
    //   name: 'Kapil-noob',
    //   inGameName: 'Matlab-noob',
    //   primaryWeapon: 'naak',
    //   hoursPlayed: 1,
    //   steamUrl: 'https://steamcommunity.com/profiles/76561199007256891/',
    //   secondaryWeapon: 'gaand',
    //   playerCategory: PlayerCategory.bronze,
    //   studentID: '15144',
    // ),
  ];

  List<Player> soldPlayers = [
    // Player(
    //   name: 'Nishant',
    //   inGameName: 'iauhdslfiahudf',
    //   primaryWeapon: 'lavda',
    //   secondaryWeapon: 'chumt',
    //   hoursPlayed: 1,
    //   steamUrl: 'https://steamcommunity.com/profiles/76561199007256891/',
    //   playerCategory: PlayerCategory.gold,
    //   studentID: '116262',
    // ),
    // Player(
    //   name: 'Kapil',
    //   inGameName: 'aisdhfiawhdf',
    //   primaryWeapon: 'naak',
    //   hoursPlayed: 1,
    //   steamUrl: 'https://steamcommunity.com/profiles/76561199007256891/',
    //   secondaryWeapon: 'gaand',
    //   playerCategory: PlayerCategory.silver,
    //   studentID: '55151',
    // ),
  ];

  List<Player> unsoldPlayers = [
    // Player(
    //   name: 'Nishant-noob',
    //   inGameName: 'XD-Noob',
    //   primaryWeapon: 'AWP',
    //   hoursPlayed: 1,
    //   steamUrl: 'https://steamcommunity.com/profiles/76561199007256891/',
    //   secondaryWeapon: 'AK47',
    //   playerCategory: PlayerCategory.silver,
    //   studentID: '25191',
    // ),
    // Player(
    //   name: 'Kapil-noob',
    //   inGameName: 'Matlab-noob',
    //   primaryWeapon: 'Deagle',
    //   hoursPlayed: 1,
    //   steamUrl: 'https://steamcommunity.com/profiles/76561199007256891/',
    //   secondaryWeapon: 'AUG',
    //   playerCategory: PlayerCategory.bronze,
    //   studentID: '15144',
    // ),
  ];

  List<Player> get getAllPlayers => allPlayers;
  List<Player> get getSoldPlayers => soldPlayers;
  List<Player> get getUnsoldPlayers => unsoldPlayers;

  Player get getNextUnsoldPlayer {
    Random random = new Random();
    return unsoldPlayers.elementAt(random.nextInt(unsoldPlayers.length));
  }

  void addSoldPlayer(Player p) {
    soldPlayers.add(p);
    unsoldPlayers.removeWhere((elem) => p.name == elem.name);
    notifyListeners();
  }

  Future<void> addplayerSetup(
    Player p,
  ) async {
    CollectionReference players =
        FirebaseFirestore.instance.collection('Player');

    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    players.doc(uid).set(p.toMap());
    notifyListeners();
    return;
  }


  Future<void> updatePlayer(String uid, Player p) async {
    CollectionReference players =
        FirebaseFirestore.instance.collection('Player');
    players.doc(uid).update(p.toMap()).then((_) {
      print("Data Updated in firebase for uid - " + uid);
    });
    notifyListeners();
  }

  Future<void> fetchAndSetPlayers() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('Player');

    QuerySnapshot allDataQuerySnapshot = await _collectionRef.get();

    final allData = allDataQuerySnapshot.docs
        .map((doc) => doc.data())
        .toList()
        .map((e) => Player.fromMap(e as Map<String, dynamic>))
        .toList();

    allPlayers = allData.where((element) => element.isAdmin == false).toList();

    soldPlayers = allPlayers
        .where((element) => element.playerStatus == PlayerStatus.sold)
        .toList();
    unsoldPlayers = allPlayers
        .where((element) => element.playerStatus == PlayerStatus.unsold)
        .toList();
  }
}
