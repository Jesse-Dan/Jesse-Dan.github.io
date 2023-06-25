import 'dart:developer';

import 'package:flutter/material.dart';

import '../logic/local_storage_service.dart/local_storage.dart';
import '../models/auth_code_model.dart';

enum AdminAuthLevel { superAdmin, admin, viewer }

// TODO: [VIEWER SHOULD SEE THIS TABS : DASHBOARD, SEASONS, PROFILE, SETTINGS, END SESSION (AS PER AUTHORIZATION LEVEL)]
class AppAuthorizations {
  final LocalStorageService localStorageService;
  final BuildContext? context;
  const AppAuthorizations({required this.localStorageService, this.context});

  /// [GET ADMIN AUTH CODES]
  AdminCodesModel getAdminCodesFromLocalStorage() {
    return AdminCodesModel.fromJson(
        localStorageService.getreadFromDisk('ADMIN_CODES'));
  }

  ///[VALIDATE SIGNUP BASED ON AVALIBLE ADMIN AUTH CODES ]
  bool validateAdminAuthCode(input) {
    if (input == getAdminCodesFromLocalStorage().adminCode ||
        input == getAdminCodesFromLocalStorage().superAdminCode ||
        input == getAdminCodesFromLocalStorage().viewerCode) {
      return true;
    }
    return false;
  }

  /// [DISPLAY CHILD BASED ON AUTH LEVEL]
  Widget displayForAdmin({required String adminCode, required Widget child}) {
    if (isAdmin(adminCode: adminCode)) {
      return child;
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget displayForSuperAdmin(
      {required String adminCode, required Widget child}) {
    if (isSuperAdmin(adminCode: adminCode)) {
      return child;
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget displayForViewer({required String adminCode, required Widget child}) {
    if (isViewer(adminCode: adminCode)) {
      return child;
    } else {
      return const SizedBox.shrink();
    }
  }

  /// [CHECK AUTH LEVEL]
  bool isSuperAdmin({required String adminCode}) {
    log('Code Is: $adminCode');
    if (adminCode == getAdminCodesFromLocalStorage().superAdminCode) {
      return true;
    } else {
      return false;
    }
  }

  bool isAdmin({required String adminCode}) {
    log('Code Is: $adminCode');
    if (adminCode == getAdminCodesFromLocalStorage().adminCode) {
      return true;
    } else {
      return false;
    }
  }

  bool isViewer({required String adminCode}) {
    log('Code Is: $adminCode');
    if (adminCode == getAdminCodesFromLocalStorage().viewerCode) {
      return true;
    } else {
      return false;
    }
  }

  String getAuthLevel({required String adminCode}) {
    if (isAdmin(adminCode: adminCode)) {
      return 'Administrator';
    } else if (isSuperAdmin(adminCode: adminCode)) {
      return 'Super Administrator';
    } else if (isViewer(adminCode: adminCode)) {
      return 'Viewer';
    } else {
      return 'Unverified User';
    }
  }
}
