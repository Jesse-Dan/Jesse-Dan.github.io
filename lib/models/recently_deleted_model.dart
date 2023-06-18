import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'group_model.dart';
import 'non_admin_staff.dart';
import '../../config/date_time_formats.dart';

class RecentlyDeletedModel {
  final String dataType;
  final DateTime? time;
  final String description;
  final String data;

  const RecentlyDeletedModel({
    this.data = '',
    this.time,
    this.description = '',
    this.dataType = '',
  });

  RecentlyDeletedModel.delete(
      {required this.dataType,
      required this.data,
      required this.description,
      this.time});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data,
      'dataType': dataType,
      'time': DateTime.now(),
      'description': description,
    };
  }

  factory RecentlyDeletedModel.fromMap(Map<String, dynamic> map) {
    return RecentlyDeletedModel(
      data: map['data'],
      dataType: map['dataType'] as String,
      time: (map['time'] as Timestamp).toDate(),
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RecentlyDeletedModel.fromJson(String source) =>
      RecentlyDeletedModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
