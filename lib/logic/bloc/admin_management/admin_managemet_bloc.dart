import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyldc_finaalisima/logic/db/contact_usdb.dart';

import '../../../models/auth_code_model.dart';
import '../../../models/contact_us_model.dart';
import '../../../models/departments_type_model.dart';
import '../../../models/socials_model.dart';
import '../../../models/user_model.dart';
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
    disAbleAdmin();
    enableAdmin();
    updatedeptType();
    setdeptType();
    getAllDeptTypes();
    getumltipleforAuths();
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

  disAbleAdmin() {
    on<DisableAdminEvent>((event, emit) async {
      try {
        emit(AdminManagementLoading());
        var data = await DB(auth: auth).updateEnabledStatus(
            id: event.id, field: 'enabled', newData: event.enabledStatus);
        emit(AdminManagementENABLEDISABLE(data));
      } on FirebaseAuthException catch (e) {
        emit(AdminManagemetFailed(error: e.toString()));
      } catch (e) {
        emit(AdminManagemetFailed(error: e.toString()));
        log(e.toString());
      }
    });
  }

  enableAdmin() {
    on<EnableAdminEvent>((event, emit) async {
      try {
        emit(AdminManagementLoading());
        var data = await DB(auth: auth).updateEnabledStatus(
            id: event.id, field: 'enabled', newData: event.enabledStatus);
        emit(AdminManagementENABLEDISABLE(data));
      } on FirebaseAuthException catch (e) {
        emit(AdminManagemetFailed(error: e.toString()));
      } catch (e) {
        emit(AdminManagemetFailed(error: e.toString()));
        log(e.toString());
      }
    });
  }

  getAllDeptTypes() {
    on<GetDeptTypeAdminEvent>((event, emit) async {
      try {
        emit(AdminManagementLoading());
        var data = await DB(auth: auth).getDepartmentTypes();
        log(data!.departments
            .map((e) => e.departmentName.toString())
            .toList()
            .toString());
        emit(AdminManagemetDeptTypesLoaded(departments: data.departments));
      } on FirebaseAuthException catch (e) {
        emit(AdminManagemetFailed(error: e.toString()));
      } catch (e) {
        emit(AdminManagemetFailed(error: e.toString()));
        log(e.toString());
      }
    });
  }

  Future<void> getumltipleforAuths() async {
    return on<GetMultipleEvent>((event, emit) async {
      emit(AdminManagementLoading());
      try {
        emit(AdminManagementLoading());

        var response_1 = DB(auth: auth).getDepartmentTypes();
        var response_2 = ContactUsDB(auth: auth).getContactUsMessage();
        var response_3 = ContactUsDB(auth: auth).getSocialsUrls();

        List<dynamic> results = await Future.wait([
          response_1,
          response_2,
          response_3,
        ]);

        emit(AdminManagemetFetchedMultipleForMAINPAGE(
          contacts: results[1],
          socials: results[2],
          departmentTypes: results[0],
        ));
      } catch (e) {
        log(e.toString());
        emit(AdminManagemetFailed(error: 'on bloc $e'));
      }
    });
  }

  updatedeptType() {
    on<UpdateDeptTypeAdminEvent>((event, emit) async {
      try {
        emit(AdminManagementLoading());
        await DB(auth: auth).updateDepartmentType(
            newValue: event.dept, oldValue: event.oldvalue);
        emit(AdminManagemetOrdinary());
      } on FirebaseAuthException catch (e) {
        emit(AdminManagemetFailed(error: e.toString()));
      } catch (e) {
        emit(AdminManagemetFailed(error: e.toString()));
        log(e.toString());
      }
    });
  }

  setdeptType() {
    on<CreateNewDeptTypeAdminEvent>((event, emit) async {
      try {
        emit(AdminManagementLoading());
        await DB(auth: auth).updateDepartmentType(
            newValue: event.dept, createNewDepartmentType: true);
        emit(AdminManagemetOrdinary());
      } on FirebaseAuthException catch (e) {
        emit(AdminManagemetFailed(error: e.toString()));
      } catch (e) {
        emit(AdminManagemetFailed(error: e.toString()));
        log(e.toString());
      }
    });
  }
}
