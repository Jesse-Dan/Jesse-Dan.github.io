import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../models/group_model.dart';
import '../../../models/notifier_model.dart';
import '../../db/db.dart';

import '../../../models/atendee_model.dart';

part 'group_management_event.dart';
part 'group_management_state.dart';

class GroupManagementBloc
    extends Bloc<GroupManagementEvent, GroupManagementState> {
  final FirebaseAuth auth;
  final FirebaseStorage storage;

  GroupManagementBloc({required this.auth, required this.storage})
      : super(GroupManagementInitial()) {
    addtoGroup();
    deleteGroup();
    removeFromGroup();
  }
  addtoGroup() async {
    on<AddTOGroupEvent>((event, emit) async {
      try {
        emit(GroupManagementLoading());
        await DB(auth: auth).addMemberToGroup(
            memberId: event.attendees, groupId: event.groupId);
        await DB(auth: auth).sendNotificationData(Notifier.groupActtivity(
            data:
                'User ${"${event.attendees.firstName} ${event.attendees.lastName}"} was added to Group ${event.groupModel.name} '));

        emit(GroupManagementLoaded());
      } on FirebaseAuthException catch (e) {
        emit(GroupManagementFailed(error: e.toString()));
      } catch (e) {
        emit(GroupManagementFailed(error: e.toString()));
        log(e.toString());
      }
    });
  }

  removeFromGroup() async {
    on<RemoveFromGroupEvent>((event, emit) async {
      try {
        emit(GroupManagementLoading());
        await DB(auth: auth).removeMemberFromGroup(
            membersIndex: event.userId, groupId: event.groupId);
        await DB(auth: auth).sendNotificationData(Notifier.groupActtivity(
            data:
                'User ${event.userId.firstName} ${event.userId.lastName} was removed from Group ${event.groupModel.name} '));

        emit(GroupManagementLoaded());
      } on FirebaseAuthException catch (e) {
        emit(GroupManagementFailed(error: e.toString()));
      } catch (e) {
        emit(GroupManagementFailed(error: e.toString()));
        log(e.toString());
      }
    });
  }

  deleteGroup() async {
    on<DeleteGroupEvent>((event, emit) async {
      try {
        emit(GroupManagementLoading());
        await DB(auth: auth).deleteGroup(event.groupId);
        await DB(auth: auth).sendNotificationData(Notifier.groupActtivity(
            data: 'Group ${event.groupModel.name} was deleted'));

        emit(GroupManagementLoaded());
      } on FirebaseAuthException catch (e) {
        emit(GroupManagementFailed(error: e.toString()));
      } catch (e) {
        emit(GroupManagementFailed(error: e.toString()));
        log(e.toString());
      }
    });
  }
}
