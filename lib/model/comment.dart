// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:jangjeon/model/userInfo.dart';

class Comment {
  final String id; //댓글 아이디
  final String comment; //댓글 내용
  final UserInfo userInfo; //유저 정보
  final DateTime createdAt; //생성 날짜
  RxInt likes; //좋아요

  Comment({
    required this.id,
    required this.comment,
    required this.userInfo,
    required this.createdAt,
    required this.likes,
  });

  Map<String, dynamic> toMap(DocumentReference userRef) {
    return <String, dynamic>{
      'id': id,
      'comment': comment,
      'userInfo': userRef,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'likes': likes.value,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'] as String,
      comment: map['comment'] as String,
      userInfo: UserInfo.fromMap(map['userInfo'] as Map<String, dynamic>),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      likes: (map['likes'] as int).obs,
    );
  }
}
