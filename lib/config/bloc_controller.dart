import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyldc_finaalisima/config/overlay_config/overlay_service.dart';
import 'package:tyldc_finaalisima/logic/bloc/auth_bloc/authentiction_bloc.dart';
import '../logic/bloc/admin_management/admin_managemet_bloc.dart';
import '../logic/bloc/auth_bloc/authentiction_event.dart';
import '../logic/bloc/index_blocs.dart';
import '../logic/bloc/non_admin_management/non_admin_management_bloc.dart';
import '../logic/bloc/user_management/user_management_bloc.dart';
import '../presentation/widgets/alertify.dart';
import '../presentation/screens/app_views/drawer_items/dashboard/main_screen.dart';
import '../presentation/screens/auth_views/login.dart';

///[this methods are responsible for navigating users based on permissions and states]

/// [DISPLAY ERROR ON SPECIFIC ERROR STATE EMITTED]
updateFailedBlocState({state, context}) {
  log(state.toString());
  switch (state.runtimeType) {
    /// Failed States
    case DashBoardFailed:
      OverlayService.closeAlert();
      Alertify.error(
          title: 'DashBoard Data Error',
          message:
              'An error occured Loading the dashboard ERROR:${state.error}');
      break;
    case UserManagementFailed:
      OverlayService.closeAlert();
      Alertify.error(
          title: 'DashBoard Data Error',
          message: 'An error occured loading the users ERROR:${state.error}');
      break;
    case RegistrationFailed:
      OverlayService.closeAlert();
      Alertify.error(
          title: 'Registration Error',
          message: 'An error occured, Registering ERROR:${state.error}');
      break;
    case AuthentictionFailed:
      OverlayService.closeAlert();
      Alertify.error(
          title: 'Authentiction Error',
          message:
              'An error occured While Authentication ERROR:${state.error}');
      break;
    case AdminManagemetFailed:
      Alertify.error(
          title: 'Admin Management Error',
          message:
              'An error occured While Managing Admins ERROR:${state.error}');
      OverlayService.closeAlert();
      break;
    case GroupManagementFailed:
      OverlayService.closeAlert();
      Alertify.error(
          title: 'Group Management Error',
          message: 'Group ERROR:${state.error}');
      break;
    case NonAdminManagementFailed:
      OverlayService.closeAlert();
      Alertify.error(
          title: 'Non Admin Management Error',
          message: 'Non Admin ERROR:${state.error}');
      break;
    default:
  }
}

/// [DISPLAY ALERT ON SPECIFIC SUCCESS STATE EMITTED]
updatetSuccessBlocState({state, context}) {
  log(state.toString());
  switch (state.runtimeType) {
    case DashBoardFetched:
      BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
      OverlayService.closeAlert();
      break;
    case GroupRegistrationLoaded:
      Alertify.success();
      BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
      OverlayService.closeAlert();
      break;
    case AuthentictionSuccesful:
      BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
      Alertify.success();
      break;
    case AdminManagementENABLEDISABLE:
      Alertify.success();
      BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
      OverlayService.closeAlert();
      break;
    case AttendeeRegistrationLoaded:
      Alertify.success();
      BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
      OverlayService.closeAlert();
      break;
    case UserManagementLoaded:
      Alertify.success();
      BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
      OverlayService.closeAlert();
      break;
    case GroupManagementLoaded:
      Alertify.success();
      BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
      OverlayService.closeAlert();
      break;
    case AdminManagemetAltered:
      Alertify.success();
      BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
      OverlayService.closeAlert();
      break;
    case NonAdminManagementLoaded:
      Alertify.success();
      BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
      OverlayService.closeAlert();
      break;
    default:
  }
}

/// [DISPLAY LOADER ON SPECIFIC LOADING STATE EMITTED]
updateLoadingBlocState({state, context}) {
  log(state.toString());
  switch (state.runtimeType) {
    /// Failed States
    case DashBoardLoading:
      OverlayService.showLoading();
      break;
    case NonAdminManagementLoading:
      OverlayService.showLoading();
      break;
    case RegistrationLoading:
      OverlayService.showLoading();
      break;
    case UserManagementLoading:
      OverlayService.showLoading();
      break;
    case AuthentictionLoading:
      OverlayService.showLoading();
      break;
    case GroupManagementLoading:
      OverlayService.showLoading();
      break;
    case AdminManagementLoading:
      OverlayService.showLoading();
      break;
    default:
  }
}

updateSessionState({state, context}) {
  log(state.toString());
  switch (state.runtimeType) {
    case AuthentictionFoundSession:
      Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.routeName, (_) => false);
      break;
    case AuthentictionLostSession:
      Navigator.pushNamedAndRemoveUntil(
          context, SignInScreen.routeName, (_) => false);
      break;
    case DashBoardFetched:
     
      break;
    default:
  }
}
