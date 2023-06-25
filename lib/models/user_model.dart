// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

AdminModel adminModelFromJson(String str) =>
    AdminModel.fromMap(json.decode(str));

String adminModelToJson(AdminModel data) => json.encode(data.toMap());

class AdminModel extends Equatable {
  final String id;
  final bool enabled;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String gender;
  final String dept;
  final String role;
  final String authCode;
  final String password;
  final String imageUrl;

  const AdminModel({
    required this.enabled,
    required this.id,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.dept,
    required this.role,
    required this.authCode,
    required this.password,
    required this.firstName,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'enabled': enabled,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'dept': dept,
      'role': role,
      'authCode': authCode,
      'password': password,
      'imageUrl': imageUrl,
    };
  }

  factory AdminModel.fromMap(Map<String, dynamic>? map) {
    return AdminModel(
        id: map!['id'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        email: map['email'],
        enabled: map['enabled'],
        phoneNumber: map['phoneNumber'],
        gender: map['gender'],
        dept: map['dept'],
        role: map['role'],
        authCode: map['authCode'],
        password: map['password'],
        imageUrl: map['imageUrl']);
  }


  @override
  // TODO: implement props
  List<Object> get props => [
        id,
        lastName,
        email,
        enabled,
        phoneNumber,
        gender,
        dept,
        role,
        authCode,
        password,
        firstName,
        imageUrl,
      ];
}
