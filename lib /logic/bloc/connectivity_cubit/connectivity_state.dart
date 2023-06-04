part of 'connectivity_cubit.dart';

abstract class ConnectivityState extends Equatable {
  const ConnectivityState();

  @override
  List<Object> get props => [];
}

class ConnectivityInitial extends ConnectivityState {}

class ConnectivityConnected extends ConnectivityState {
  final ConnectionType connectionType;

  ConnectivityConnected({ required this.connectionType});
}

class ConnectivityDisConnected extends ConnectivityState {
  final String error;

  ConnectivityDisConnected(this.error);
}
