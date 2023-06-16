part of 'admin_managemet_bloc.dart';

abstract class AdminManagemetEvent extends Equatable {
  const AdminManagemetEvent();

  @override
  List<Object> get props => [];
}

class AlterCodeEvent extends AdminManagemetEvent {
  final AdminCodesModel adminCodes;

  const AlterCodeEvent({
    required this.adminCodes,
  });
  @override
  List<Object> get props => [adminCodes];
}

class GetCodeEvent extends AdminManagemetEvent {
  const GetCodeEvent();
  @override
  List<Object> get props => [];
}
