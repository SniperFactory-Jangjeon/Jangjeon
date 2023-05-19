import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/auth_controller.dart';
import 'package:jangjeon/model/comment.dart';
import 'package:jangjeon/model/userInfo.dart';
import 'package:jangjeon/service/db_service.dart';

class CommentsController extends GetxController {
  final ticker = Get.arguments['ticker'];
  TextEditingController commentController = TextEditingController();

  RxList<Comment> comments = <Comment>[].obs;

  //댓글 등록하기
  createComment() async {
    final uid = Get.find<AuthController>().user!.uid;
    final UserInfo userInfo = await DBService().getUserInfo(uid);
    await DBService().createComment(
      ticker,
      uid,
      Comment(
          comment: commentController.text,
          userInfo: userInfo,
          createdAt: DateTime.now()),
    );
    readComment();
  }

  //댓글 읽어오기
  readComment() async {
    comments.clear();
    var result = await DBService().readComments(ticker);
    comments.addAll(result);
    print(comments);
  }

  @override
  void onInit() {
    super.onInit();
    readComment();
  }
}
