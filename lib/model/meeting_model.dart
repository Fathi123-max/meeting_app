// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Meeting {
  final String title;
  final String id;
  final DateTime dateTime;
  final int duration;
  final List<String> attendees;
  final String agenda;

  Meeting({
    required this.title,
    required this.id,
    required this.dateTime,
    required this.duration,
    required this.attendees,
    required this.agenda,
  });

  Meeting copyWith({
    String? title,
    String? id,
    DateTime? dateTime,
    int? duration,
    List<String>? attendees,
    String? agenda,
  }) {
    return Meeting(
      title: title ?? this.title,
      id: id ?? this.id,
      dateTime: dateTime ?? this.dateTime,
      duration: duration ?? this.duration,
      attendees: attendees ?? this.attendees,
      agenda: agenda ?? this.agenda,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'id': id,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'duration': duration,
      'attendees': attendees,
      'agenda': agenda,
    };
  }

  factory Meeting.fromMap(Map<String, dynamic> map) {
    return Meeting(
      title: map['title'] as String,
      id: map['id'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      duration: map['duration'] as int,
      attendees: List<String>.from((map['attendees'] as List<String>)),
      agenda: map['agenda'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Meeting.fromJson(String source) =>
      Meeting.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Meeting(title: $title, id: $id, dateTime: $dateTime, duration: $duration, attendees: $attendees, agenda: $agenda)';
  }

  @override
  bool operator ==(covariant Meeting other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.id == id &&
        other.dateTime == dateTime &&
        other.duration == duration &&
        listEquals(other.attendees, attendees) &&
        other.agenda == agenda;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        id.hashCode ^
        dateTime.hashCode ^
        duration.hashCode ^
        attendees.hashCode ^
        agenda.hashCode;
  }
}
