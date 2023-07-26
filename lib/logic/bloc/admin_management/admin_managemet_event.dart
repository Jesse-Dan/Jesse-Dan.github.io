part of 'admin_managemet_bloc.dart';

abstract class AdminManagemetEvent extends Equatable {
  const AdminManagemetEvent();

  @override
  List<Object> get props => [];
}

class AlterCodeEvent extends AdminManagemetEvent {
  final String oldCode;
  final String newCode;
  final String field;
  final String adminCodeField;
  final BuildContext context;

  const AlterCodeEvent(
      {required this.oldCode,
      required this.context,
      required this.newCode,
      required this.field,
      required this.adminCodeField});
  @override
  List<Object> get props => [oldCode, newCode, field, adminCodeField];
}

class GetCodeEvent extends AdminManagemetEvent {
  const GetCodeEvent();
  @override
  List<Object> get props => [];
}

class EnableAdminEvent extends AdminManagemetEvent {
  final AdminModel performedBy;
  final bool enabledStatus;
  final String id;
  const EnableAdminEvent(
    this.enabledStatus, {
    required this.performedBy,
    required this.id,
  });
  @override
  List<Object> get props => [];
}

class DisableAdminEvent extends AdminManagemetEvent {
  final AdminModel performedBy;
  final bool enabledStatus;
  final String id;
  const DisableAdminEvent(
    this.enabledStatus, {
    required this.performedBy,
    required this.id,
  });
  @override
  List<Object> get props => [];
}


class CreateNewDeptTypeAdminEvent extends AdminManagemetEvent {
  final AdminModel performedBy;
  final Departments dept;
 

  const CreateNewDeptTypeAdminEvent({
    required this.performedBy,
    required this.dept,
    
  });
  @override
  List<Object> get props => [];
}

class UpdateDeptTypeAdminEvent extends AdminManagemetEvent {
  final AdminModel performedBy;
  final Departments dept;
  final Departments? oldvalue;

  const UpdateDeptTypeAdminEvent({
    required this.performedBy,
    required this.dept,
     this.oldvalue,
  });
  @override
  List<Object> get props => [];
}

class GetDeptTypeAdminEvent extends AdminManagemetEvent {
  final AdminModel performedBy;
  final Departments dept;

  const GetDeptTypeAdminEvent({
    required this.performedBy,
    required this.dept,
  });
  @override
  List<Object> get props => [];
}
