part of 'registeration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class CreateNonAdminEvent extends RegistrationEvent {
  final NonAdminModel nonAdminModel;
  final String adminCode;

  const CreateNonAdminEvent(this.adminCode, {required this.nonAdminModel});
  @override
  List<Object> get props => [nonAdminModel, adminCode];
}

class CreateGroupEvent extends RegistrationEvent {
  final GroupModel groupModel;
  final String adminCode;

  const CreateGroupEvent(this.adminCode, {required this.groupModel});
  @override
  List<Object> get props => [groupModel, adminCode];
}

class RegisterAttendeeEvent extends RegistrationEvent {
  final AttendeeModel attendeeModel;
  final String adminCode;

  const RegisterAttendeeEvent(this.adminCode, {required this.attendeeModel});
  @override
  List<Object> get props => [attendeeModel, adminCode];
}
