import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'methods_state.dart';

class MethodsCubit extends Cubit<MethodsState> {
  final GlobalKey<ScaffoldState> globalKey;
  MethodsCubit({required this.globalKey}) : super(MethodsInitial()) {
    controlMenu();
  }
  void controlMenu() {
    try {
      if (globalKey.currentState!.isDrawerOpen) {
        globalKey.currentState!.openDrawer();
        emit(MethodsDone(true));
      } else {
        globalKey.currentState!.closeDrawer();
        emit(MethodsDone(false));
      }
    } catch (e) {
      emit(MethodsFailed('$e.toString()'));
    }
  }
}
