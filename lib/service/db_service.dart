import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jangjeon/model/comment.dart';
import 'package:jangjeon/model/userInfo.dart';

class DBService {
  //유저 정보 인스턴스
  final userInfoRef = FirebaseFirestore.instance
      .collection('userInfo')
      .withConverter(
          fromFirestore: (snapshot, _) => UserInfo.fromMap(snapshot.data()!),
          toFirestore: (userInfo, _) => userInfo.toMap());

  final stockRef = FirebaseFirestore.instance.collection('stockList');

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

  //닉네임 중복 체크
  checkDuplicateNickname(nickname) => userInfoRef
      .where('name', isEqualTo: nickname)
      .get()
      .then((value) => value.docs.isNotEmpty)
      .catchError((_) => '');

  //유저 이름 업데이트
  updatename(String uid, String nickname) =>
      userInfoRef.doc(uid).update({'name': nickname});

  //전화번호와 일치하는 이메일 찾기
  getEmailWithPhone(phone) => userInfoRef
      .where("phone", isEqualTo: phone)
      .get()
      .then((value) => value.docs.first.data().email)
      .catchError((_) => "");

  //주식 정보의 doc id 가져오기
  getStockDocId(ticker) => stockRef
      .where("symbol", isEqualTo: ticker)
      .get()
      .then((value) => value.docs.first.id);

  //댓글 작성
  createComment(ticker, uid, comment) async {
    final stockId = await getStockDocId(ticker);
    final commentRef =
        FirebaseFirestore.instance.collection('stockList/$stockId/comment');

    final userRef = userInfoRef.doc(uid);

    commentRef.add(comment.toMap(userRef));
  }

  //전체 댓글 읽어오기
  readComments(ticker) async {
    final stockId = await getStockDocId(ticker);
    final commentRef =
        FirebaseFirestore.instance.collection('stockList/$stockId/comment');

    var result = await commentRef.get();
    List<Comment> comments = [];

    for (var element in result.docs) {
      var userInfo = await element.data()['userInfo'].get();
      Comment comment = Comment.fromMap({
        'comment': element.data()['comment'],
        'userInfo': userInfo.data(),
        'createdAt': element.data()['createdAt']
      });
      comments.add(comment);
    }
    return comments;
  }
}
