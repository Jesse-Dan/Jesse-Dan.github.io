// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously, unrelated_type_equality_checks

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/app_autorizations.dart';
import '../../../models/models.dart';
import '../../db/admindb.dart';
import '../../db/utilsdb.dart';
import '../../local_storage_service.dart/local_storage.dart';
import 'authentiction_event.dart';
import 'authentiction_state.dart';

class AuthenticationBloc extends Bloc<AuthentictionEvent, AuthentictionState> {
  final FirebaseAuth auth;
  final LocalStorageService localStorageService;
  String verificationIdValue = '';
  String smsCodeValue = '';
  bool doing = false;

  AuthenticationBloc({required this.auth, required this.localStorageService})
      : super(AuthentictionInitial()) {
    checkAuthenticationStatus();
    login();
    logout();
    signup();
    verifPhoneNumber();
    signInWithPhoneNumber();
    forgottenPassword();
    updatePhoneNumber();
  }

  checkAuthenticationStatus() async {
    on<CheckStatusEvent>((event, emit) async {
      try {
        if (auth.currentUser == null) {
          emit(AuthentictionLostSession());
        } else {
          emit(AuthentictionFoundSession());
        }
      } on FirebaseAuthException catch (e) {
        if (e.message == 'user-disabled') {
          emit(AuthentictionFailed(e.message.toString()));
          log('Account Dissabled');
        }
      } catch (e) {
        emit(AuthentictionFailed(e.toString()));
        log('Incorrect password.');
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
        await UtilsDB(auth: auth).sendNotificationData(
            Notifier.login(data: '${actor.firstName} ${actor.lastName}'));

        emit(AuthentictionSuccesful());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email' || e.code == 'permission-denied') {
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
          log('Login Error${e.message}');
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
        if (AppAuthorizations(localStorageService: localStorageService)
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
              enabled: data.enabled,
              phoneNumber: data.phoneNumber,
              gender: data.gender,
              dept: data.dept,
              role: data.role,
              authCode: data.authCode,
              password: data.password,
              firstName: data.firstName,
              imageUrl: ''));
          await UtilsDB(auth: auth).sendNotificationData(
              Notifier.signUp(data: '${data.firstName} ${data.lastName}'));
          emit(AuthentictionSuccesful());
        } else {
          emit(const AuthentictionFailed(
              'Admin Auth Code is  incorrect Contact Admin for support'));
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email' || e.code == 'permission-denied') {
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
        if (doing) {
          doing = true;
          emit(AuthentictionLoading());
          await UtilsDB(auth: auth).sendNotificationData(
              Notifier.logout(data: 'You ended your session'));
          await auth.signOut().then((value) => log('User Logged Out'));
          emit(AuthentictionSuccesful());
          doing = false;
        }
      } on FirebaseAuthException catch (e) {
        emit(AuthentictionFailed(e.message.toString().toUpperCase()));
      } catch (e) {
        emit(AuthentictionFailed(e.toString()));
        log(e.toString());
      }
    });
  }

  verifPhoneNumber() {
    on<SendOtpEvent>((event, emit) async {
      try {
        emit(AuthentictionLoading());
        await auth.verifyPhoneNumber(
          phoneNumber:
              '+234${event.phoneNumber}', // Replace with your phone number
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        );
        emit(OTPSentSuccesful());
      } on FirebaseAuthException catch (error) {
        if (error.message == 'invalid-phone-number' ||
            error.message == 'permission-denied') {
          emit(PhoneAuthentictionUnsucessful());
        } else if (error.message == 'invalid-verification-cod') {
          emit(AuthentictionFailed(error.toString()));
        } else if (error.message == 'code-expired') {
          emit(AuthentictionFailed(error.toString()));
        } else {
          emit(AuthentictionFailed(error.toString()));
        }
        log(error.toString());
      } catch (e) {
        emit(AuthentictionFailed(e.toString()));
        log(e.toString());
      }
    });
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    log('Phone number automatically verified and user signed in.');
  }

  void verificationFailed(FirebaseAuthException exception) {
    log('Phone number verification failed. Error: ${exception.message}');
  }

  void codeSent(String verificationId, int? resendToken) {
    verificationIdValue = verificationId;
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    verificationIdValue = verificationId;
  }

  void signInWithPhoneNumber() async {
    on<VerifyOtpAndLoginInEvent>((event, emit) async {
      emit(AuthentictionLoading());

      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationIdValue,
            smsCode: (event.otp).toString());
        await auth.signInWithCredential(credential);
        emit(PhoneAuthentictionSuccesful());
        log('User signed in with phone number successfully.');
      } on FirebaseAuthException catch (e) {
        emit(AuthentictionFailed(e.toString()));
        log('Failed to sign in with phone number. Error: $e');
      } catch (e) {
        emit(AuthentictionFailed(e.toString()));
        log('Failed to sign in with phone number. Error: $e');
      }
    });
  }

  forgottenPassword() {
    on<ForgottenPasswordEvent>((event, emit) async {
      try {
        emit(AuthentictionLoading());
        await auth.sendPasswordResetEmail(email: event.email);
        emit(ForgottenPasswordEmailSent());
      } on FirebaseAuthException catch (e) {
        if (e.message == 'auth/missing-email') {
          emit(const AuthentictionFailed('Please enter an email'));
        } else {
          emit(AuthentictionFailed(e.toString()));
          log('failed to send password reset email. Error: ${e.message}');
        }
      } catch (e) {
        emit(AuthentictionFailed(e.toString()));
        log('failed to send password reset email. Error: $e');
      }
    });
  }

  updatePhoneNumber() {
    on<UpdateNumberEvent>((event, emit) async {
      try {
        emit(AuthentictionLoading());
        await DB(auth: auth)
            .updateAdminData(
                auth: auth, newData: event.phoneNumber, field: 'phoneNumber')
            .then((value) => BlocProvider.of<AuthenticationBloc>(event.context)
                .add(SendOtpEvent(int.parse(event.phoneNumber))));

        emit(MobileNumberUpdateSuccessfully());
      } on FirebaseAuthException catch (e) {
        emit(AuthentictionFailed(e.toString()));
        log('failed to update phone number. Error: ${e.message}');
      } catch (e) {
        emit(AuthentictionFailed(e.toString()));
        log('failed to  update phone number. Error: $e');
      }
    });
  }
}
