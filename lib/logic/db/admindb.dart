import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../../models/auth_code_model.dart';
import '../../models/departments_type_model.dart';
import '../../models/models.dart';

class DB {
  final FirebaseAuth auth;
  final adminCodesDB = FirebaseFirestore.instance.collection('AdminCodes');
  final adminDB = FirebaseFirestore.instance.collection('Admins');
  final departTypesDB =
      FirebaseFirestore.instance.collection('DepartmentTypes');

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

  ///[UPDATE ADMIN DATA]
  Future<bool> updateEnabledStatus({String? id, newData, field}) async {
    if (id != null) {
      try {
        await adminDB.doc(id).update({field: newData});
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

  /// [ALTER ADMIN CODE]
  Future<bool> alterAdminCode(
      {required String oldValue,
      required String newValue,
      required String field}) async {
    try {
      var doc = await adminCodesDB.doc('ADMINCODES').get();
      var codeModel = doc.data()!;
      if (codeModel.containsKey(field) && codeModel[field] == oldValue) {
        log('do-able');
        adminCodesDB.doc('ADMINCODES').update({field: newValue});
        return true;
      } else {
        log('not do-able (view model:  ${codeModel.values})');
        return false;
      }
    } on FirebaseException catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> updateAdminCodeAcrossDB(
      {dynamic oldValue, dynamic newValue, required String field}) async {
    try {
      final snapshot = await adminDB.get();

      final batchUpdate = FirebaseFirestore.instance.batch();

      for (final doc in snapshot.docs) {
        final data = doc.data();
        if (data.containsKey(field) && data[field] == oldValue) {
          batchUpdate.update(doc.reference, {field: newValue});
        } else {
          log('$data _doesn\'t match');
        }
      }
      await batchUpdate.commit();
      return false;
    } catch (error) {
      log('Error updating data: $error');
      return false;
    }
  }

  /// [ADD ADMIN DATA]
  Future<void> sendDepartmentType(DepartmentTypes adminModel) async {
    try {
      await departTypesDB
          .doc(adminModel.departments.toString())
          .set(adminModel.toMap())
          .then((value) => log('Admin Created'));
    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }

  ///[GET ADMIN STAFF ID]
  Future<bool> updateDepartmentType({
    required Departments newValue,
      Departments? oldValue,
    bool createNewDepartmentType = false,
  }) async {
    var doc = await departTypesDB.doc('departments').get();
    var codeModel = DepartmentTypes.fromMap(doc.data()!);
    if (createNewDepartmentType == true) {
      try {
        codeModel.departments.add(newValue);
        await departTypesDB.doc('departments').update(codeModel.toMap());
        return true;
      } on FirebaseException catch (e) {
        log(e.toString(), name: 'firebase error on add new dept type');
        return false;
      } catch (e) {
        log(e.toString(), name: 'unknown error on add new dept type');
        return false;
      }
    } else {
      try {
        for (int i = 0; i < codeModel.departments.length; i++) {
          var element = codeModel.departments[i];
          if (element.departmentName == oldValue!.departmentName) {
            // Update the specific value in the list
            codeModel.departments[i] = newValue;
            await departTypesDB.doc('departments').update(codeModel.toMap());
            return true;
          }
        }
      } on FirebaseException catch (e) {
        log(e.toString(), name: 'firebase error on add update dept type');
        return false;
      } catch (e) {
        log(e.toString(), name: 'unknown error on add update dept type');
        return false;
      }
      // If the socialName is not found in the list, return false
      return false;
    }
  }

  /// [set departments ]
  Future<void> setNewUrls(/*{DepartmentTypes? departments}*/) async {
    try {
      await departTypesDB
          .doc('departments')
          .set(DepartmentTypes(
              departments: [Departments(departmentName: 'HandyGuys')]).toMap())
          .then((value) => log('departments Created'));
    } on FirebaseException catch (e) {
      log('error on send departments db:$e');
    }
  }

  ///[GET departments ]
  Future<DepartmentTypes?> getDepartmentTypes() async {
    try {
      var departments = await departTypesDB.doc('departments').get();
      var data = DepartmentTypes.fromMap(departments.data()!);
      log(data.toString());
      return data;
    } catch (e) {
      log('error on get departments db:$e');
      return null;
    }
  }
}
