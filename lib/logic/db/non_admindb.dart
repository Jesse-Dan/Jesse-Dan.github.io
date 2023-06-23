import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/non_admin_staff.dart';

class NonAdminDB {
  final FirebaseAuth auth;
  final nonAdminstrativeStaffDB =
      FirebaseFirestore.instance.collection('NonAdmin');

  NonAdminDB({required this.auth});

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
}
