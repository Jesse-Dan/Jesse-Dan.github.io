import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ContactUsModel {
  final String name;
  final String phoneNumber;
  final String email;
  final String subject;
  final String message;
  final String id;

  final DateTime timeStamp;
  ContactUsModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.subject,
    required this.message,
    required this.timeStamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'subject': subject,
      'message': message,
      'timeStamp': timeStamp.millisecondsSinceEpoch,
      'id': id,
    };
  }

  factory ContactUsModel.fromMap(Map<String, dynamic> map) {
    return ContactUsModel(
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      email: map['email'] as String,
      subject: map['subject'] as String,
      message: map['message'] as String,
      timeStamp: DateTime.fromMillisecondsSinceEpoch(map['timeStamp'] as int),
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactUsModel.fromJson(String source) =>
      ContactUsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ContactUsModel(name: $name, phoneNumber: $phoneNumber, email: $email, subject: $subject, message: $message, timeStamp: $timeStamp)';
  }

  ContactUsModel copyWith({
    String? name,
    String? phoneNumber,
    String? email,
    String? subject,
    String? message,
    DateTime? timeStamp,
    String? id,
  }) {
    return ContactUsModel(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      id: id ?? this.id,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }
}
