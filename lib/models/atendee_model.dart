// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final attendeeModel = attendeeModelFromJson(json  String);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

// AttendeeModel attendeeModelFromJson(String str) =>
//     AttendeeModel.fromJson(json.decode(str));

// String attendeeModelToJson(AttendeeModel data) => json.encode(data.toJson());

class AttendeeModel extends Equatable {
  const AttendeeModel({
    required this.createdBy,
    required this.id,
    required this.dob,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.gender,
    required this.phoneNo,
    required this.parentName,
    required this.parentNo,
    required this.homeAddress,
    required this.disabilityCluster,
    required this.commitmentFee,
    required this.parentConsent,
    required this.passIssued,
    required this.wouldCamp,
  });
  final String createdBy;
  final String id;
  final DateTime dob;
  final String firstName;
  final String middleName;
  final String lastName;
  final String gender;
  final String phoneNo;
  final String parentName;
  final String parentNo;
  final String homeAddress;
  final String disabilityCluster;
  final String commitmentFee;
  final String parentConsent;
  final String passIssued;
  final String wouldCamp;

  // factory AttendeeModel.fromJson(Map<String, dynamic>? json) => AttendeeModel(
  //       createdBy: json!["createdBy"],
  //       id: json["id"],
  //       firstName: json["firstName"],
  //       middleName: json["middleName"],
  //       lastName: json["lastName"],
  //       gender: json["gender"],
  //       phoneNo: json["phoneNo"],
  //       parentName: json["parentName"],
  //       parentNo: json["parentNo"],
  //       homeAddress: json["homeAddress"],
  //       disabilityCluster: json["disabilityCluster"],
  //       commitmentFee: json["commitmentFee"],
  //       parentConsent: json["parentConsent"],
  //       passIssued: json["passIssued"],
  //       wouldCamp: json["wouldCamp"],
  //     );

  // Map<String, dynamic> toJson() => {
  //       "createdBy": createdBy,
  //       "id": id,
  //       "firstName": firstName,
  //       "middleName": middleName,
  //       "lastName": lastName,
  //       "gender": gender,
  //       "phoneNo": phoneNo,
  //       "parentName": parentName,
  //       "parentNo": parentNo,
  //       "homeAddress": homeAddress,
  //       "disabilityCluster": disabilityCluster,
  //       "commitmentFee": commitmentFee,
  //       "parentConsent": parentConsent,
  //       "passIssued": passIssued,
  //       "wouldCamp": wouldCamp,
  // };
  // static const empty = AttendeeModel(id: '');

  // bool get IsNull => this == AttendeeModel.empty;
  // bool get IsNotNull => this != AttendeeModel.empty;

  @override
  List<Object> get props => [
        id,
        firstName,
        middleName,
        lastName,
        gender,
        parentNo,
        parentName,
        homeAddress,
        disabilityCluster,
        commitmentFee,
        parentConsent,
        passIssued,
        wouldCamp
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdBy': createdBy,
      'id': id,
      'dob': dob,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'gender': gender,
      'phoneNo': phoneNo,
      'parentName': parentName,
      'parentNo': parentNo,
      'homeAddress': homeAddress,
      'disabilityCluster': disabilityCluster,
      'commitmentFee': commitmentFee,
      'parentConsent': parentConsent,
      'passIssued': passIssued,
      'wouldCamp': wouldCamp,
    };
  }

  factory AttendeeModel.fromMap(Map<String, dynamic> map) {
    return AttendeeModel(
      createdBy: map['createdBy'] as String,
      id: map['id'] as String,
      dob: (map['dob'] as Timestamp).toDate(),
      firstName: map['firstName'] as String,
      middleName: map['middleName'] as String,
      lastName: map['lastName'] as String,
      gender: map['gender'] as String,
      phoneNo: map['phoneNo'] as String,
      parentName: map['parentName'] as String,
      parentNo: map['parentNo'] as String,
      homeAddress: map['homeAddress'] as String,
      disabilityCluster: map['disabilityCluster'] as String,
      commitmentFee: map['commitmentFee'] as String,
      parentConsent: map['parentConsent'] as String,
      passIssued: map['passIssued'] as String,
      wouldCamp: map['wouldCamp'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendeeModel.fromJson(String source) =>
      AttendeeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
