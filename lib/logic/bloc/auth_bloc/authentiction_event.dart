import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../models/models.dart';

class AuthentictionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthentictionEvent {
  final String email;
  final String password;

  LoginEvent(
      {AdminModel? adminModel, required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}

class SignUpEvent extends AuthentictionEvent {
  final AdminModel adminModel;

  SignUpEvent({
    required this.adminModel,
  });
  @override
  List<Object> get props => [adminModel];
}

class LogoutEvent extends AuthentictionEvent {
  LogoutEvent();
  @override
  List<Object> get props => [];
}

class CheckStatusEvent extends AuthentictionEvent {
  CheckStatusEvent(
    AdminModel adminModel,
  );
  @override
  List<Object> get props => [];
}
