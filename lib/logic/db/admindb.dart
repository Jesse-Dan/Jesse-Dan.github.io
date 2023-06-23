import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:tyldc_finaalisima/models/auth_code_model.dart';
import '../../models/models.dart';

class DB {
  final FirebaseAuth auth;
  final adminCodesDB = FirebaseFirestore.instance.collection('AdminCodes');
  final adminDB = FirebaseFirestore.instance.collection('Admins');

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

  Future<void> updateDataInCollection(
      String collectionName, String dataName, dynamic newValue) async {
    try {
      final collectionRef =
          FirebaseFirestore.instance.collection(collectionName);
      final snapshot = await collectionRef.get();

      final batchUpdate = FirebaseFirestore.instance.batch();

      for (final doc in snapshot.docs) {
        batchUpdate.update(doc.reference, {dataName: newValue});
      }

      await batchUpdate.commit();
      log('Data updated successfully.');
    } catch (error) {
      log('Error updating data: $error');
    }
  }
}
