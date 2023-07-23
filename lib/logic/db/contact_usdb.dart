import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:tyldc_finaalisima/models/contact_us_model.dart';
import 'package:tyldc_finaalisima/models/socials_model.dart';

class ContactUsDB {
  final FirebaseAuth auth;
  final contactUsDB = FirebaseFirestore.instance.collection('ContactMessages');
  final socialsDB = FirebaseFirestore.instance.collection('SocialsUrls');
  ContactUsDB({required this.auth});

  var format = DateFormat.yMMMEd();
  List getAttendeeDocIds = [];

  /// [SEND SOCIALS URLS]
  Future<void> sendNewUrls({SocialsModel? socials}) async {
    try {
      await socialsDB
          .doc('socials')
          .set(socials!.toMap())
          .then((value) => log('Socials Created'));
    } on FirebaseException catch (e) {
      log('error on send urls db:$e');
    }
  }

  /// [SEND CONTACT US MESSAGE]
  Future<void> sendContactuUsMessage({required ContactUsModel contactmessage}) async {
    try {
      await contactUsDB
          .doc('${contactmessage.name}_${contactmessage.email}')
          .set(contactmessage
              .toMap())
          .then((value) => log('Contact Message Sent Created'));
    } on FirebaseException catch (e) {
      log('error on send contact db:$e');
    }
  }

  ///[GET CONTACT US MEASSAGES]
  Future<List<ContactUsModel>> getContactUsMessage() async {
    try {
      var contactMessages = await contactUsDB.get();
      var data = contactMessages.docs
          .map((e) => ContactUsModel.fromMap(e.data()))
          .toList();
      log(data.toString());
      return data;
    } catch (e) {
      log('error on get contact db:$e');
      return [];
    }
  }

  ///[GET SOCIALS URLS]
  Future<SocialsModel?> getSocialsUrls() async {
    try {
      var socials = await socialsDB.doc('socials').get();
      var data = SocialsModel.fromMap(socials.data()!);
      log(data.toString());
      return data;
    } catch (e) {
      log('error on get socials db:$e');
      return null;
    }
  }
}
