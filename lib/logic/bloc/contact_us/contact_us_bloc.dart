import 'dart:developer' as developer;
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../local_storage_service.dart/local_storage.dart';
import 'contact_us_event.dart';
import 'contact_us_state.dart';

class ContactUsBloc extends Bloc<ContactUsEvent, ContactUsState> {
  final LocalStorageService localStorageService;
  final FirebaseAuth auth;
  final FirebaseStorage storage;

  ContactUsBloc(
      {required this.localStorageService,
      required this.auth,
      required this.storage,
      required ContactUsState initialState})
      : super(initialState) {
    on<ContactUsEvent>((event, emit) {
      return emit.forEach<ContactUsState>(
        event.applyAsync(currentState: state, bloc: this,auth: auth,localStorageService: localStorageService),
        onData: (state) => state,
        onError: (error, stackTrace) {
          developer.log('$error',
              name: 'ContactUsBloc', error: error, stackTrace: stackTrace);
          return ErrorContactUsState(error.toString());
        },
      );
    });
  }
}
