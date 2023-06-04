// To parse this JSON data, do
//
//     final groupModel = groupModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'atendee_model.dart';

class GroupModel {
  final String lea
  final String id;
  final String name;
  final String description;
  final List<dynamic> groupMembers;
  final String createdBy;

  GroupModel({
    required this.id,
    required this.name,
    required this.description,
    required this.groupMembers,
    required this.createdBy,
  });

  GroupModel copyWith({
    String? name,
    String? description,
    List<AttendeeModel>? groupMembers,
    String? id,
    String? createdBy,
  }) =>
      GroupModel(
        name: name ?? this.name,
        description: description ?? this.description,
        groupMembers: groupMembers ?? this.groupMembers,
        id: this.id,
        createdBy: this.createdBy,
      );

  factory GroupModel.fromRawJson(String str) =>
      GroupModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
        name: json["name"],
        description: json["description"],
        groupMembers: List<dynamic>.from(json["group_members"].map((x) => x)),
        id: json['id'],
        createdBy: json['createdBy'],
      );

  Map<String, dynamic> toJson() => {
        'createdBy': createdBy,
        "id": id,
        "name": name,
        "description": description,
        "group_members": List<dynamic>.from(groupMembers.map((x) => x)),
      };
}
