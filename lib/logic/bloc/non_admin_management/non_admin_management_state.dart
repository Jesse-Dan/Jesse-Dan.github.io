// ignore_for_file: must_be_immutable

part of 'non_admin_management_bloc.dart';

abstract class NonAdminManagementState extends Equatable {
  const NonAdminManagementState();
  
  @override
  List<Object> get props => [];
}

class NonAdminManagementInitial extends NonAdminManagementState {}

class NonAdminManagementLoading extends NonAdminManagementState {}

class NonAdminManagementLoaded extends NonAdminManagementState {}

class NonAdminManagementFailed extends NonAdminManagementState {
  String error;
  NonAdminManagementFailed({
    required this.error,
  });
}