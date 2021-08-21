import 'dart:math';

import 'package:auctions/enums/category.dart';
import 'package:auctions/provider/player.dart';
import 'package:flutter/material.dart';

class Players with ChangeNotifier {
  List<Player> soldPlayers = [
    Player(
      name: 'Nishant',
      isAdmin: '0',
      primaryWeapon: 'lavda',
      secondaryWeapon: 'chumt',
      playerCategory: PlayerCategory.gold,
    ),
    Player(
      name: 'Kapil',
      isAdmin: '0',
      primaryWeapon: 'naak',
      secondaryWeapon: 'gaand',
      playerCategory: PlayerCategory.silver,
    ),
  ];

  List<Player> unsoldPlayers = [
    Player(
      name: 'Nishant-noob',
      isAdmin: '0',
      primaryWeapon: 'lavda',
      secondaryWeapon: 'chumt',
      playerCategory: PlayerCategory.silver,
    ),
    Player(
      name: 'Kapil-noob',
      isAdmin: '0',
      primaryWeapon: 'naak',
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
