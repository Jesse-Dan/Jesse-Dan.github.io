// ignore_for_file: must_be_immutable

part of 'admin_managemet_bloc.dart';

abstract class AdminManagemetState extends Equatable {
  const AdminManagemetState();

  @override
  List<Object> get props => [];
}

class AdminManagemetInitial extends AdminManagemetState {}

class AdminManagementLoading extends AdminManagemetState {}

class AdminManagemetAltered extends AdminManagemetState {}

class AdminManagementENABLEDISABLE extends AdminManagemetState {
  final bool enabled;

  AdminManagementENABLEDISABLE(this.enabled);
}

class AdminManagemetLoaded extends AdminManagemetState {
  final AdminCodesModel adminCodesModel;

  AdminManagemetLoaded(this.adminCodesModel);
}

class AdminManagemetFailed extends AdminManagemetState {
  String error;
  AdminManagemetFailed({
    required this.error,
  });
}
