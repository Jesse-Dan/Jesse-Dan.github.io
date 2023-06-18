part of 'user_management_bloc.dart';

abstract class UserManagementEvent extends Equatable {
  const UserManagementEvent();

  @override
  List<Object> get props => [];
}

class DeleteUserEvent extends UserManagementEvent {
  final String attendeeID;
  final AttendeeModel attendeeModel;  final AdminModel adminModel;


  const DeleteUserEvent(
      {required this.attendeeModel, required this.attendeeID,required this.adminModel});
}
