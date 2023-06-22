import 'package:equatable/equatable.dart';

abstract class AuthentictionState extends Equatable {
  const AuthentictionState();

  @override
  List<Object> get props => [];
}

class AuthentictionInitial extends AuthentictionState {}

class AuthentictionLoading extends AuthentictionState {}

class AuthentictionSuccesful extends AuthentictionState {}

class PhoneAuthentictionSuccesful extends AuthentictionState {}

class PhoneAuthentictionUnsucessful extends AuthentictionState {}

class OTPSentSuccesful extends AuthentictionState {}

class AuthentictionFailed extends AuthentictionState {
  final String error;

  const AuthentictionFailed(this.error);
}

class AuthentictionLostSession extends AuthentictionState {}

class AuthentictionFoundSession extends AuthentictionState {}

class ForgottenPasswordEmailSentSession extends AuthentictionState {}
