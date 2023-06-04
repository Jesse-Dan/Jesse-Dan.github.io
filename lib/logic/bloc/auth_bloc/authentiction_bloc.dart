import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/codes.dart';
import '../../../models/models.dart';
import '../../db/db.dart';
import 'authentiction_event.dart';
import 'authentiction_state.dart';

class AuthenticationBloc extends Bloc<AuthentictionEvent, AuthentictionState> {
  final FirebaseAuth auth;

  AuthenticationBloc({required this.auth}) : super(AuthentictionInitial()) {
    checkAuthenticationStatus();
    login();
    logout();
    signup();
  }

  void checkAuthenticationStatus() async {
    on<CheckStatusEvent>((event, emit) {
      emit(AuthentictionLoading());

      if (auth != null) {
        emit(AuthentictionSuccesful());
      } else {
        emit(AuthentictionFailed(CONTACT_ADMIN));
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
        emit(AuthentictionSuccesful());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          emit(AuthentictionFailed(e.message.toString()));
          print('Invalid email address.');
        } else if (e.code == 'wrong-password') {
          emit(AuthentictionFailed(e.message.toString()));
          print('Incorrect password.');
        } else if (e.code == 'user-not-found') {
          emit(AuthentictionFailed(e.message.toString()));
          // There is no user corresponding to the email address.
          print('No user found for that email.');
        } else if (e.code == 'user-disabled') {
          emit(AuthentictionFailed(e.message.toString()));
          // The user account has been disabled by an administrator.
          print('User account has been disabled.');
        } else if (e.code == 'too-many-requests') {
          emit(AuthentictionFailed(e.message.toString()));

          // There have been too many unsuccessful sign-in attempts.
          print('Too many unsuccessful sign-in attempts. Try again later.');
        } else if (e.code == 'operation-not-allowed') {
          emit(AuthentictionFailed(e.message.toString()));

          // The requested sign-in method is not enabled for the Firebase project.
          print('Sign-in method is not enabled.');
        } else if (e.code == 'email-already-in-use') {
          emit(AuthentictionFailed(e.message.toString()));

          // The email address is already associated with a different user account.
          print('Email address is already in use.');
        } else {
          emit(AuthentictionFailed(e.message.toString()));

          // Handle other exceptions.
          print('Error occurred while signing in: ${e.message}');
        }
      } catch (e) {
        emit(AuthentictionFailed('type error ' + e.toString()));
      }
    });
}

  signup() async {
    on<SignUpEvent>((event, emit) async {
      emit(AuthentictionLoading());

      var data = event.adminModel;
      try {
        if (data.authCode == ADMIN_AUTH_CODE) {
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
          emit(AuthentictionSuccesful());
        } else {
          emit(AuthentictionFailed(
              'Admin Auth Code is  incorrect Contact Admin for support'));
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          emit(AuthentictionFailed(e.message.toString()));

          // The email address is invalid.
          print('Invalid email address.');
        } else if (e.code == 'email-already-in-use') {
          emit(AuthentictionFailed(e.message.toString()));

          // The email address is already associated with a different user account.
          print('Email address is already in use.');
        } else if (e.code == 'operation-not-allowed') {
          emit(AuthentictionFailed(e.message.toString()));

          // The requested sign-up method is not enabled for the Firebase project.
          print('Sign-up method is not enabled.');
        } else if (e.code == 'weak-password') {
          emit(AuthentictionFailed(e.message.toString()));

          // The password is too weak.
          print('Password is too weak.');
        } else {
          emit(AuthentictionFailed(e.message.toString()));

          // Handle other exceptions.
          print('Error occurred while signing up: ${e.message}');
        }
      } catch (e) {
        log(e.toString());
        emit(AuthentictionFailed(e.toString()));
      }
    });
  }

  logout() async {
    on<LogoutEvent>((event, emit) async {
      try {
        emit(AuthentictionLoading());
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
