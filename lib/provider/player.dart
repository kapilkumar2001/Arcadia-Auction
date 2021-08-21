import 'package:arcadia/enums/category.dart';
import 'package:arcadia/enums/player_status.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Player with ChangeNotifier {
  final String name;
  final String isAdmin;
  final String primaryWeapon;
  final String secondaryWeapon;
  final PlayerCategory playerCategory;
  final PlayerStatus playerStatus;

  Player({
    required this.name,
    required this.isAdmin,
    required this.primaryWeapon,
    required this.secondaryWeapon,
    this.playerCategory = PlayerCategory.unassigned,
    this.playerStatus = PlayerStatus.unsold,
  });
}
