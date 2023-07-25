import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SocialsModel {
  final List<SocialsUrls> socials;
const  SocialsModel({
    required this.socials,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'socials': socials.map((x) => x.toMap()).toList(),
    };
  }

  factory SocialsModel.fromMap(Map<String, dynamic> map) {
    return SocialsModel(
      socials: List<SocialsUrls>.from(
        (map['socials'] as List).map<SocialsUrls>(
          (x) => SocialsUrls.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialsModel.fromJson(String source) =>
      SocialsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class SocialsUrls {
  final String url;
  final String socialName;
  SocialsUrls({
    required this.url,
    required this.socialName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
      'socialName': socialName,
    };
  }

  factory SocialsUrls.fromMap(Map<String, dynamic> map) {
    return SocialsUrls(
      url: map['url'] as String,
      socialName: map['socialName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialsUrls.fromJson(String source) =>
      SocialsUrls.fromMap(json.decode(source) as Map<String, dynamic>);
}
