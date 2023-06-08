part of 'group_management_bloc.dart';

abstract class GroupManagementEvent extends Equatable {
  const GroupManagementEvent();

  @override
  List<Object> get props => [];
}

class AddTOGroupEvent extends GroupManagementEvent {
  final String groupId;
  final AttendeeModel userId;

  const AddTOGroupEvent({required this.groupId, required this.userId});
}

class RemoveFromGroupEvent extends GroupManagementEvent {
  final String groupId;
  final AttendeeModel userId;

  const RemoveFromGroupEvent({required this.groupId, required this.userId});
}

class DeleteGroupEvent extends GroupManagementEvent {
  final String groupId;

  const DeleteGroupEvent({required this.groupId});
}
