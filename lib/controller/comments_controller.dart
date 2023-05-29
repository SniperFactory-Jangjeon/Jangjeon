import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/auth_controller.dart';
import 'package:jangjeon/controller/setting_controller.dart';
import 'package:jangjeon/controller/stock_detail_controller.dart';
import 'package:jangjeon/model/comment.dart';
import 'package:jangjeon/model/userInfo.dart';
import 'package:jangjeon/service/db_service.dart';
import 'package:uuid/uuid.dart';

class CommentsController extends GetxController {
  final ticker = Get.arguments['ticker'];
  TextEditingController commentController = TextEditingController();
  firebaseAuth.User user = Get.find<AuthController>().user!;

  RxList<Comment> comments = <Comment>[].obs;

  RxBool isButtonActivated = false.obs;

  //댓글 등록하기
  createComment() async {
    final uid = Get.find<AuthController>().user!.uid;
    final UserInfo userInfo = await DBService().getUserInfo(uid);
    final docId = const Uuid().v1();
    await DBService().createComment(
      ticker,
      uid,
      Comment(
        id: docId,
        comment: commentController.text,
        userInfo: userInfo,
        createdAt: DateTime.now(),
        likes: 0.obs,
      ),
    );
    DBService().increseCommentCount(uid);
    if (Get.find<SettingController>().userInfo.value != null) {
      Get.find<SettingController>().userInfo.value!.commentCount += 1;
    }
    readComment();
  }

  //댓글 읽어오기
  readComment() async {
    comments.clear();
    List<Comment> result = await DBService().readComments(ticker);
    result.sort((a, b) => -a.createdAt.compareTo(b.createdAt));
    comments.addAll(result);
  }

  //댓글 좋아요 수 증가
  increseCommentLikes(comment, index) {
    DBService().increseCommentLikes(ticker, comment.id);
    comment.likes += 1;
    Get.find<StockDetailController>().comments[index].likes += 1;
  }

  //댓글 작성하기 버튼 활성화
  activeButton() {
    if (commentController.text.isNotEmpty) {
      isButtonActivated(true);
    } else {
      isButtonActivated(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    readComment();
  }
}
