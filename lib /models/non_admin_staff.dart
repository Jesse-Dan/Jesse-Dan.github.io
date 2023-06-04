// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

NonAdminModel adminModelFromJson(String str) =>
    NonAdminModel.fromMap(json.decode(str));

String adminModelToJson(NonAdminModel data) => json.encode(data.toMap());

class NonAdminModel extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String gender;
  final String dept;
  final String role;
  final String authCode;
  final String createdBy;
  final String imageUrl;

  const NonAdminModel({
    required this.id,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.dept,
    required this.role,
    required this.authCode,
    required this.createdBy,
    required this.firstName,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'dept': dept,
      'role': role,
      'authCode': authCode,
      'createdBy': createdBy,
      'imageUrl': imageUrl,
    };
  }

  factory NonAdminModel.fromMap(Map<String, dynamic>? map) {
    return NonAdminModel(
        id: map!['id'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        email: map['email'],
        phoneNumber: map['phoneNumber'],
        gender: map['gender'],
        dept: map['dept'],
        role: map['role'],
        authCode: map['authCode'],
        createdBy: map['password'],
        imageUrl: map['imageUrl']);
  }

// static const empty =  AdminModel(id: '');

//   bool get IsNull => this == AdminModel.empty;
//   bool get IsNotNull => this  = AdminModel.empty;

  @override
  // TODO: implement props
  List<Object> get props => [
        id,
        lastName,
        email,
        phoneNumber,
        gender,
        dept,
        role,
        authCode,
        createdBy,
        firstName,
        imageUrl,
      ];
}
