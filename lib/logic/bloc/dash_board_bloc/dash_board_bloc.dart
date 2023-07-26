// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tyldc_finaalisima/logic/db/contact_usdb.dart';
import 'package:tyldc_finaalisima/logic/db/non_admindb.dart';
import 'package:tyldc_finaalisima/logic/db/utilsdb.dart';
import '../../../models/atendee_model.dart';
import '../../../models/contact_us_model.dart';
import '../../../models/departments_type_model.dart';
import '../../../models/group_model.dart';
import '../../../models/non_admin_staff.dart';
import '../../../models/notifier_model.dart';
import '../../../models/recently_deleted_model.dart';
import '../../../models/socials_model.dart';
import '../../../models/user_model.dart';
import '../../db/attendeedb.dart';
import '../../db/admindb.dart';
import '../../db/groupdb.dart';

part 'dash_board_event.dart';
part 'dash_board_state.dart';

class DashBoardBloc extends Bloc<DashBoardEvent, DashBoardState> {
  final FirebaseAuth auth;
  final FirebaseStorage storage;

  DashBoardBloc(this.auth, this.storage) : super(DashBoardInitial()) {
    dashboardEmiter();
  }

  Future<void> dashboardEmiter() async {
    return on<DashBoardDataEvent>((event, emit) async {
      emit(DashBoardLoading());
      try {
        /// Initial Setting of Depts
        // DB(auth: auth).setNewUrls();
        emit(DashBoardLoading());

        var response_1 = DB(auth: auth).fetchAdminData();
        var response_2 = AttendeeDB(auth: auth).getAttendeeIDs();
        var response_3 = NonAdminDB(auth: auth).getNonAdminIDs();
        var response_4 = AttendeeDB(auth: auth).getCampersIDs();
        var response_5 = GroupDB(auth: auth).getGroupsIDs();
        var response_6 = DB(auth: auth).getAdminIDs();
        var response_7 = GroupDB(auth: auth).getGroupsIDsOnly();
        var response_8 = AttendeeDB(auth: auth).getAttendeesIdsOnly();
        var response_9 = UtilsDB(auth: auth).fetchNotifications();
        var response_10 = UtilsDB(auth: auth).fetchRecentlyDeleted();
        var response_11 = NonAdminDB(auth: auth).getNonAdminIdsOnly();
        var response_12 = ContactUsDB(auth: auth).getContactUsMessage();
        var response_13 = ContactUsDB(auth: auth).getSocialsUrls();
        var response_14 = DB(auth: auth).getDepartmentTypes();

        List<dynamic> results = await Future.wait([
          response_1,
          response_2,
          response_3,
          response_4,
          response_5,
          response_6,
          response_7,
          response_8,
          response_9,
          response_10,
          response_11,
          response_12,
          response_13,
          response_14
        ]);

        emit(DashBoardFetched(
            admins: results[5],
            user: results[0],
            attendeeModel: results[1],
            nonAdminModel: results[2],
            campers: results[3],
            groups: results[4],
            groupIds: results[6],
            userIds: results[7],
            notifications: results[8],
            recentlyDeleted: results[9],
            nonadminId: results[10],
            contactMessages: results[11],
            socials: results[12],
            departmentTypes: results[13]));
      } catch (e) {
        log(e.toString());
        emit(DashBoardFailed('on bloc $e'));
      }
    });
  }
}
