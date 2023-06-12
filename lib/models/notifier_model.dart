import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'non_admin_staff.dart';
import '../../config/date_time_formats.dart';

class Notifier {
  final String action;
  final DateTime? time;
  final String description;
  final dynamic data;

  const Notifier({
    this.data = '',
    this.time,
    this.description = '',
    this.action = '',
  });
  Notifier.addNonAdmin({
    this.data = NonAdminModel,
    this.time,
    this.description = 'Non Admin Created Successfully',
    this.action = 'Non Admin Registration',
  });
  Notifier.createGroup({
    this.data = '',
    this.time,
    this.description = 'Group has been created successfully',
    this.action = 'Group Creation',
  });
  Notifier.registerAttendee({
    this.data = '',
    this.time,
    this.description = 'Attendee registration was ',
    this.action = 'Attendee registeration',
  });
  Notifier.addFacilitator({
    this.data = '',
    this.time,
    this.description = 'Facilitator was created',
    this.action = 'Facilitator creation',
  });
  Notifier.login({
    this.data = '',
    this.time,
    this.description = 'Login was Successfull',
    this.action = 'Login',
  });
  Notifier.logout({
    this.data = '',
    this.time,
    this.description = 'Session was ended Successfully',
    this.action = 'End session',
  });

  Notifier.signUp({
    this.data = '',
    this.time,
    this.description = 'SignUp was Successfull',
    this.action = 'SignUp',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data,
      'action': action,
      'time': DateTime.now(),
      'description': description,
    };
  }

  factory Notifier.fromMap(Map<String, dynamic> map) {
    return Notifier(
      data: map['data'],
      action: map['action'] as String,
      time: (map['time'] as Timestamp).toDate(),
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Notifier.fromJson(String source) =>
      Notifier.fromMap(json.decode(source) as Map<String, dynamic>);
}
