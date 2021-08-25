import 'dart:convert';
import 'package:flutter/foundation.dart';

class Match {
  final String matchId;
  final DateTime matchTime;
  final String teamId1;
  final String teamId2;
  final bool isCompleted;
  final Map<String, int>? points;
  final String? mvpId;
  final Map<String, int>? roundsWon;
  final int? roundDiff;
  Match({
    required this.matchId,
    required this.matchTime,
    required this.teamId1,
    required this.teamId2,
    required this.isCompleted,
    this.points,
    this.mvpId,
    this.roundsWon,
    this.roundDiff,
  });

  Match copyWith({
    String? matchId,
    DateTime? matchTime,
    String? teamId1,
    String? teamId2,
    bool? isCompleted,
    Map<String, int>? points,
    String? mvpId,
    Map<String, int>? roundsWon,
    int? roundDiff,
  }) {
    return Match(
      matchId: matchId ?? this.matchId,
      matchTime: matchTime ?? this.matchTime,
      teamId1: teamId1 ?? this.teamId1,
      teamId2: teamId2 ?? this.teamId2,
      isCompleted: isCompleted ?? this.isCompleted,
      points: points ?? this.points,
      mvpId: mvpId ?? this.mvpId,
      roundsWon: roundsWon ?? this.roundsWon,
      roundDiff: roundDiff ?? this.roundDiff,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'matchId': matchId,
      'matchTime': matchTime.millisecondsSinceEpoch,
      'teamId1': teamId1,
      'teamId2': teamId2,
      'isCompleted': isCompleted,
      'points': points,
      'mvpId': mvpId,
      'roundsWon': roundsWon,
      'roundDiff': roundDiff,
    };
  }

  factory Match.fromMap(Map<String, dynamic> map) {
    return Match(
      matchId: map['matchId'],
      matchTime: DateTime.fromMillisecondsSinceEpoch(map['matchTime']),
      teamId1: map['teamId1'],
      teamId2: map['teamId2'],
      isCompleted: map['isCompleted'],
      points: Map<String, int>.from(map['points'] ?? {}),
      mvpId: map['mvpId'],
      roundsWon: Map<String, int>.from(map['roundsWon'] ?? {}),
      roundDiff: map['roundDiff'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Match.fromJson(String source) => Match.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Match(matchId: $matchId, matchTime: $matchTime, teamId1: $teamId1, teamId2: $teamId2, isCompleted: $isCompleted, points: $points, mvpId: $mvpId, roundsWon: $roundsWon, roundDiff: $roundDiff)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Match &&
        other.matchId == matchId &&
        other.matchTime == matchTime &&
        other.teamId1 == teamId1 &&
        other.teamId2 == teamId2 &&
        other.isCompleted == isCompleted &&
        mapEquals(other.points, points) &&
        other.mvpId == mvpId &&
        mapEquals(other.roundsWon, roundsWon) &&
        other.roundDiff == roundDiff;
  }

  @override
  int get hashCode {
    return matchId.hashCode ^
        matchTime.hashCode ^
        teamId1.hashCode ^
        teamId2.hashCode ^
        isCompleted.hashCode ^
        points.hashCode ^
        mvpId.hashCode ^
        roundsWon.hashCode ^
        roundDiff.hashCode;
  }
}
