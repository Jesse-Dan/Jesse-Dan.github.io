// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

import '../../../config/constants/enums.dart';
import '../../../presentation/widgets/alertify.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  bool isConnected = true;
  String status = '';
  final conection = Connectivity();

  late Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;
  ConnectivityCubit({
    required this.connectivity,
  }) : super(ConnectivityInitial()) {
    listenToConnection();
  }

  listenToConnection() {
    conection.onConnectivityChanged.listen((ConnectivityResult result) {
      switch (result) {
        case ConnectivityResult.mobile:
          status = 'Mobile';
          isConnected = true;
          Alertify.success(
              message: 'Internet conection restored using ${status}');
          break;
        case ConnectivityResult.wifi:
          status = 'Wifi';
          isConnected = true;
          Alertify.success(
              message: 'Internet conection restored using ${status}');
          break;
        case ConnectivityResult.none:
          status = 'No Internet';
          isConnected = false;
          Alertify.error(
              message:
                  'Internet conection Lost Please connnect to a stable network and try again ');
          break;
        default:
          status = 'No Internet';
          isConnected = false;
          Alertify.error(
              message:
                  'Internet conection Lost Please connnect to a stable network and try again ');
      }
    });
  }
}
