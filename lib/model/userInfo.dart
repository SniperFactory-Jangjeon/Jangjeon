import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserInfo {
  final String name; //이름
  final String? phone; //전화번호
  final String email; //이메일
  final bool optionalAgreement; //마케팅 동의 여부
  int commentCount; //작성한 댓글 수
  final String? photoUrl; //이미지 url

  UserInfo({
    required this.name,
    this.phone,
    required this.email,
    required this.optionalAgreement,
    required this.commentCount,
    this.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'email': email,
      'optionalAgreement': optionalAgreement,
      'commentCount': commentCount,
      'photoUrl': photoUrl,
    };
  }

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      name: map['name'] as String,
      phone: map['phone'] != null ? map['phone'] as String : null,
      email: map['email'] as String,
      optionalAgreement: map['optionalAgreement'] as bool,
      commentCount: map['commentCount'] as int,
      photoUrl: map['photoUrl'] != null ? map['photoUrl'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfo.fromJson(String source) =>
      UserInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}
