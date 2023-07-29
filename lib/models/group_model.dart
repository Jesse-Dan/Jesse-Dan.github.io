// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final groupModel = groupModelFromJson(jsonString);

import 'dart:convert';

import 'atendee_model.dart';

class GroupModel {
  // final String lea
  String id;
  final String name;
  final String description;
  final List<AttendeeModel> groupMembers;
  final String createdBy;
  final String facilitator;

  GroupModel({
    required this.facilitator,
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
        facilitator: '',
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'groupMembers': groupMembers.map((x) => x.toJson()).toList(),
      'createdBy': createdBy,
      'facilitator': facilitator,
    };
  }

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      groupMembers: List<AttendeeModel>.from(
        (map['groupMembers'] as List<dynamic>).map<AttendeeModel>(
          (x) => AttendeeModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      createdBy: map['createdBy'] as String,
      facilitator: map['facilitator'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupModel.fromJson(String source) =>
      GroupModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
