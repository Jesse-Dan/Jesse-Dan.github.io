// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer' as developer;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import 'package:tyldc_finaalisima/logic/db/contact_usdb.dart';
import 'package:tyldc_finaalisima/models/socials_model.dart';

import '../../../models/contact_us_model.dart';
import '../../local_storage_service.dart/local_storage.dart';
import 'contact_us_bloc.dart';
import 'contact_us_state.dart';

@immutable
abstract class ContactUsEvent {
  Stream<ContactUsState> applyAsync(
      {ContactUsState? currentState,
      ContactUsBloc? bloc,
      required FirebaseAuth auth,
      required LocalStorageService localStorageService}) async* {
    yield InitialContactUsState();
  }
}

class SendSocialsUrlsContactUsEvent extends ContactUsEvent {
  @override
  Stream<ContactUsState> applyAsync(
      {ContactUsState? currentState,
      ContactUsBloc? bloc,
      required FirebaseAuth auth,
      required LocalStorageService localStorageService}) async* {
    try {
      yield LoadingContactUsState('loading');
      await ContactUsDB(auth: auth).sendNewUrls();
      yield LoadedContactUsState('Url Sent');
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'SendSocialsUrlsEvent', error: _, stackTrace: stackTrace);
      yield ErrorContactUsState(_.toString());
    }
  }
}

class SendContactUsMessageEvent extends ContactUsEvent {
  final ContactUsModel contactUsModel;
  SendContactUsMessageEvent({
    required this.contactUsModel,
  });
  @override
  Stream<ContactUsState> applyAsync(
      {ContactUsState? currentState,
      ContactUsBloc? bloc,
      required FirebaseAuth auth,
      required LocalStorageService localStorageService}) async* {
    try {
      yield LoadingContactUsState('loading');
      await ContactUsDB(auth: auth)
          .sendContactuUsMessage(contactmessage: contactUsModel);
      yield LoadedContactUsState('Url Sent');
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'SendSocialsUrlsEvent', error: _, stackTrace: stackTrace);
      yield ErrorContactUsState(_.toString());
    }
  }
}

class GetContactUsMessageEvent extends ContactUsEvent {
  @override
  Stream<ContactUsState> applyAsync(
      {ContactUsState? currentState,
      ContactUsBloc? bloc,
      required FirebaseAuth auth,
      required LocalStorageService localStorageService}) async* {
    try {
      yield LoadingContactUsState('loading');
      var data = await ContactUsDB(auth: auth).getContactUsMessage();
      yield ContactUsMessagesLoadedContactUsState(data);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'SendSocialsUrlsEvent', error: _, stackTrace: stackTrace);
      yield ErrorContactUsState(_.toString());
    }
  }
}

class GetSocialEvent extends ContactUsEvent {
  @override
  Stream<ContactUsState> applyAsync(
      {ContactUsState? currentState,
      ContactUsBloc? bloc,
      required FirebaseAuth auth,
      required LocalStorageService localStorageService}) async* {
    try {
      yield LoadingContactUsState('loading');
      var data = await ContactUsDB(auth: auth).getSocialsUrls();
      yield SocialsLoadedContactUsState(data!);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'SendSocialsUrlsEvent', error: _, stackTrace: stackTrace);
      yield ErrorContactUsState(_.toString());
    }
  }
}

class DeleteContactMessagelEvent extends ContactUsEvent {
  final ContactUsModel contactUsModel;
  DeleteContactMessagelEvent({
    required this.contactUsModel,
  });
  
  @override
  Stream<ContactUsState> applyAsync(
      {ContactUsState? currentState,
      ContactUsBloc? bloc,
      required FirebaseAuth auth,
      required LocalStorageService localStorageService}) async* {
    try {
      yield LoadingContactUsState('loading');
      await ContactUsDB(auth: auth)
          .deleteContactMessage(contactmessage: contactUsModel);
      yield LoadedContactUsState('Done');
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'SendSocialsUrlsEvent', error: _, stackTrace: stackTrace);
      yield ErrorContactUsState(_.toString());
    }
  }
}



class UpdateSocialsEvent extends ContactUsEvent {
  final SocialsUrls contactUsModel;
  UpdateSocialsEvent({
    required this.contactUsModel,
  });
  
  @override
  Stream<ContactUsState> applyAsync(
      {ContactUsState? currentState,
      ContactUsBloc? bloc,
      required FirebaseAuth auth,
      required LocalStorageService localStorageService}) async* {
    try {
      yield LoadingContactUsState('loading');
      await ContactUsDB(auth: auth)
          .alterUrlsCode(newValue: contactUsModel);
      yield LoadedContactUsState('Done');
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'SendSocialsUrlsEvent', error: _, stackTrace: stackTrace);
      yield ErrorContactUsState(_.toString());
    }
  }
}
