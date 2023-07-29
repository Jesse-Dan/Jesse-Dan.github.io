// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class AdminManagemetDeptTypesLoaded extends AdminManagemetState {
  final List<Departments> departments;
  AdminManagemetDeptTypesLoaded({required this.departments});
  @override
  List<Object> get props => [departments];
}

class AdminManagemetOrdinary extends AdminManagemetState {}

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

class AdminManagemetFetchedMultipleForMAINPAGE extends AdminManagemetState {
  final List<ContactUsModel> contacts;
  final SocialsModel? socials;
  final DepartmentTypes? departmentTypes;
  AdminManagemetFetchedMultipleForMAINPAGE({
    required this.contacts,
    this.socials,
    this.departmentTypes,
  });
}
