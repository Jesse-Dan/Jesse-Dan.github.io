import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../db/groupdb.dart';
import '../../db/non_admindb.dart';

import '../../../config/app_autorizations.dart';
import '../../../models/atendee_model.dart';
import '../../../models/group_model.dart';
import '../../../models/non_admin_staff.dart';
import '../../../models/notifier_model.dart';
import '../../db/attendeedb.dart';
import '../../db/utilsdb.dart';
import '../../local_storage_service.dart/local_storage.dart';

part 'registeration_event.dart';
part 'registeration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
    final LocalStorageService localStorageService;
  final FirebaseAuth auth;
  final FirebaseStorage storage;

  RegistrationBloc({required this.localStorageService, required this.auth, required this.storage})
      : super(RegistrationInitial()) {
    registerAttendee();
    registerNonAdmin();
    createGroup();
  }

  Future<void> registerAttendee() async {
    on<RegisterAttendeeEvent>((event, emit) async {
      emit(RegistrationLoading());
      try {
        if (await AppAuthorizations(localStorageService: localStorageService)
            .validateAdminAuthCode(event.adminCode)) {
          emit(RegistrationLoading());

          await AttendeeDB(auth: auth).sendRegisteeData(event.attendeeModel);
          emit(const AttendeeRegistrationLoaded());
          await UtilsDB(auth: auth).sendNotificationData(Notifier.registerAttendee(
              data:
                  'New attendee ${event.attendeeModel.firstName} ${event.attendeeModel.lastName} was created'));
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
        if (await AppAuthorizations(localStorageService: localStorageService)
            .validateAdminAuthCode(event.adminCode)) {
          emit(RegistrationLoading());

          await NonAdminDB(auth: auth).sendNoneAdminData(event.nonAdminModel);
          emit(const NonAdminRegistrationLoaded());
          await UtilsDB(auth: auth).sendNotificationData(Notifier.addNonAdmin(
              data:
                  'Non Admin ${event.nonAdminModel.firstName} ${event.nonAdminModel.lastName} was Created'));
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
        if (await AppAuthorizations(localStorageService: localStorageService)
            .validateAdminAuthCode(event.adminCode)) {
          emit(RegistrationLoading());

          await GroupDB(auth: auth).createGroup(event.groupModel);
          await UtilsDB(auth: auth).sendNotificationData(Notifier.createGroup(
              data:
                  'Group ${event.groupModel.name} with description: ${event.groupModel.description} was created'));
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
