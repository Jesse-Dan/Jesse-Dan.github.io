import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ContactUsModel {
  final String name;
  final String phoneNumber;
  final String email;
  final String subject;
  final String message;
  ContactUsModel({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.subject,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'subject': subject,
      'message': message,
    };
  }

  factory ContactUsModel.fromMap(Map<String, dynamic> map) {
    return ContactUsModel(
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      email: map['email'] as String,
      subject: map['subject'] as String,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactUsModel.fromJson(String source) =>
      ContactUsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ContactUsModel copyWith({
    String? name,
    String? phoneNumber,
    String? email,
    String? subject,
    String? message,
  }) {
    return ContactUsModel(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      subject: subject ?? this.subject,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return 'ContactUsModel(name: $name, phoneNumber: $phoneNumber, email: $email, subject: $subject, message: $message)';
  }

  @override
  bool operator ==(covariant ContactUsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.phoneNumber == phoneNumber &&
      other.email == email &&
      other.subject == subject &&
      other.message == message;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      phoneNumber.hashCode ^
      email.hashCode ^
      subject.hashCode ^
      message.hashCode;
  }
}
