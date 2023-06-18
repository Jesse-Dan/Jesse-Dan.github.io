// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously, unrelated_type_equality_checks

import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyldc_finaalisima/models/recently_deleted_model.dart';
import '../../../config/app_autorizations.dart';
import '../../../config/codes.dart';
import '../../../models/auth_code_model.dart';
import '../../../models/models.dart';
import '../../../presentation/screens/app_views/drawer_items/dashboard/main_screen.dart';
import '../../../presentation/screens/auth_views/login.dart';
import '../../db/db.dart';
import '../../local_storage_service.dart/local_storage.dart';
import 'authentiction_event.dart';
import 'authentiction_state.dart';

class AuthenticationBloc extends Bloc<AuthentictionEvent, AuthentictionState> {
  final FirebaseAuth auth;
  final LocalStorageService localStorageService;

  AuthenticationBloc({required this.auth, required this.localStorageService})
      : super(AuthentictionInitial()) {
    checkAuthenticationStatus();
    login();
    logout();
    signup();
  }

  checkAuthenticationStatus() async {
    on<CheckStatusEvent>((event, emit) async {
      if (auth.currentUser == null) {
        emit(AuthentictionLostSession());
      } else {
        emit(AuthentictionFoundSession());
      }
    });
  }

  login() async {
    on<LoginEvent>((event, emit) async {
      emit(AuthentictionLoading());
      try {
        await auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        var actor = await DB(auth: auth).fetchAdminData();
        await DB(auth: auth).sendNotificationData(
            Notifier.login(data: '${actor.firstName} ${actor.lastName}'));

        Navigator.pushNamedAndRemoveUntil(
            event.context, MainScreen.routeName, (_) => false);
        emit(AuthentictionSuccesful());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          emit(AuthentictionFailed(e.message.toString()));
          log('Invalid email address.');
        } else if (e.code == 'wrong-password') {
          emit(AuthentictionFailed(e.message.toString()));
          log('Incorrect password.');
        } else if (e.code == 'user-not-found') {
          emit(AuthentictionFailed(e.message.toString()));
          log('No user found for that email.');
        } else if (e.code == 'user-disabled') {
          emit(AuthentictionFailed(e.message.toString()));
          log('User account has been disabled.');
        } else if (e.code == 'too-many-requests') {
          emit(AuthentictionFailed(e.message.toString()));
          log('Too many unsuccessful sign-in attempts. Try again later.');
        } else if (e.code == 'operation-not-allowed') {
          emit(AuthentictionFailed(e.message.toString()));
          log('Sign-in method is not enabled.');
        } else if (e.code == 'email-already-in-use') {
          emit(AuthentictionFailed(e.message.toString()));
          log('Email address is already in use.');
        } else {
          emit(AuthentictionFailed(e.message.toString()));
          log('Error occurred while signing in: ${e.message}');
        }
      } catch (e) {
        emit(AuthentictionFailed('type error $e'));
      }
    });
  }

  signup() async {
    on<SignUpEvent>((event, emit) async {
      emit(AuthentictionLoading());
      var data = event.adminModel;
      try {
        log(data.authCode);
        if (await AppAuthorizations(localStorageService: localStorageService)
            .validateAdminAuthCode(data.authCode)) {
          emit(AuthentictionLoading());
          await auth.createUserWithEmailAndPassword(
            email: data.email,
            password: data.password,
          );
          await DB(auth: auth).sendAdminData(AdminModel(
              id: auth.currentUser!.uid,
              lastName: data.lastName,
              email: data.email,
              phoneNumber: data.phoneNumber,
              gender: data.gender,
              dept: data.dept,
              role: data.role,
              authCode: data.authCode,
              password: data.password,
              firstName: data.firstName,
              imageUrl: ''));
          await DB(auth: auth).sendNotificationData(
              Notifier.signUp(data: '${data.firstName} ${data.lastName}'));
          Navigator.pushNamedAndRemoveUntil(
              event.context, SignInScreen.routeName, (_) => false);
          emit(AuthentictionSuccesful());
        } else {
          emit(const AuthentictionFailed(
              'Admin Auth Code is  incorrect Contact Admin for support'));
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          emit(AuthentictionFailed(e.message.toString()));
          log('Invalid email address.');
        } else if (e.code == 'email-already-in-use') {
          emit(AuthentictionFailed(e.message.toString()));
          log('Email address is already in use.');
        } else if (e.code == 'operation-not-allowed') {
          emit(AuthentictionFailed(e.message.toString()));
          log('Sign-up method is not enabled.');
        } else if (e.code == 'weak-password') {
          emit(AuthentictionFailed(e.message.toString()));
          log('Password is too weak.');
        } else {
          emit(AuthentictionFailed(e.message.toString()));
          log('Error occurred while signing up: ${e.message}');
        }
      } catch (e) {
        log("MESINK : $e");
        emit(AuthentictionFailed(e.toString()));
      }
    });
  }

  logout() async {
    on<LogoutEvent>((event, emit) async {
      try {
        emit(AuthentictionLoading());
        await DB(auth: auth).sendNotificationData(
            Notifier.logout(data: 'You ended your session'));
        await auth.signOut().then((value) => log('User Logged Out'));
        emit(AuthentictionSuccesful());
      } on FirebaseAuthException catch (e) {
        emit(AuthentictionFailed(e.message.toString().toUpperCase()));
      } catch (e) {
        emit(AuthentictionFailed(e.toString()));
        log(e.toString());
      }
    });
  }
}
