import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import '../../models/RecentFile.dart';
import '../../models/atendee_model.dart';
import '../../models/group_model.dart';
import '../../models/non_admin_staff.dart';
import '../../models/user_model.dart';

class DB {
  final FirebaseAuth auth;
  final adminDB = FirebaseFirestore.instance.collection('Admins');
  final attendeeDB = FirebaseFirestore.instance.collection('Registee');
  final groupDB = FirebaseFirestore.instance.collection('Groups');
  final nonAdminstrativeStaffDB =
      FirebaseFirestore.instance.collection('NonAdmin');
  final facilitatorsDB = FirebaseFirestore.instance.collection('Facilitators');

  var format = DateFormat.yMMMEd();
  List getAdminsDocIds = [];

  DB({required this.auth});

  /// [ADD ADMIN DATA]
  Future<void> sendAdminData(AdminModel adminModel) async {
    try {
      await adminDB
          .doc(adminModel.id)
          .set(adminModel.toMap())
          .then((value) => log('Admin Created'));
      // log(sed);
    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }

  /// [REGISTER ATTENDEE]
  Future<void> sendRegisteeData(AttendeeModel attendeeModel) async {
    try {
      var sed = await attendeeDB
          .add(attendeeModel.toJson())
          .then((value) => log('Attendee Created'))
          .catchError((e) => log(e));
    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }

  /// [CREATE NON STAFF]
  Future<bool> sendNoneAdminData(NonAdminModel nonAdminModel) async {
    try {
      var sed = nonAdminstrativeStaffDB
          .add(nonAdminModel.toMap())
          .then((value) => log('Non-Admin Staff Created'))
          .catchError((e) => log(e));
      log(sed.toString());
      return true;
    } on FirebaseException catch (e) {
      log(e.toString());
      return false;
    }
  }

  ///[GET NON-ADMIN STAFF ID]
  Future<List<NonAdminModel>> getNonAdminIDs() async {
    try {
      List getadminDocIds = [];
      var groups = await nonAdminstrativeStaffDB.get();
      getadminDocIds.clear();

      for (var group in groups.docs) {
        getadminDocIds.add(group.reference.id);
        log("[GET NON-ADMIN STAFF ID]: $getadminDocIds");
      }

      List<NonAdminModel> adminList = [];
      adminList.clear();
      for (var element in getadminDocIds) {
        await nonAdminstrativeStaffDB.doc(element).get().then((value) {
          log('==================>>  :::::$value');
          adminList.add(NonAdminModel.fromMap(value.data()));
          log("[GET NON-ADMIN STAFF DATA]: $adminList.toString()");
          log('==================>>  :::::$value');
        });
      }

      log("attedeesList $adminList");
      return adminList;
    } catch (e) {
      log('error on [GET NON-ADMIN STAFF DATA] db:$e');

      return [];
    }
  }

  /// [GET ATTENDEES INFO]
  Future<List<AttendeeModel>> getAttendeeIDs() async {
    try {
      List getAttendeeDocIds = [];
      var groups = await attendeeDB.get();
      getAttendeeDocIds.clear();

      for (var group in groups.docs) {
        getAttendeeDocIds.add(group.reference.id);
        log("getAttendeeDocIds $getAttendeeDocIds");
      }

      List<AttendeeModel> attedeesList = [];
      attedeesList.clear();
      for (var element in getAttendeeDocIds) {
        await attendeeDB.doc(element).get().then((value) {
          attedeesList.add(AttendeeModel.fromJson(value.data()));
          log('value: $value');
        });
      }
      log("attedeesList $attedeesList");
      return attedeesList;
    } catch (e) {
      log('error on db:$e');

      return [];
    }
  }

  ///[GET ADMIN STAFF ID]
  Future<List<AdminModel>> getAdminIDs() async {
    try {
      List getadminDocIds = [];
      var groups = await adminDB.get();
      getadminDocIds.clear();

      for (var group in groups.docs) {
        getadminDocIds.add(group.reference.id);
        log("getAttendeeDocIds $getadminDocIds");
      }

      List<AdminModel> adminList = [];
      adminList.clear();
      for (var element in getadminDocIds) {
        await adminDB.doc(element).get().then((value) {
          adminList.add(AdminModel.fromMap(value.data()));
          log('value: $value');
        });
      }

      log("attedeesList $adminList");
      return adminList;
    } catch (e) {
      log('error on db:$e');

      return [];
    }
  }

  /// [GET GROUPS INFO]
  Future<List<GroupModel>> getGroupsIDs() async {
    try {
      List getGroupsDocIds = [];
      var groups = await groupDB.get();
      getGroupsDocIds.clear();
      for (var group in groups.docs) {
        getGroupsDocIds.add(group.reference.id);
        log("getAttendeeDocIds $getGroupsDocIds");
      }

      List<GroupModel> groupsList = [];
      groupsList.clear();
      for (var element in getGroupsDocIds) {
        await groupDB.doc(element).get().then((value) {
          groupsList.add(GroupModel.fromJson(value.data()!));
          log('value: $value');
        });
      }

      log("group list: $groupsList");
      return groupsList;
    } catch (e) {
      log('error on group db:$e');

      return [];
    }
  }

  /// [GET ATTENDEES 'CAMPERS' INFO]
  Future<List<AttendeeModel>> getCampersIDs() async {
    try {
      List getAttendeeDocIds = [];
      List<AttendeeModel> attedeesList = [];
      var campers = <AttendeeModel>[];

      var groups = await attendeeDB.get();
      getAttendeeDocIds.clear();
      campers.clear();
      attedeesList.clear();

      for (var group in groups.docs) {
        getAttendeeDocIds.add(group.reference.id);
        log("getAttendeeDocIds $getAttendeeDocIds");
      }

      for (var element in getAttendeeDocIds) {
        await attendeeDB.doc(element).get().then((value) {
          attedeesList.add(AttendeeModel.fromJson(value.data()));
          log('value: $value');
        });
      }
      for (var element in attedeesList) {
        if (element.wouldCamp.toString().toLowerCase() == 'yes') {
          campers.add(element);
        }
      }

      log("campers $attedeesList");
      return campers;
    } catch (e) {
      log('error on campersdb:$e');

      return [];
    }
  }

  ///[FETCH ADMIN DATA]
  Future<AdminModel> fetchAdminData() async {
    try {
      var snapshot = await adminDB.doc(auth.currentUser?.uid).get();
      var data = AdminModel.fromMap(snapshot.data());
      log(data.toString());
      return data;
    } catch (e) {
      log('on db $e');
      rethrow;
    }
  }

  ///[CREATE GROUP]
  Future<String> createGroup(GroupModel groupModel) async {
    try {
      var sed = groupDB
          .doc(groupModel.id)
          .set(groupModel.toJson())
          .then((value) => log('Attendee Created'))
          .catchError((e) => log(e));
      log(sed.toString());
      return groupModel.id;
    } catch (e) {
      if (kDebugMode) {
        log('Failed to create group: $e');
      }
      return '';
    }
  }

  /// [ADD MEMBER TO GROUP]
  Future<bool> addMemberToGroup(String groupId, String memberId) async {
    try {
      final DocumentReference groupRef = groupDB.doc(groupId);
      final DocumentSnapshot groupSnapshot = await groupRef.get();

      if (groupSnapshot.exists) {
        final Map<String, dynamic> data =
            groupSnapshot.data() as Map<String, dynamic>;
        final List<dynamic> members =
            List.from(data['members'] as List<dynamic>);
        members.add(memberId);

        await groupRef.update({'members': members});
        return true;
      } else {
        log('Group does not exist');
        return false;
      }
    } catch (e) {
      log('Failed to add member to group: $e');
      return false;
    }
  }

  ///[REMOVE MEBER FROM GROUP]
  Future<bool> removeMemberFromGroup(String groupId, String memberId) async {
    try {
      final DocumentReference groupRef = groupDB.doc(groupId);
      final DocumentSnapshot groupSnapshot = await groupRef.get();

      if (groupSnapshot.exists) {
        final Map<String, dynamic> data =
            groupSnapshot.data() as Map<String, dynamic>;
        List<dynamic> members = List.from(data['members'] as List<dynamic>);
        members.remove(memberId);

        await groupRef.update({'members': members});
        return true;
      } else {
        log('Group does not exist');
        return false;
      }
    } catch (e) {
      log('Failed to remove member from group: $e');
      return false;
    }
  }

  /// [DELETE A GROUP]
  Future<bool> deleteGroup(String groupId) async {
    try {
      await groupDB.doc(groupId).delete();
      return true;
    } catch (e) {
      log('Failed to delete group: $e');
      return false;
    }
  }

  /// [GET ALL MEMBER OF A GROUP]
  Future<List<String>> getAllMembersInGroup(String groupId) async {
    try {
      final DocumentReference groupRef = groupDB.doc(groupId);
      final DocumentSnapshot groupSnapshot = await groupRef.get();

      if (groupSnapshot.exists) {
        final Map<String, dynamic> data =
            groupSnapshot.data() as Map<String, dynamic>;
        final List<AttendeeModel> members =
            List<AttendeeModel>.from(data['members'] as List<AttendeeModel>);
        return members.cast<String>();
      } else {
        log('Group does not exist');
        return [];
      }
    } catch (e) {
      log('Failed to get members in group: $e');
      return [];
    }
  }
}
