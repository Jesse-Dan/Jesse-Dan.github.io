import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_non_admin_staff_event.dart';
part 'create_non_admin_staff_state.dart';

class CreateNonAdminStaffBloc extends Bloc<CreateNonAdminStaffEvent, CreateNonAdminStaffState> {
  CreateNonAdminStaffBloc() : super(CreateNonAdminStaffInitial()) {
    on<CreateNonAdminStaffEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
