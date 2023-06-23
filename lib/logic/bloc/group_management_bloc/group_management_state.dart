// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'group_management_bloc.dart';

abstract class GroupManagementState extends Equatable {
  const GroupManagementState();

  @override
  List<Object> get props => [];
}

class GroupManagementInitial extends GroupManagementState {}

class GroupManagementLoading extends GroupManagementState {}

class GroupManagementLoaded extends GroupManagementState {}

class GroupManagementFailed extends GroupManagementState {
  String error;
  GroupManagementFailed({
    required this.error,
  });
}
