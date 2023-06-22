import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:tyldc_finaalisima/models/auth_code_model.dart';
import '../../models/models.dart';
import '../../models/recently_deleted_model.dart';

class DB {
  final FirebaseAuth auth;
  final adminCodesDB = FirebaseFirestore.instance.collection('AdminCodes');
  final adminDB = FirebaseFirestore.instance.collection('Admins');
  final attendeeDB = FirebaseFirestore.instance.collection('Attendee');
  final groupDB = FirebaseFirestore.instance.collection('Groups');
  final notifierDB = FirebaseFirestore.instance.collection('Notifications');
  final nonAdminstrativeStaffDB =
      FirebaseFirestore.instance.collection('NonAdmin');
  final recentlyDeletedDB =
      FirebaseFirestore.instance.collection('RecentlyDeleted');

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
    await attendeeDB
        .add(attendeeModel.toMap())
        .then((value) => log('Attendee Created'));
    try {} on FirebaseException catch (e) {
      log(e.toString());
    }
  }

  /// [CREATE NON STAFF]
  Future<bool> sendNoneAdminData(NonAdminModel nonAdminModel) async {
    try {
      nonAdminstrativeStaffDB
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

  /// [GET NONADMIN ID]
  Future<List> getNonAdminIdsOnly() async {
    try {
      var nonadmin = await nonAdminstrativeStaffDB.get();
      var data = nonadmin.docs.map((e) => e.reference.id).toList();
      return data;
    } catch (e) {
      log('error on non admin ID db:$e');

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

  /// [DELETE A NONADMIN]
  Future<bool> deleteNonAdmin(String nonAdminId) async {
    try {
      await nonAdminstrativeStaffDB.doc(nonAdminId).delete();
      return true;
    } catch (e) {
      log('Failed to delete nonAdmin by ID: $e');
      return false;
    }
  }

  ///[SEND NOTIFICATION]
  Future<void> sendNotificationData(Notifier notification) async {
    try {
      await notifierDB
          .add(notification.toMap())
          .then((value) => log('Notification Sent '));
    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }

  ///[SEND RECENTLY DELETED LOG]
  Future<void> addtoRecentDeleted(
      RecentlyDeletedModel recentlyDeletedModel) async {
    try {
      await recentlyDeletedDB
          .add(recentlyDeletedModel.toMap())
          .then((value) => log('Notification Sent '));
    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }

  ///[GET RECENTLY DELETED INFO]
  Future<List<RecentlyDeletedModel>> fetchRecentlyDeleted() async {
    try {
      var recentlyDeleted =
          await recentlyDeletedDB.orderBy('time', descending: true).get();
      List<RecentlyDeletedModel> data = recentlyDeleted.docs
          .map((e) => RecentlyDeletedModel.fromMap(e.data()))
          .toList();
      return data;
    } catch (e) {
      log('error on db:$e');
      return [];
    }
  }

  /// [GET NOTIFICATION INFO]
  Future<List<Notifier>> fetchNotifications() async {
    try {
      var notifications =
          await notifierDB.orderBy('time', descending: true).get();
      List<Notifier> data =
          notifications.docs.map((e) => Notifier.fromMap(e.data())).toList();
      return data;
    } catch (e) {
      log('error on db:$e');
      return [];
    }
  }

  /// [ALTER ADMIN CODE]
  Future<void> alterAdminCode(AdminCodesModel codes) async {
    try {
      adminCodesDB.doc('ADMINCODES').set(codes.toMap());
    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }

  /// [GET ADMIN CODE]
  Future<AdminCodesModel?> getAdminCode() async {
    try {
      var adminCodes = await adminCodesDB.doc('ADMINCODES').get();
      var data = AdminCodesModel.fromMap(adminCodes.data()!);
      return data;
    } on FirebaseException catch (e) {
      log(e.toString());
      return null;
    }
  }

  ///[UPDATE MOBILE NUMBER ON REG]
  Future<bool> updateEmailNumber({required FirebaseAuth auth, newEmail}) async {
    if (auth.currentUser != null) {
      try {
        await auth.currentUser!.updateEmail(newEmail);
        await adminDB.doc(auth.currentUser!.uid).update({'email': newEmail});

        log("Email updated successfully!");

        return true;
      } catch (e) {
        log('error updating email: $e');
        return false;
      }
    } else {
      log('error updating email ');
      return false;
    }
  }

  ///[UPDATE ADMIN DATA]
  Future<bool> updateAdminData(
      {required FirebaseAuth auth, newData, field}) async {
    if (auth.currentUser != null) {
      try {
        await adminDB.doc(auth.currentUser!.uid).update({field: newData});
        log("Data updated successfully!");
        return true;
      } catch (e) {
        log('error updating data: $e');
        return false;
      }
    } else {
      log('error updating data ');
      return false;
    }
  }
}
