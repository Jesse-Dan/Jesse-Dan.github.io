import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'methods_state.dart';

class MethodsCubit extends Cubit<MethodsState> {
  MethodsCubit() : super(MethodsInitial()) {
  }
  Future<void> controlMenu({required GlobalKey<ScaffoldState> globalKey}) async{
    try {
      if (!(globalKey.currentState!.isDrawerOpen)) {
       globalKey.currentState!.openDrawer();
        emit(MethodsDone(true));
        if (kDebugMode) {
          print('opened');
        }
      } else {
        globalKey.currentState!.closeDrawer();
        if (kDebugMode) {
          print('closed');
        }
        emit(MethodsDone(false));
      }
    } catch (e) {
      emit(MethodsFailed('$e.toString()'));
    }
  }
}
