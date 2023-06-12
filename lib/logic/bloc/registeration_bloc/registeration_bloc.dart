import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../config/codes.dart';
import '../../../models/atendee_model.dart';
import '../../../models/group_model.dart';
import '../../../models/non_admin_staff.dart';
import '../../../models/notifier_model.dart';
import '../../db/db.dart';

part 'registeration_event.dart';
part 'registeration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final FirebaseAuth auth;
  final FirebaseStorage storage;

  RegistrationBloc({required this.auth, required this.storage})
      : super(RegistrationInitial()) {
    registerAttendee();
    registerNonAdmin();
    createGroup();
  }

  Future<void> registerAttendee() async {
    on<RegisterAttendeeEvent>((event, emit) async {
      emit(RegistrationLoading());
      try {
        if (event.adminCode == ADMIN_AUTH_CODE) {
          emit(RegistrationLoading());

          await DB(auth: auth).sendRegisteeData(event.attendeeModel);
          emit(const AttendeeRegistrationLoaded());
          await DB(auth: auth).sendNotificationData(Notifier.registerAttendee(
              data:
                  '${event.attendeeModel.firstName} ${event.attendeeModel.lastName}'));
        } else {
          emit(const RegistrationFailed(
              error:
                  'Admin Auth Code is  incorrect Contact Admin for support'));
        }
      } on FirebaseAuthException catch (e) {
        log(e.toString());
        emit(RegistrationFailed(error: e.toString()));
      } catch (e) {
        log(e.toString());
        emit(RegistrationFailed(error: e.toString()));
      }
    });
  }

  Future<void> registerNonAdmin() async {
    on<CreateNonAdminEvent>((event, emit) async {
      emit(RegistrationLoading());

      try {
        if (event.adminCode == ADMIN_AUTH_CODE) {
          emit(RegistrationLoading());

          await DB(auth: auth).sendNoneAdminData(event.nonAdminModel);
          emit(const NonAdminRegistrationLoaded());
          await DB(auth: auth).sendNotificationData(Notifier.addNonAdmin(
              data:
                  '${event.nonAdminModel.firstName} ${event.nonAdminModel.lastName}'));
        } else {
          emit(const RegistrationFailed(
              error:
                  'Admin Auth Code is  incorrect Contact Admin for support'));
        }
      } on FirebaseAuthException catch (e) {
        log(e.toString());
        emit(RegistrationFailed(error: e.toString()));
      } catch (e) {
        log(e.toString());
        emit(RegistrationFailed(error: e.toString()));
      }
    });
  }

  Future<void> createGroup() async {
    on<CreateGroupEvent>((event, emit) async {
      emit(RegistrationLoading());
      try {
        if (event.adminCode == ADMIN_AUTH_CODE) {
          emit(RegistrationLoading());

          await DB(auth: auth).createGroup(event.groupModel);
          await DB(auth: auth).sendNotificationData(Notifier.registerAttendee(
              data:
                  '${event.groupModel.name} ${event.groupModel.description}'));
          emit(const GroupRegistrationLoaded());
        } else {
          emit(const RegistrationFailed(
              error:
                  'Admin Auth Code is  incorrect Contact Admin for support'));
          log('error');
        }
      } on FirebaseAuthException catch (e) {
        log(e.toString());
        emit(RegistrationFailed(error: e.message.toString()));
      } catch (e) {
        log(e.toString());
        emit(const RegistrationFailed(error: 'an error occured try ag'));
      }
    });
  }
}
