// ignore_for_file: must_be_immutable

part of 'user_management_bloc.dart';

abstract class UserManagementState extends Equatable {
  const UserManagementState();
  
  @override
  List<Object> get props => [];
}

class UserManagementInitial extends UserManagementState {}

class UserManagementLoading extends UserManagementState {}

class UserManagementLoaded extends UserManagementState {}

class UserManagementFailed extends UserManagementState {
  String error;
  UserManagementFailed({
    required this.error,
  });
}