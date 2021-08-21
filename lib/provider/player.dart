import 'package:arcadia/enums/category.dart';
import 'package:arcadia/enums/player_status.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Player with ChangeNotifier {
  final String name;
  final String inGameName;
  final bool isAdmin;
  final String primaryWeapon;
  final String secondaryWeapon;
  final PlayerCategory playerCategory;
  final PlayerStatus playerStatus;
  final int hoursPlayed;
  final String steamUrl;

  Player({
    required this.inGameName,
    required this.name,
    this.isAdmin = false,
    required this.primaryWeapon,
    required this.secondaryWeapon,
    required this.hoursPlayed,
    required this.steamUrl,
    this.playerCategory = PlayerCategory.unassigned,
    this.playerStatus = PlayerStatus.unsold,
  });
}
