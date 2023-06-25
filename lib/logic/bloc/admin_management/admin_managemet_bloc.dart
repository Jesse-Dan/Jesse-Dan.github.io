import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyldc_finaalisima/config/app_autorizations.dart';

import '../../../models/auth_code_model.dart';
import '../../db/admindb.dart';
import '../../local_storage_service.dart/local_storage.dart';

part 'admin_managemet_event.dart';
part 'admin_managemet_state.dart';

class AdminManagemetBloc
    extends Bloc<AdminManagemetEvent, AdminManagemetState> {
  final LocalStorageService localStorageService;
  final FirebaseAuth auth;
  final FirebaseStorage storage;

  AdminManagemetBloc(
      {required this.localStorageService,
      required this.auth,
      required this.storage})
      : super(AdminManagemetInitial()) {
    getAdminCode();
    alterAdminCode();
  }
  alterAdminCode() {
    on<AlterCodeEvent>((event, emit) async {
      try {
        emit(AdminManagementLoading());
        var response_1 = DB(auth: auth).alterAdminCode(
            oldValue: event.oldCode,
            field: event.adminCodeField,
            newValue: event.newCode);
        var response_2 = DB(auth: auth).updateAdminCodeAcrossDB(
            oldValue: event.oldCode,
            newValue: event.newCode,
            field: event.field);
        await Future.wait([response_1, response_2]);
        var code = await DB(auth: auth).getAdminCode();
        await localStorageService.getsaveToDisk('ADMIN_CODES', code!.toJson());
        
        emit(AdminManagemetAltered());
      } on FirebaseAuthException catch (e) {
        emit(AdminManagemetFailed(error: e.toString()));
        log(e.message.toString());
      } catch (e) {
        emit(AdminManagemetFailed(error: e.toString()));
        log(e.toString());
      }
    });
  }

  getAdminCode() {
    on<GetCodeEvent>((event, emit) async {
      try {
        emit(AdminManagementLoading());
        var code = await DB(auth: auth).getAdminCode();
        localStorageService.getsaveToDisk('ADMIN_CODES', code!.toJson());
        emit(AdminManagemetLoaded(code));
        log('Codes: ${code.adminCode}');
      } on FirebaseAuthException catch (e) {
        emit(AdminManagemetFailed(error: e.toString()));
      } catch (e) {
        emit(AdminManagemetFailed(error: e.toString()));
        log(e.toString());
      }
    });
  }
}
