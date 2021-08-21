import 'dart:math';

import 'package:arcadia/enums/category.dart';
import 'package:arcadia/provider/player.dart';
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
      playerCategory: PlayerCategory.gold,
    ),
    Player(
      name: 'Kapil',
      inGameName: 'aisdhfiawhdf',
      primaryWeapon: 'naak',
      hoursPlayed: 1,
      steamUrl: 'https://steamcommunity.com/profiles/76561199007256891/',
      secondaryWeapon: 'gaand',
      playerCategory: PlayerCategory.silver,
    ),
  ];

  List<Player> unsoldPlayers = [
    Player(
      name: 'Nishant-noob',
      inGameName: 'XD-Noob',
      primaryWeapon: 'lavda',
      hoursPlayed: 1,
      steamUrl: 'https://steamcommunity.com/profiles/76561199007256891/',
      secondaryWeapon: 'chumt',
      playerCategory: PlayerCategory.silver,
    ),
    Player(
      name: 'Kapil-noob',
      inGameName: 'Matlab-noob',
      primaryWeapon: 'naak',
      hoursPlayed: 1,
      steamUrl: 'https://steamcommunity.com/profiles/76561199007256891/',
      secondaryWeapon: 'gaand',
      playerCategory: PlayerCategory.bronze,
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
}
