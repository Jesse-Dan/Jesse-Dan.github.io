import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_functions_dart/firebase_functions_dart.dart';

import '../../models/notifier_model.dart';
import '../../models/recently_deleted_model.dart';

class UtilsDB {
  final FirebaseAuth auth;
  final adminCodesDB = FirebaseFirestore.instance.collection('AdminCodes');
  final notifierDB = FirebaseFirestore.instance.collection('Notifications');
  final recentlyDeletedDB =
      FirebaseFirestore.instance.collection('RecentlyDeleted');

  UtilsDB({required this.auth});

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

  Future<bool> disableAdmin(String userId) async {
    try {
      HttpsCallable callable =
          FirebaseFunctions.instance.httpsCallable('disableAdmin');
      await callable.call(<String, dynamic>{
        'userId': userId,
      });
      print('Admin disabled successfully.');
      return true;
    } catch (e) {
      // Handle errors
      print('Error disabling admin: $e');
      return false;
    }
  }

  Future<bool> enableAdmin(String userId) async {
    try {
      HttpsCallable callable =
          FirebaseFunctions.instance.httpsCallable('enableAdmin');
      await callable.call(<String, dynamic>{
        'userId': userId,
      });
      print('Admin enabled successfully.');

      return true;
    } catch (e) {
      // Handle errors
      print('Error enabling admin: $e');
      return false;
    }
  }
}
