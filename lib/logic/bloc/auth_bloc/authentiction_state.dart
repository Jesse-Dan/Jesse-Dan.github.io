import 'package:equatable/equatable.dart';

abstract class AuthentictionState extends Equatable {
  const AuthentictionState();

  @override
  List<Object> get props => [];
}

class AuthentictionInitial extends AuthentictionState {}

class AuthentictionLoading extends AuthentictionState {}

class AuthentictionSuccesful extends AuthentictionState {}

class AuthentictionFailed extends AuthentictionState {
  final String error;

  const AuthentictionFailed(this.error);
}
