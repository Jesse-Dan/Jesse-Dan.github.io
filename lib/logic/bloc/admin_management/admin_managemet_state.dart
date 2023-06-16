// ignore_for_file: must_be_immutable

part of 'admin_managemet_bloc.dart';

abstract class AdminManagemetState extends Equatable {
  const AdminManagemetState();

  @override
  List<Object> get props => [];
}

class AdminManagemetInitial extends AdminManagemetState {}

class AdminManagemetLoading extends AdminManagemetState {}
class AdminManagemetAltered extends AdminManagemetState {}

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
