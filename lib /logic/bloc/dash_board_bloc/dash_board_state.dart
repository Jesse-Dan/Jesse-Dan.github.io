part of 'dash_board_bloc.dart';

abstract class DashBoardState extends Equatable {
  const DashBoardState();

  @override
  List<Object> get props => [];
}

class DashBoardInitial extends DashBoardState {}

class DashBoardLoading extends DashBoardState {}

class DashBoardFetched extends DashBoardState {
  final AdminModel user;
  final List<AttendeeModel> attendeeModel;
  final List<NonAdminModel> nonAdminModel;
  final List<AttendeeModel> campers;
  final List<AdminModel> admins;
  final List<GroupModel> groups;

  const DashBoardFetched(
      {required this.admins,
      required this.groups,
      required this.campers,
      required this.user,
      required this.attendeeModel,
      required this.nonAdminModel});
  List<Object> get props =>
      [user, attendeeModel, nonAdminModel, campers, groups, admins];
}

class DashBoardFailed extends DashBoardState {
  final String error;

  const DashBoardFailed(this.error);

  List<Object> get props => [error];
}
