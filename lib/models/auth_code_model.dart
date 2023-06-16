// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AdminCodesModel {
  final String superAdminCode;
  final String adminCode;
  final String viewerCode;

  AdminCodesModel(
      {required this.superAdminCode,
      required this.adminCode,
      required this.viewerCode});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'superAdminCode': superAdminCode,
      'adminCode': adminCode,
      'viewerCode': viewerCode,
    };
  }

  factory AdminCodesModel.fromMap(Map<String, dynamic> map) {
    return AdminCodesModel(
      superAdminCode: map['superAdminCode'] as String,
      adminCode: map['adminCode'] as String,
      viewerCode: map['viewerCode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminCodesModel.fromJson(String source) =>
      AdminCodesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
