// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class NonAdminModel extends Equatable {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? gender;
  final String? dept;
  final String? role;
  final String? authCode;
  final String? createdBy;
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

// static const empty =  AdminModel(id: '');

//   bool get IsNull => this == AdminModel.empty;
//   bool get IsNotNull => this  = AdminModel.empty;

  @override
  // TODO: implement props
  List<Object> get props => [
        id!,
        lastName!,
        email!,
        phoneNumber!,
        gender!,
        dept!,
        role!,
        authCode!,
        createdBy!,
        firstName!,
        imageUrl,
      ];

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

  factory NonAdminModel.fromMap(Map<String, dynamic> map) {
    return NonAdminModel(
      id: map['id'] != null ? map['id'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      dept: map['dept'] != null ? map['dept'] as String : null,
      role: map['role'] != null ? map['role'] as String : null,
      authCode: map['authCode'] != null ? map['authCode'] as String : null,
      createdBy: map['createdBy'] != null ? map['createdBy'] as String : null,
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NonAdminModel.fromJson(String source) =>
      NonAdminModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
