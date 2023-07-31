part of 'user_management_bloc.dart';

abstract class UserManagementEvent extends Equatable {
  const UserManagementEvent();

  @override
  List<Object> get props => [];
}

class DeleteUserEvent extends UserManagementEvent {
  final String attendeeID;
  final AttendeeModel attendeeModel;
  final AdminModel adminModel;

  const DeleteUserEvent(
      {required this.attendeeModel,
      required this.attendeeID,
      required this.adminModel});
}

class UpdateAttendeeEvent extends UserManagementEvent {
  final String attendeeID;
  final String adminCode;

  final AttendeeModel attendeeModel;
  final AdminModel adminModel;

  const UpdateAttendeeEvent(
      {required this.adminCode,
      required this.attendeeModel,
      required this.attendeeID,
      required this.adminModel});
}

class MarkAttendeePresent extends UserManagementEvent {
  final AdminModel performedBy;
  final bool presentStatus;
  final String id;
  const MarkAttendeePresent(
    this.presentStatus, {
    required this.performedBy,
    required this.id,
  });
  @override
  List<Object> get props => [];
}

class MarkAttendeeAbsent extends UserManagementEvent {
  final AdminModel performedBy;
  final bool presentStatus;
  final String id;
  const MarkAttendeeAbsent(
    this.presentStatus, {
    required this.performedBy,
    required this.id,
  });
  @override
  List<Object> get props => [];
}
