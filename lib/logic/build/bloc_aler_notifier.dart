import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyldc_finaalisima/logic/bloc/index_blocs.dart';
import 'package:tyldc_finaalisima/presentation/widgets/alertify.dart';

import '../../presentation/screens/app_views/drawer_items/dashboard/main_screen.dart';
import '../../presentation/screens/auth_views/login.dart';

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
    case RegistrationFailed:
      Navigator.of(context).pop();
      Alertify.error(
          title: 'Registration  Error',
          message: 'An error occured while Registering ERROR:${state.error}');
      break;
    case AuthentictionFailed:
      Navigator.of(context).pop();
      Alertify.error(
          title: 'Authentiction  Error',
          message:
              'An error occured While Authentication ERROR:${state.error}');
      break;
    case GroupManagementFailed:
      Navigator.of(context).pop();
      Alertify.error(
          title: 'Group Management Error',
          message:
              'An error occured While Authentication ERROR:${state.error}');
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
      BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
      Navigator.of(context).pop();
      Navigator.of(context).pop();

      Alertify.success();
      break;
    case AuthentictionSuccesful:
      Alertify.success();
      break;
    case AttendeeRegistrationLoaded:
      BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Alertify.success();
      break;
    case GroupManagementLoaded:
      BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
      Navigator.of(context).pop();
      Alertify.success();
      break;
    case NonAdminRegistrationLoaded:
      BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
      Navigator.of(context).pop();
      Navigator.of(context).pop();

      Alertify.success();
      break;
    default:
  }
}

/// [DISPLAY ERROR ON SPECIFIC LOADING STATE EMITTED]
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
    case RegistrationLoading:
      showDialog(
          context: context,
          builder: (builder) =>
              const Center(child: CircularProgressIndicator()));
      break;
    case AuthentictionLoading:
      showDialog(
          context: context,
          builder: (builder) =>
              const Center(child: CircularProgressIndicator()));
      break;
    case GroupManagementLoading:
      Navigator.of(context).pop();
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
    default:
  }
}
