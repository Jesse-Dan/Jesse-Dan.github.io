import 'package:equatable/equatable.dart';
import 'package:tyldc_finaalisima/models/contact_us_model.dart';
import 'package:tyldc_finaalisima/models/socials_model.dart';

abstract class ContactUsState extends Equatable {
  ContactUsState();

  @override
  List<Object> get props => [];
}

/// Initial
class InitialContactUsState extends ContactUsState {
  InitialContactUsState();

  @override
  String toString() => 'UnContactUsState';
}

/// Loaded
class LoadingContactUsState extends ContactUsState {
  LoadingContactUsState(this.hello);

  final String hello;

  @override
  String toString() => 'InContactUsState $hello';

  @override
  List<Object> get props => [hello];
}


/// Loaded
class LoadedContactUsState extends ContactUsState {
  LoadedContactUsState(this.data);

  final String data;

  @override
  String toString() => 'InContactUsState $data';

  @override
  List<Object> get props => [data];
}

/// Loaded
class ContactUsMessagesLoadedContactUsState extends ContactUsState {
  ContactUsMessagesLoadedContactUsState(this.contactMessages);

  final List<ContactUsModel> contactMessages;

  @override
  String toString() => 'InContactUsState $contactMessages';

  @override
  List<Object> get props => [contactMessages];
}

/// Loaded
class SocialsLoadedContactUsState extends ContactUsState {
  SocialsLoadedContactUsState(this.socials);

  final SocialsModel socials;

  @override
  String toString() => 'InContactUsState $socials';

  @override
  List<Object> get props => [socials];
}

class ErrorContactUsState extends ContactUsState {
  ErrorContactUsState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorContactUsState';

  @override
  List<Object> get props => [errorMessage];
}
