import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../models/atendee_model.dart';
import '../../../models/notifier_model.dart';
import '../../db/db.dart';

part 'user_management_event.dart';
part 'user_management_state.dart';

class UserManagementBloc
    extends Bloc<UserManagementEvent, UserManagementState> {
  final FirebaseAuth auth;
  final FirebaseStorage storage;

  UserManagementBloc({required this.auth, required this.storage})
      : super(UserManagementInitial()) {
    deleteUser();
  }

  deleteUser() async {
    on<DeleteUserEvent>((event, emit) async {
      try {
        emit(UserManagementLoading());
        await DB(auth: auth).deleteUser(event.attendeeID);
        await DB(auth: auth).sendNotificationData(Notifier.registerAttendee(
          action: '',
          description: 'Attendee ${event.attendeeModel.firstName} with id ${event.attendeeModel.id} was deleted',
            data: 'Attendee ${event.attendeeModel.firstName} was deleted'));

        emit(UserManagementLoaded());
      } on FirebaseAuthException catch (e) {
        emit(UserManagementFailed(error: e.toString()));
      } catch (e) {
        emit(UserManagementFailed(error: e.toString()));
        log(e.toString());
      }
    });
  }
}
