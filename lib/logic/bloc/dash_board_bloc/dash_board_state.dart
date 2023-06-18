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
  final List<String> groupIds;
  final List<String> userIds;
  final List<String> nonadminId;
  final List<Notifier> notifications;
  final List<RecentlyDeletedModel> recentlyDeleted;

  const DashBoardFetched({
    required this.userIds,
    required this.groupIds,
    required this.admins,
    required this.groups,
    required this.campers,
    required this.user,
    required this.nonadminId,
    required this.attendeeModel,
    required this.nonAdminModel,
    required this.notifications,
    required this.recentlyDeleted,
  });
  List<Object> get props => [
        user,
        attendeeModel,
        nonAdminModel,
        campers,
        groups,
        admins,
        groupIds,
        userIds,
        notifications,
        recentlyDeleted,
        nonadminId
      ];
}

class DashBoardFailed extends DashBoardState {
  final String error;

  const DashBoardFailed(this.error);

  List<Object> get props => [error];
}
