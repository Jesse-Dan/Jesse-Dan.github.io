part of 'registeration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationFailed extends RegistrationState {
  final String error;

  const RegistrationFailed({required this.error});
  @override
  List<Object> get props => [error];
}

class NonAdminRegistrationLoaded extends RegistrationState {
  const NonAdminRegistrationLoaded();
  @override
  List<Object> get props => [];
}

class AttendeeRegistrationLoaded extends RegistrationState {
  const AttendeeRegistrationLoaded();
  @override
  List<Object> get props => [];
}

class GroupRegistrationLoaded extends RegistrationState {
  const GroupRegistrationLoaded();
  @override
  List<Object> get props => [];
}
