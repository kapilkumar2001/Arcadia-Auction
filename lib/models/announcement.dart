import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Announcement {
  final String id;
  final String title;
  final String subtitle;
  final String desc;
  final DateTime createddateTime;
  Announcement({
    required this.id,
    required this.title,
     this.subtitle='',
     this.desc ='',
    required this.createddateTime,
  });

  Announcement copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? desc,
    DateTime? createddateTime,
  }) {
    return Announcement(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      desc: desc ?? this.desc,
      createddateTime: createddateTime ?? this.createddateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'desc': desc,
      'createddateTime': createddateTime.millisecondsSinceEpoch,
    };
  }

  factory Announcement.fromMap(Map<String, dynamic> map) {
    return Announcement(
      id: map['id'],
      title: map['title'],
      subtitle: map['subtitle'],
      desc: map['desc'],
      createddateTime: DateTime.fromMillisecondsSinceEpoch(map['createddateTime']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Announcement.fromJson(String source) => Announcement.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Announcment(id: $id, title: $title, subtitle: $subtitle, desc: $desc, createddateTime: $createddateTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Announcement &&
      other.id == id &&
      other.title == title &&
      other.subtitle == subtitle &&
      other.desc == desc &&
      other.createddateTime == createddateTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      subtitle.hashCode ^
      desc.hashCode ^
      createddateTime.hashCode;
  }
}
