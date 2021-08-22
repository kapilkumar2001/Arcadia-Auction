import 'dart:convert';

import 'package:flutter/foundation.dart';

class Team {
  final String teamName;
  final String teamUid;
  final List<String> playerUid;
  final int credits;
  final String ownerName;
  final int numPlayer;
  Team({
    required this.teamName,
    required this.teamUid,
    required this.playerUid,
    required this.credits,
    required this.ownerName,
    required this.numPlayer,
  });

  Team copyWith({
    String? teamName,
    String? teamUid,
    List<String>? playerUid,
    int? credits,
    String? ownerName,
    int? numPlayer,
  }) {
    return Team(
      teamName: teamName ?? this.teamName,
      teamUid: teamUid ?? this.teamUid,
      playerUid: playerUid ?? this.playerUid,
      credits: credits ?? this.credits,
      ownerName: ownerName ?? this.ownerName,
      numPlayer: numPlayer ?? this.numPlayer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'teamName': teamName,
      'teamUid': teamUid,
      'playerUid': playerUid,
      'credits': credits,
      'ownerName': ownerName,
      'numPlayer': numPlayer,
    };
  }

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      teamName: map['teamName'],
      teamUid: map['teamUid'],
      playerUid: List<String>.from(map['playerUid']),
      credits: map['credits'],
      ownerName: map['ownerName'],
      numPlayer: map['numPlayer'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Team.fromJson(String source) => Team.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Team(teamName: $teamName, teamUid: $teamUid, playerUid: $playerUid, credits: $credits, ownerName: $ownerName, numPlayer: $numPlayer)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Team &&
      other.teamName == teamName &&
      other.teamUid == teamUid &&
      listEquals(other.playerUid, playerUid) &&
      other.credits == credits &&
      other.ownerName == ownerName &&
      other.numPlayer == numPlayer;
  }

  @override
  int get hashCode {
    return teamName.hashCode ^
      teamUid.hashCode ^
      playerUid.hashCode ^
      credits.hashCode ^
      ownerName.hashCode ^
      numPlayer.hashCode;
  }
}
