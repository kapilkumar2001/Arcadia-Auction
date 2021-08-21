import 'dart:math';

import 'package:arcadia/enums/category.dart';
import 'package:arcadia/provider/player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Players with ChangeNotifier {
  List<Player> soldPlayers = [
    Player(
      name: 'Nishant',
      inGameName: 'iauhdslfiahudf',
      primaryWeapon: 'lavda',
      secondaryWeapon: 'chumt',
      hoursPlayed: 1,
      steamUrl: 'https://steamcommunity.com/profiles/76561199007256891/',
      playerCategory: PlayerCategory.gold, studentID: '116262',
    ),
    Player(
      name: 'Kapil',
      inGameName: 'aisdhfiawhdf',
      primaryWeapon: 'naak',
      hoursPlayed: 1,
      steamUrl: 'https://steamcommunity.com/profiles/76561199007256891/',
      secondaryWeapon: 'gaand',
      playerCategory: PlayerCategory.silver, studentID: '55151',
    ),
  ];

  List<Player> unsoldPlayers = [
    Player(
      name: 'Nishant-noob',
      inGameName: 'XD-Noob',
      primaryWeapon: 'AWP',
      hoursPlayed: 1,
      steamUrl: 'https://steamcommunity.com/profiles/76561199007256891/',
      secondaryWeapon: 'AK47',
      playerCategory: PlayerCategory.silver, studentID: '25191',
    ),
    Player(
      name: 'Kapil-noob',
      inGameName: 'Matlab-noob',
      primaryWeapon: 'Deagle',
      hoursPlayed: 1,
      steamUrl: 'https://steamcommunity.com/profiles/76561199007256891/',
      secondaryWeapon: 'AUG',
      playerCategory: PlayerCategory.bronze, studentID: '15144',
    ),
  ];

  List<Player> get getSoldPlayers => soldPlayers;
  List<Player> get getUnsoldPlayers => unsoldPlayers;
  Player get getNextUnsoldPlayer {
    Random random = new Random();
    return unsoldPlayers.elementAt(random.nextInt(soldPlayers.length));
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
    players.doc(uid).set({
      'Name': p.name,
      'StudentID': p.studentID,
      'IGN': p.inGameName,
      'GamingHours': p.hoursPlayed,
      'PrimaryWeapon': p.primaryWeapon,
      'SecondaryWeapon': p.secondaryWeapon,
      'StreamURL': p.steamUrl,
      'isAdmin': p.isAdmin,
      'PlayerCatogary': p.playerCategory.toString(),
      'PlayerStatus': p.playerStatus.toString(),
    });
    notifyListeners();
    return;
  }
}
