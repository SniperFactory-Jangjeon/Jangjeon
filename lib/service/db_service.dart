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

  //유저 프로필 사진 URL 저장
  updateUserInfoPhoto(String uid, String? photoUrl) =>
      userInfoRef.doc(uid).update({'photoUrl': photoUrl});

  //유저 마케팅동의 여부 업데이트
  updateOptionalAgreement(String uid, bool optionalAgreement) =>
      userInfoRef.doc(uid).update({'optionalAgreement': optionalAgreement});

  //유저 정보 가져오기
  Future<UserInfo> getUserInfo(String userId) async {
    var result = await userInfoRef.doc(userId).get();
    return result.data()!;
  }

  //전화번호와 일치하는 이메일 찾기
  getEmailWithPhone(phone) => userInfoRef
      .where("phone", isEqualTo: phone)
      .get()
      .then((value) => value.docs.first.data().email)
      .catchError((_) => "");
}
