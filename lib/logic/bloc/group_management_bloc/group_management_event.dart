part of 'group_management_bloc.dart';

abstract class GroupManagementEvent extends Equatable {
  const GroupManagementEvent();

  @override
  List<Object> get props => [];
}

class AddTOGroupEvent extends GroupManagementEvent {
  final String groupId;
  final GroupModel groupModel;
  final AttendeeModel attendees;

  const AddTOGroupEvent(
      {required this.groupModel,
      required this.groupId,
      required this.attendees});
}

class RemoveFromGroupEvent extends GroupManagementEvent {
  final String groupId;
  final GroupModel groupModel;

  final AttendeeModel userId;

  const RemoveFromGroupEvent(
      {required this.groupModel, required this.groupId, required this.userId});
}

class DeleteGroupEvent extends GroupManagementEvent {
  final String groupId;
  final GroupModel groupModel;
  final AdminModel adminModel;

  const DeleteGroupEvent({required this.groupModel, required this.groupId, required this.adminModel});
}
