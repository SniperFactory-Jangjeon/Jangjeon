import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/comments_controller.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/util/app_text_style.dart';
import 'package:jangjeon/view/widget/app_elevated_button.dart';

class CommentsPage extends GetView<CommentsController> {
  const CommentsPage({super.key});
  static const route = '/comments';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 4,
                child: TextField(
                  controller: controller.commentController,
                ),
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: controller.createComment,
                  child: Text(
                    style: AppTextStyle.b5M12(color: AppColor.grayscale0),
                    '작성하기',
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.comments.length,
                itemBuilder: (context, index) {
                  return Text(controller.comments[index].comment);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
