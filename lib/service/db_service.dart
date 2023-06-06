import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jangjeon/model/comment.dart';
import 'package:jangjeon/model/news.dart';
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

    commentRef.doc(comment.id).set(comment.toMap(userRef));
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
        'id': element.data()['id'],
        'comment': element.data()['comment'],
        'userInfo': userInfo.data(),
        'createdAt': element.data()['createdAt'],
        'likes': element.data()['likes']
      });
      comments.add(comment);
    }
    return comments;
  }

  //댓글 좋아요 수 증가
  increseCommentLikes(ticker, id) async {
    final stockId = await getStockDocId(ticker);
    final commentRef =
        FirebaseFirestore.instance.collection('stockList/$stockId/comment');
    await commentRef.doc(id).update({"likes": FieldValue.increment(1)});
  }

  //내 댓글 작성 수 증가
  increseCommentCount(uid) async {
    await userInfoRef
        .doc(uid)
        .update({"commentCount": FieldValue.increment(1)});
  }

  //뉴스 컬렉션 만들기 및 클릭 수 증가
  clickNews(String url, newsData, Timestamp time) async {
    final news = FirebaseFirestore.instance.collection('News');
    var newsId = url.replaceAll("https://", "").replaceAll("/", "");
    if (!await isDuplicateUniqueName(url)) {
      news
          .doc(newsId)
          .set({'url': url, 'news': newsData, 'click': 1, 'time': time});
    } else {
      news.doc(newsId).update({'click': FieldValue.increment(1)});
    }
  }

  //파이어베이스에 저장된 뉴스인지
  Future<bool> isDuplicateUniqueName(String url) async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('News')
        .where('url', isEqualTo: url)
        .get();
    return query.docs.isNotEmpty;
  }

  //핫이슈 읽어오기
  readHotIssueNews() async {
    var news = await FirebaseFirestore.instance
        .collection('News')
        .orderBy('click', descending: true)
        .orderBy('time', descending: true)
        .get();
    return news.docs;
  }

  readStock() async {
    var stockList =
        await FirebaseFirestore.instance.collection('stockList').get();
    return stockList.docs;
  }

  //뉴스 기사 읽어오기
  readNews(ticker) async {
    final stockId = await getStockDocId(ticker);
    final newsRef = FirebaseFirestore.instance
        .collection('stockList/$stockId/relevantNews');

    var result = await newsRef.get();
    List<News> newsList = [];

    for (var element in result.docs) {
      News news = News.fromMap(element.data());
      newsList.add(news);
    }
    return newsList;
  }
}
