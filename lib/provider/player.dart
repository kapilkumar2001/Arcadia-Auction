import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:arcadia/enums/category.dart';
import 'package:arcadia/enums/player_status.dart';

class Player with ChangeNotifier {
  final String uid;
  final String name;
  final String studentID;
  final String inGameName;
  final bool isAdmin;
  final String primaryWeapon;
  final String secondaryWeapon;
  final PlayerCategory playerCategory;
  final PlayerStatus playerStatus;
  final int hoursPlayed;
  final String steamUrl;
  final String soldTo;
  final int soldIn;

  Player({
    this.uid = '',
    required this.name,
    required this.studentID,
    required this.inGameName,
    this.isAdmin = false,
    required this.primaryWeapon,
    required this.secondaryWeapon,
    this.playerCategory = PlayerCategory.unassigned,
    this.playerStatus = PlayerStatus.unsold,
    required this.hoursPlayed,
    required this.steamUrl,
    this.soldTo = "",
    this.soldIn = 0,
  });
  Player copyWith({
    String? uid,
    String? name,
    String? studentID,
    String? inGameName,
    bool? isAdmin,
    String? primaryWeapon,
    String? secondaryWeapon,
    PlayerCategory? playerCategory,
    PlayerStatus? playerStatus,
    int? hoursPlayed,
    String? steamUrl,
    String? soldTo,
    int? soldIn,
  }) {
    return Player(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      studentID: studentID ?? this.studentID,
      inGameName: inGameName ?? this.inGameName,
      isAdmin: isAdmin ?? this.isAdmin,
      primaryWeapon: primaryWeapon ?? this.primaryWeapon,
      secondaryWeapon: secondaryWeapon ?? this.secondaryWeapon,
      playerCategory: playerCategory ?? this.playerCategory,
      playerStatus: playerStatus ?? this.playerStatus,
      hoursPlayed: hoursPlayed ?? this.hoursPlayed,
      steamUrl: steamUrl ?? this.steamUrl,
      soldTo: soldTo ?? this.soldTo,
      soldIn: soldIn ?? this.soldIn,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'studentID': studentID,
      'inGameName': inGameName,
      'isAdmin': isAdmin,
      'primaryWeapon': primaryWeapon,
      'secondaryWeapon': secondaryWeapon,
      'playerCategory': playerCategory.toString(),
      'playerStatus': playerStatus.toString(),
      'hoursPlayed': hoursPlayed,
      'steamUrl': steamUrl,
      'soldTo': soldTo,
      'soldIn': soldIn,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    PlayerCategory pc = PlayerCategory.values.firstWhere((e) {
      // print("e.string => " + e.toString());
      // print("map[playercateg] =>  " + map['playerCategory']);
      return e.toString() == map['playerCategory'];
    }, orElse: () {
      // print('No matching element.');
      return PlayerCategory.gold;
    });
    PlayerStatus ps = PlayerStatus.values
        .firstWhere((e) => e.toString() == map['playerStatus'], orElse: () {
      // print('No matching element.');
      return PlayerStatus.unsold;
    });

    return Player(
      uid: map['uid'],
      name: map['name'],
      studentID: map['studentID'],
      inGameName: map['inGameName'],
      isAdmin: map['isAdmin'],
      primaryWeapon: map['primaryWeapon'],
      secondaryWeapon: map['secondaryWeapon'],
      playerCategory: pc,
      playerStatus: ps,
      hoursPlayed: map['hoursPlayed'],
      steamUrl: map['steamUrl'],
      soldTo: map['soldTo'],
      soldIn: map['soldIn'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Player.fromJson(String source) => Player.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Player(uid: $uid, name: $name, studentID: $studentID, inGameName: $inGameName, isAdmin: $isAdmin, primaryWeapon: $primaryWeapon, secondaryWeapon: $secondaryWeapon, playerCategory: $playerCategory, playerStatus: $playerStatus, hoursPlayed: $hoursPlayed, steamUrl: $steamUrl, soldTo: $soldTo, soldIn: $soldIn)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Player &&
        other.uid == uid &&
        other.name == name &&
        other.studentID == studentID &&
        other.inGameName == inGameName &&
        other.isAdmin == isAdmin &&
        other.primaryWeapon == primaryWeapon &&
        other.secondaryWeapon == secondaryWeapon &&
        other.playerCategory == playerCategory &&
        other.playerStatus == playerStatus &&
        other.hoursPlayed == hoursPlayed &&
        other.steamUrl == steamUrl &&
        other.soldTo == soldTo &&
        other.soldIn == soldIn;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        studentID.hashCode ^
        inGameName.hashCode ^
        isAdmin.hashCode ^
        primaryWeapon.hashCode ^
        secondaryWeapon.hashCode ^
        playerCategory.hashCode ^
        playerStatus.hashCode ^
        hoursPlayed.hashCode ^
        steamUrl.hashCode ^
        soldTo.hashCode ^
        soldIn.hashCode;
  }
}
