// To parse this JSON data, do
//
//     final attendeeModel = attendeeModelFromJson(json  String);

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

AttendeeModel attendeeModelFromJson(String str) =>
    AttendeeModel.fromJson(json.decode(str));

String attendeeModelToJson(AttendeeModel data) => json.encode(data.toJson());

class AttendeeModel extends Equatable {
  const AttendeeModel({
    required this.createdBy,
    required this.id,
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

  factory AttendeeModel.fromJson(Map<String, dynamic>? json) => AttendeeModel(
        createdBy: json!["createdBy"],
        id: json["id"],
        firstName: json["firstName"],
        middleName: json["middleName"],
        lastName: json["lastName"],
        gender: json["gender"],
        phoneNo: json["phoneNo"],
        parentName: json["parentName"],
        parentNo: json["parentNo"],
        homeAddress: json["homeAddress"],
        disabilityCluster: json["disabilityCluster"],
        commitmentFee: json["commitmentFee"],
        parentConsent: json["parentConsent"],
        passIssued: json["passIssued"],
        wouldCamp: json["wouldCamp"],
      );

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "id": id,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "gender": gender,
        "phoneNo": phoneNo,
        "parentName": parentName,
        "parentNo": parentNo,
        "homeAddress": homeAddress,
        "disabilityCluster": disabilityCluster,
        "commitmentFee": commitmentFee,
        "parentConsent": parentConsent,
        "passIssued": passIssued,
        "wouldCamp": wouldCamp,
      };
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
}
