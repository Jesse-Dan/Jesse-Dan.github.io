// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:tyldc_finaalisima/models/non_admin_staff.dart';

class Teachings {
  final List<SingleStudy> studies;
  final Attendance attendance;
  final List<NonAdminModel> speakers;

  Teachings({
    required this.attendance,
    required this.speakers,
    required this.studies,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'studies': studies.map((x) => x.toMap()).toList(),
      'attendance': attendance.toMap(),
      'speakers': speakers.map((x) => x.toMap()).toList(),
    };
  }

  factory Teachings.fromMap(Map<String, dynamic> map) {
    return Teachings(
      attendance: Attendance.fromMap(map['attendance']),
      speakers: List<NonAdminModel>.from(map["speakers"].map((x) => x)),
      studies: List<SingleStudy>.from(map["studies"].map((x) => x)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Teachings.fromJson(String source) =>
      Teachings.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Attendance {
  final String male;
  final String female;

  Attendance({required this.male, required this.female});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'male': male,
      'female': female,
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      male: map['male'] as String,
      female: map['female'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Attendance.fromJson(String source) =>
      Attendance.fromMap(json.decode(source) as Map<String, dynamic>);
}

class SingleStudy {
  final String topic;
  final String description;

  SingleStudy(this.topic, this.description);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'topic': topic,
      'description': description,
    };
  }

  factory SingleStudy.fromMap(Map<String, dynamic> map) {
    return SingleStudy(
      map['topic'] as String,
      map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SingleStudy.fromJson(String source) =>
      SingleStudy.fromMap(json.decode(source) as Map<String, dynamic>);
}
