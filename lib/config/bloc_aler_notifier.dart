import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      Navigator.of(context).pop();
      Alertify.error(
          title: 'DashBoard Data Error',
          message:
              'An error occured Loading the dashboard ERROR:${state.error}');
      break;

    case UserManagementFailed:
      Navigator.of(context).pop();
      Alertify.error(
          title: 'DashBoard Data Error',
          message: 'An error occured loading the users ERROR:${state.error}');
      break;
    case RegistrationFailed:
      Navigator.of(context).pop();
      Alertify.error(
          title: 'Registration Error',
          message: 'An error occured, Registering ERROR:${state.error}');
      break;
    case AuthentictionFailed:
      Navigator.of(context).pop();
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
      Navigator.of(context).pop();

      break;
    case GroupManagementFailed:
      Navigator.of(context).pop();
      Alertify.error(
          title: 'Group Management Error',
          message: 'Group ERROR:${state.error}');
      break;
    case NonAdminManagementFailed:
      Navigator.of(context).pop();
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
    /// Success States
    case DashBoardFetched:
      Navigator.of(context).pop();
      break;
    case GroupRegistrationLoaded:
      Alertify.success();
      BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      break;
    case AuthentictionSuccesful:
      Alertify.success();
      break;
    case AdminManagementENABLEDISABLE:
      Alertify.success();
      BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
      Navigator.of(context).pop();
      break;
    case AttendeeRegistrationLoaded:
      Alertify.success();
      BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      break;
    case UserManagementLoaded:
      Alertify.success();
      BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      break;
    case GroupManagementLoaded:
      Alertify.success();
      BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
      Navigator.of(context).pop();
      break;
    case AdminManagemetAltered:
      Alertify.success();
      BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      break;
    case NonAdminManagementLoaded:
      Alertify.success();
      BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
      Navigator.of(context).pop();
      Navigator.of(context).pop();
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
      showDialog(
          context: context,
          builder: (builder) =>
              const Center(child: CircularProgressIndicator()));
      break;
    case NonAdminManagementLoading:
      showDialog(
          context: context,
          builder: (builder) =>
              const Center(child: CircularProgressIndicator()));
      break;
    case RegistrationLoading:
      showDialog(
          context: context,
          builder: (builder) =>
              const Center(child: CircularProgressIndicator()));
      break;
    case UserManagementLoading:
      showDialog(
          context: context,
          builder: (builder) =>
              const Center(child: CircularProgressIndicator()));
      break;
    case AuthentictionLoading:
      // showDialog(
      //   context: context,
      //   builder: (builder) =>
      //     const Center(child: CircularProgressIndicator()));
      break;
    case GroupManagementLoading:
      showDialog(
          context: context,
          builder: (builder) =>
              const Center(child: CircularProgressIndicator()));
      break;
    case AdminManagementLoading:
      showDialog(
          context: context,
          builder: (builder) =>
              const Center(child: CircularProgressIndicator()));
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
      if (!state.user.enabled) {
        Alertify.error(message: 'Your account has been disabled');
        BlocProvider.of<AuthenticationBloc>(context).add(LogoutEvent());
        Navigator.pushNamedAndRemoveUntil(
            context, SignInScreen.routeName, (_) => false);
      }
      break;
    default:
  }
}
