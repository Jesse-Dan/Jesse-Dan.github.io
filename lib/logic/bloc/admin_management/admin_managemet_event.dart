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
  final String id;
  const EnableAdminEvent({
    required this.performedBy,
    required this.id,
  });
  @override
  List<Object> get props => [];
}

class DisableAdminEvent extends AdminManagemetEvent {
  final AdminModel performedBy;
  final String id;
  const DisableAdminEvent({
    required this.performedBy,
    required this.id,
  });
  @override
  List<Object> get props => [];
}
