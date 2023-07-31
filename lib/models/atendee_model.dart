// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
import 'package:equatable/equatable.dart';

class AttendeeModel extends Equatable {
  const AttendeeModel({
    required this.createdBy,
    required this.id,
    this.dob,
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
    this.medicalCondition,
    this.disability,
    this.disabilityTypes,
    this.valuables,
    this.present,
    this.groups,
  });

  final String createdBy;
  final String id;
  final DateTime? dob;
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
  final String? medicalCondition;
  final String? disability;
  final List<String>? disabilityTypes;
  final List<String>? valuables;
  final bool? present;
  final List<String>? groups;

  @override
  List<Object?> get props => [
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
        wouldCamp,
        valuables,
        gender,
        groups,
        disability,
        disabilityTypes,
        medicalCondition,
      ];

  @override
  bool get stringify => true;

  factory AttendeeModel.fromMap(Map<String, dynamic> map) {
    return AttendeeModel(
      createdBy: map['createdBy'] as String,
      id: map['id'] as String,
      dob: map['dob'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dob'] as int)
          : null,
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
      medicalCondition: map['medicalCondition'] as String?,
      disability: map['disability'] as String?,
      disabilityTypes:
          (map['disabilityTypes'] as List<dynamic>?)?.cast<String>(),
      valuables: (map['valuables'] as List<dynamic>?)?.cast<String>(),
      present: map['present'] as bool?,
      groups: (map['groups'] as List<dynamic>?)?.cast<String>(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdBy': createdBy,
      'id': id,
      'dob': dob?.millisecondsSinceEpoch,
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
      'medicalCondition': medicalCondition,
      'disability': disability,
      'disabilityTypes': disabilityTypes,
      'valuables': valuables,
      'present': present,
      'groups': groups,
    };
  }

  String toJson() => json.encode(toMap());

  factory AttendeeModel.fromJson(String source) =>
      AttendeeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  AttendeeModel copyWith({
    String? createdBy,
    String? id,
    DateTime? dob,
    String? firstName,
    String? middleName,
    String? lastName,
    String? gender,
    String? phoneNo,
    String? parentName,
    String? parentNo,
    String? homeAddress,
    String? disabilityCluster,
    String? commitmentFee,
    String? parentConsent,
    String? passIssued,
    String? wouldCamp,
    String? medicalCondition,
    String? disability,
    List<String>? disabilityTypes,
    List<String>? valuables,
    bool? present,
    List<String>? groups,
  }) {
    return AttendeeModel(
      createdBy: createdBy ?? this.createdBy,
      id: id ?? this.id,
      dob: dob ?? this.dob,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      phoneNo: phoneNo ?? this.phoneNo,
      parentName: parentName ?? this.parentName,
      parentNo: parentNo ?? this.parentNo,
      homeAddress: homeAddress ?? this.homeAddress,
      disabilityCluster: disabilityCluster ?? this.disabilityCluster,
      commitmentFee: commitmentFee ?? this.commitmentFee,
      parentConsent: parentConsent ?? this.parentConsent,
      passIssued: passIssued ?? this.passIssued,
      wouldCamp: wouldCamp ?? this.wouldCamp,
      medicalCondition: medicalCondition ?? this.medicalCondition,
      disability: disability ?? this.disability,
      disabilityTypes: disabilityTypes ?? this.disabilityTypes,
      valuables: valuables ?? this.valuables,
      present: present ?? this.present,
      groups: groups ?? this.groups,
    );
  }
}
