import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:tyldc_finaalisima/models/models.dart';

class DB {
  final FirebaseAuth auth;
  final adminDB = FirebaseFirestore.instance.collection('Admins');
  final attendeeDB = FirebaseFirestore.instance.collection('Registee');
  final groupDB = FirebaseFirestore.instance.collection('Groups');
  final notifierDB = FirebaseFirestore.instance.collection('Notifications');
  final nonAdminstrativeStaffDB =
      FirebaseFirestore.instance.collection('NonAdmin');
  final facilitatorsDB = FirebaseFirestore.instance.collection('Facilitators');

  var format = DateFormat.yMMMEd();
  List getAttendeeDocIds = [];

  DB({required this.auth});

  /// [ADD ADMIN DATA]
  Future<void> sendAdminData(AdminModel adminModel) async {
    try {
      await adminDB
          .doc(adminModel.id)
          .set(adminModel.toMap())
          .then((value) => log('Admin Created'));
    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }

  /// [REGISTER ATTENDEE]
  Future<void> sendRegisteeData(AttendeeModel attendeeModel) async {
    try {
      var sed = await attendeeDB
          .add(attendeeModel.toMap())
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
      return true;
    } on FirebaseException catch (e) {
      log(e.toString());
      return false;
    }
  }

  ///[GET NON-ADMIN STAFF ID]
  Future<List<NonAdminModel>> getNonAdminIDs() async {
    try {
      var nonAdmins = await nonAdminstrativeStaffDB.get();
      var data =
          nonAdmins.docs.map((e) => NonAdminModel.fromMap(e.data())).toList();
      return data;
    } catch (e) {
      log('error on [GET NON-ADMIN STAFF DATA] db:$e');

      return [];
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

  ///[GET ADMIN STAFF ID]
  Future<List<AdminModel>> getAdminIDs() async {
    try {
      var groups = await adminDB.get();
      var data = groups.docs.map((e) => AdminModel.fromMap(e.data())).toList();
      return data;
    } catch (e) {
      log('error on db:$e');

      return [];
    }
  }

  /// [GET GROUPS INFO]
  Future<List<GroupModel>> getGroupsIDs() async {
    try {
      var groups = await groupDB.get();
      var data = groups.docs.map((e) => GroupModel.fromMap(e.data())).toList();
      return data;
    } catch (e) {
      log('error on group db:$e');
      return [];
    }
  }

  /// [GET GROUPS INFO]
  Future<List> getGroupsIDsOnly() async {
    try {
      var groups = await groupDB.get();
      var data = groups.docs.map((e) => (e.reference.id)).toList();
      return data;
    } catch (e) {
      // log('error on group db:$e');
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
      DocumentReference sed =
          groupDB.add(groupModel.toMap()) as DocumentReference<Object?>;
      // String docId = sed.id;
      // groupModel.id = docId;
      // await sed.update(groupModel.toJson());
      log(sed.toString());
      return sed.toString();
    } catch (e) {
      return '';
    }
  }

  /// [ADD MEMBER TO GROUP]
  Future<bool> addMemberToGroup(
      {required String groupId, required AttendeeModel memberId}) async {
    try {
      final DocumentReference groupRef = groupDB.doc(groupId);
      final DocumentSnapshot groupSnapshot = await groupRef.get();

      if (groupSnapshot.exists) {
        final Map<String, dynamic> data =
            groupSnapshot.data() as Map<String, dynamic>;

        final List<dynamic> memberDataList =
            data['groupMembers'] as List<dynamic>;

        final List<AttendeeModel> members = memberDataList
            .map((member) => AttendeeModel.fromMap(member))
            .toList();

        members.add(memberId);

        final List<Map<String, dynamic>> updatedMemberDataList =
            members.map((member) => member.toMap()).toList();

        await groupRef.update({
          'groupMembers': FieldValue.arrayUnion(updatedMemberDataList),
        });
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

  /// [REMOVE MEMBER FROM GROUP]
  Future<bool> removeMemberFromGroup(
      {required String groupId, required AttendeeModel membersIndex}) async {
    try {
      final DocumentReference groupRef = groupDB.doc(groupId);
      final DocumentSnapshot groupSnapshot = await groupRef.get();

      if (groupSnapshot.exists) {
        final Map<String, dynamic> data =
            groupSnapshot.data() as Map<String, dynamic>;

        final List<dynamic> memberDataList =
            data['groupMembers'] as List<dynamic>;

        final List<AttendeeModel> members = memberDataList
            .map((member) => AttendeeModel.fromMap(member))
            .toList();

        members.removeWhere((member) => member.id == membersIndex.id);

        final List<Map<String, dynamic>> updatedMemberDataList =
            members.map((member) => member.toMap()).toList();

        await groupRef.update({
          'groupMembers': updatedMemberDataList,
        });
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

  ///[SEND NOTIFICATION]
  Future<void> sendNotificationData(Notifier notification) async {
    try {
      await notifierDB
          .doc(auth.currentUser!.uid)
          .collection('notifications')
          .add(notification.toMap())
          .then((value) => log('Notification Sent '));
    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }

  /// [GET NOTIFICATION INFO]
  Future<List<Notifier>> fetchNotifications() async {
    try {
      var notifications = await notifierDB
          .doc(auth.currentUser!.uid)
          .collection('notifications')
          .orderBy('time', descending: true)
          .get();
      List<Notifier> data =
          notifications.docs.map((e) => Notifier.fromMap(e.data())).toList();
      return data;
    } catch (e) {
      log('error on db:$e');
      return [];
    }
  }
}
