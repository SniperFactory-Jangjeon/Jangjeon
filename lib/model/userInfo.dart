import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserInfo {
  String name; //이름
  final String phone; //전화번호
  final String email; //이메일
  final bool optionalAgreement;
  final String? photoUrl;

  UserInfo({
    required this.name,
    required this.phone,
    required this.email,
    required this.optionalAgreement,
    this.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'email': email,
      'optionalAgreement': optionalAgreement,
      'photoUrl': photoUrl,
    };
  }

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      name: map['name'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      optionalAgreement: map['optionalAgreement'] as bool,
      photoUrl: map['photoUrl'] != null ? map['photoUrl'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfo.fromJson(String source) =>
      UserInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}
