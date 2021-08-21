import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Player with ChangeNotifier {
  final String name;
  final String isAdmin;
  final String primaryWeapon;
  final String secondaryWeapon;
  final String category;

  Player({
    required this.name,
    required this.isAdmin,
    required this.primaryWeapon,
    required this.secondaryWeapon,
    this.category = '',
  });
}
