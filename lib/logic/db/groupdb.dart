import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/atendee_model.dart';
import '../../models/group_model.dart';

class GroupDB {
  final FirebaseAuth auth;
  final groupDB = FirebaseFirestore.instance.collection('Groups');

  GroupDB({required this.auth});

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
}
