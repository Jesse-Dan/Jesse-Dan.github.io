import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/atendee_model.dart';

class AttendeeDB {
  final FirebaseAuth auth;
  final attendeeDB = FirebaseFirestore.instance.collection('Attendee');

  AttendeeDB({required this.auth});

  /// [REGISTER ATTENDEE]
  Future<void> sendRegisteeData(AttendeeModel attendeeModel) async {
    await attendeeDB
        .add(attendeeModel.toMap())
        .then((value) => log('Attendee Created'));
    try {} on FirebaseException catch (e) {
      log(e.toString());
    }
  }

  /// [GET ATTENDEES INFO]
  Future<List<AttendeeModel>> getAttendeeIDs() async {
    try {
      var groups = await attendeeDB.get();
      var data =
          groups.docs.map((e) => AttendeeModel.fromMap(e.data())).toList();
      return data;
    } catch (e) {
      log('error on attendees db:$e');

      return [];
    }
  }

  /// [GET ATTENDEES INFO]
  Future<List> getAttendeesIdsOnly() async {
    try {
      var groups = await attendeeDB.get();
      var data = groups.docs.map((e) => e.reference.id).toList();
      return data;
    } catch (e) {
      log('error on db:$e');

      return [];
    }
  }

  /// [GET ATTENDEES 'CAMPERS' INFO]
  Future<List<AttendeeModel>> getCampersIDs() async {
    try {
      var groups = await attendeeDB.get();
      var data = groups.docs
          .map((e) => AttendeeModel.fromMap(e.data()))
          .where((element) =>
              element.wouldCamp.toString().toLowerCase().contains('yes') ||
              element.wouldCamp.toString().toUpperCase().contains('yes'))
          .toList();
      return data;
    } catch (e) {
      log('error on campersdb:$e');
      return [];
    }
  }

  /// [DELETE A USER]
  Future<bool> deleteUser(String attendeeId) async {
    try {
      await attendeeDB.doc(attendeeId).delete();
      return true;
    } catch (e) {
      log('Failed to delete attendee by ID: $e');
      return false;
    }
  }
}
