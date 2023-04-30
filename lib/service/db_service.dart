import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jangjeon/model/userInfo.dart';

class DBService {
  //유저 정보 인스턴스
  final userInfoRef = FirebaseFirestore.instance
      .collection('userInfo')
      .withConverter(
          fromFirestore: (snapshot, _) => UserInfo.fromMap(snapshot.data()!),
          toFirestore: (userInfo, _) => userInfo.toMap());

  //유저 정보 생성
  createUserInfo(String uid, UserInfo user) =>
      userInfoRef.doc(uid).set(user, SetOptions(merge: true));
}
