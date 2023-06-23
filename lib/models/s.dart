// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

class TemplateParams {
  final String? fromName;
  final String? fromEmail;
  final String? total;
  final String? image;
  final String? size;
  final String? quantity;
  final String? price;

  TemplateParams({
    this.fromName,
    this.fromEmail,
    this.total,
    this.image,
    this.size,
    this.quantity,
    this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fromName': fromName,
      'fromEmail': fromEmail,
      'total': total,
      'image': image,
      'size': size,
      'quantity': quantity,
      'price': price,
    };
  }

  factory TemplateParams.fromMap(Map<String, dynamic> map) {
    return TemplateParams(
      fromName: map['fromName'] != null ? map['fromName'] as String : null,
      fromEmail: map['fromEmail'] != null ? map['fromEmail'] as String : null,
      total: map['total'] != null ? map['total'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      size: map['size'] != null ? map['size'] as String : null,
      quantity: map['quantity'] != null ? map['quantity'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TemplateParams.fromJson(String source) =>
      TemplateParams.fromMap(json.decode(source) as Map<String, dynamic>);
}

