part of 'non_admin_management_bloc.dart';

abstract class NonAdminManagementEvent extends Equatable {
  const NonAdminManagementEvent();

  @override
  List<Object> get props => [];
}

class DeleteNonAdminEvent extends NonAdminManagementEvent {
  final String nonAdminId;
  final NonAdminModel nonAdminModel;
  final AdminModel adminModel;

  const DeleteNonAdminEvent( 
      {required this.nonAdminModel, required this.nonAdminId,required this.adminModel,});
}
