import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../models/non_admin_staff.dart';
import '../../../models/notifier_model.dart';
import '../../../models/recently_deleted_model.dart';
import '../../../models/user_model.dart';
import '../../db/db.dart';

part 'non_admin_management_event.dart';
part 'non_admin_management_state.dart';

class NonAdminManagementBloc
    extends Bloc<NonAdminManagementEvent, NonAdminManagementState> {
  final FirebaseAuth auth;
  final FirebaseStorage storage;

  NonAdminManagementBloc({required this.auth, required this.storage})
      : super(NonAdminManagementInitial()) {
    deleteUser();
  }
  deleteUser() async {
    on<DeleteNonAdminEvent>((event, emit) async {
      try {
        emit(NonAdminManagementLoading());
        await DB(auth: auth).deleteNonAdmin(event.nonAdminId);
        await DB(auth: auth).addtoRecentDeleted(RecentlyDeletedModel.delete(
            dataType: 'Non Admin',
            data:
                'By Admin ${event.adminModel.firstName} ${event.adminModel.lastName} with auth code ${event.adminModel.authCode}',
            description:
                'Non Admin ${event.nonAdminModel.firstName} with ID : ${event.nonAdminModel.id} was deleted'));

        await DB(auth: auth).sendNotificationData(Notifier.registerAttendee(
            action: '',
            description:
                'Non Admin ${event.nonAdminModel.firstName} with id ${event.nonAdminModel.id} was deleted',
            data: 'Non Admin ${event.nonAdminModel.firstName} was deleted'));

        emit(NonAdminManagementLoaded());
      } on FirebaseAuthException catch (e) {
        emit(NonAdminManagementFailed(error: e.toString()));
      } catch (e) {
        emit(NonAdminManagementFailed(error: e.toString()));
        log(e.toString());
      }
    });
  }
}
