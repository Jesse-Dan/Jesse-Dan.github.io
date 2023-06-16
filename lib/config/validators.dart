import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyldc_finaalisima/logic/bloc/auth_bloc/authentiction_bloc.dart';

import '../logic/local_storage_service.dart/local_storage.dart';
import '../models/auth_code_model.dart';

enum AdminAuthLevel { superAdmin, admin, viewer }

class Validators {
  final LocalStorageService localStorageService;
  final BuildContext? context;
  const Validators({required this.localStorageService, this.context});
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  Future<AdminCodesModel> toModel() async {
    return AdminCodesModel.fromJson(
        await localStorageService.getreadFromDisk('ADMIN_CODES'));
  }

  Future<bool> validateAdminAuthCode(input) async {
    if (input == await toModel().then((value) => value.adminCode) ||
        input == await toModel().then((value) async => value.adminCode) ||
        input == await toModel().then((value) => value.adminCode)) {
      return true;
    }
    return false;
  }

  // AdminAuthLevel checkPresentAuthLevel() {
  //   BlocListenerBase(
  //     listener: (context, state) {
  //       return AdminAuthLevel.superAdmin;
  //     },
  //   );
  // }
}
