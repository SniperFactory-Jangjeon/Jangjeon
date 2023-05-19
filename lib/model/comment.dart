// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:jangjeon/model/userInfo.dart';

class Comment {
  final String comment; //댓글 내용
  final UserInfo userInfo; //유저 정보
  final DateTime createdAt; //생성 날짜

  Comment({
    required this.comment,
    required this.userInfo,
    required this.createdAt,
  });

  Map<String, dynamic> toMap(DocumentReference userRef) {
    return <String, dynamic>{
      'comment': comment,
      'userInfo': userRef,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      comment: map['comment'] as String,
      userInfo: UserInfo.fromMap(map['userInfo'] as Map<String, dynamic>),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }
}
