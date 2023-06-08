// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../models/atendee_model.dart';
import '../../../models/group_model.dart';
import '../../../models/non_admin_staff.dart';
import '../../../models/notifier_model.dart';
import '../../../models/user_model.dart';
import '../../db/db.dart';

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
      try {
        emit(DashBoardLoading());
        
        var response = DB(auth: auth).fetchAdminData();
        var response_2 = DB(auth: auth).getAttendeeIDs();
        var response_3 = DB(auth: auth).getNonAdminIDs();
        var response_4 = DB(auth: auth).getCampersIDs();
        var response_5 = DB(auth: auth).getGroupsIDs();
        var response_6 = DB(auth: auth).getAdminIDs();
        var response_7 = DB(auth: auth).getGroupsIDsOnly();
        var response_8 = DB(auth: auth).getAttendeesIdsOnly();
        var response_9 = DB(auth: auth).fetchNotifications();

        List<dynamic> results = await Future.wait([
          response,
          response_2,
          response_3,
          response_4,
          response_5,
          response_6,
          response_7,
          response_8,
          response_9
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
            notifications: results[8]));
      } catch (e) {
        log(e.toString());
        emit(DashBoardFailed('on bloc $e'));
      }
    });
  }
}
