import 'dart:convert';

import 'package:flutter/foundation.dart';

class Team {
  final String teamName;
  final String teamUid;
  final List<String> playerUid;
  final int credits;
  final String ownerName;
  final int numPlayer;
  final int matchesWon;
  final int matchesLost;
  final int matchesDraw;
  final int roundDifference;
  final int points;
  final List<String> completeMatches;
  final List<String> upcomingMatches;
  Team({
    required this.teamName,
    required this.teamUid,
    required this.playerUid,
    required this.credits,
    required this.ownerName,
    required this.numPlayer,
    required this.matchesWon,
    required this.matchesLost,
    required this.matchesDraw,
    required this.roundDifference,
    required this.points,
    required this.completeMatches,
    required this.upcomingMatches,
  });

  Team copyWith({
    String? teamName,
    String? teamUid,
    List<String>? playerUid,
    int? credits,
    String? ownerName,
    int? numPlayer,
    int? matchesWon,
    int? matchesLost,
    int? matchesDraw,
    int? roundDifference,
    int? points,
    List<String>? completeMatches,
    List<String>? upcomingMatches,
  }) {
    return Team(
      teamName: teamName ?? this.teamName,
      teamUid: teamUid ?? this.teamUid,
      playerUid: playerUid ?? this.playerUid,
      credits: credits ?? this.credits,
      ownerName: ownerName ?? this.ownerName,
      numPlayer: numPlayer ?? this.numPlayer,
      matchesWon: matchesWon ?? this.matchesWon,
      matchesLost: matchesLost ?? this.matchesLost,
      matchesDraw: matchesDraw ?? this.matchesDraw,
      roundDifference: roundDifference ?? this.roundDifference,
      points: points ?? this.points,
      completeMatches: completeMatches ?? this.completeMatches,
      upcomingMatches: upcomingMatches ?? this.upcomingMatches,
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
      'matchesWon': matchesWon,
      'matchesLost': matchesLost,
      'matchesDraw': matchesDraw,
      'roundDifference': roundDifference,
      'points': points,
      'completeMatches': completeMatches,
      'upcomingMatches': upcomingMatches,
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
      matchesWon: map['matchesWon'],
      matchesLost: map['matchesLost'],
      matchesDraw: map['matchesDraw'],
      roundDifference: map['roundDifference'],
      points: map['points'],
      completeMatches: List<String>.from(map['completeMatches']),
      upcomingMatches: List<String>.from(map['upcomingMatches']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Team.fromJson(String source) => Team.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Team(teamName: $teamName, teamUid: $teamUid, playerUid: $playerUid, credits: $credits, ownerName: $ownerName, numPlayer: $numPlayer, matchesWon: $matchesWon, matchesLost: $matchesLost, matchesDraw: $matchesDraw, roundDifference: $roundDifference, points: $points, completeMatches: $completeMatches, upcomingMatches: $upcomingMatches)';
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
      other.numPlayer == numPlayer &&
      other.matchesWon == matchesWon &&
      other.matchesLost == matchesLost &&
      other.matchesDraw == matchesDraw &&
      other.roundDifference == roundDifference &&
      other.points == points &&
      listEquals(other.completeMatches, completeMatches) &&
      listEquals(other.upcomingMatches, upcomingMatches);
  }

  @override
  int get hashCode {
    return teamName.hashCode ^
      teamUid.hashCode ^
      playerUid.hashCode ^
      credits.hashCode ^
      ownerName.hashCode ^
      numPlayer.hashCode ^
      matchesWon.hashCode ^
      matchesLost.hashCode ^
      matchesDraw.hashCode ^
      roundDifference.hashCode ^
      points.hashCode ^
      completeMatches.hashCode ^
      upcomingMatches.hashCode;
  }
}
