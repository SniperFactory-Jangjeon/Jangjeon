import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jangjeon/controller/comments_controller.dart';
import 'package:jangjeon/controller/stock_detail_controller.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/util/app_text_style.dart';
import 'package:jangjeon/view/widget/comment_tile.dart';

class CommentsPage extends GetView<CommentsController> {
  const CommentsPage({super.key});
  static const route = '/comments';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                if (controller.user.photoURL == null)
                  SvgPicture.asset('assets/svg/default_profile.svg')
                else
                  CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        NetworkImage(controller.user.photoURL.toString()),
                  ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 3,
                  child: TextField(
                    onChanged: (_) => controller.activeButton(),
                    controller: controller.commentController,
                    cursorColor: AppColor.grayscale30,
                    decoration: InputDecoration(
                      hintStyle: AppTextStyle.b3M16(
                        color: AppColor.grayscale50,
                      ),
                      hintText: '댓글 남기기',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: controller.isButtonActivated.value
                          ? controller.createComment
                          : null,
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColor.red100,
                          foregroundColor: AppColor.grayscale0,
                          disabledBackgroundColor: AppColor.grayscale0,
                          shape: RoundedRectangleBorder(
                            side: controller.isButtonActivated.value
                                ? BorderSide.none
                                : const BorderSide(color: AppColor.grayscale20),
                            borderRadius: BorderRadius.circular(5),
                          )),
                      child: Text(
                        style: AppTextStyle.b5M12(
                            color: controller.isButtonActivated.value
                                ? AppColor.grayscale0
                                : AppColor.grayscale20),
                        '작성하기',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(thickness: 10),
          Expanded(
            child: Obx(
              () => ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: controller.comments.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Obx(
                      () => CommentTile(
                          onTap: () => controller.increseCommentLikes(
                              controller.comments[index], index),
                          nickname: controller.comments[index].userInfo.name,
                          profileImg:
                              controller.comments[index].userInfo.photoUrl ??
                                  '',
                          content: controller.comments[index].comment,
                          like: controller.comments[index].likes.value,
                          comment: 1,
                          time: DateFormat('yyyy/MM/dd hh시 mm분')
                              .format(controller.comments[index].createdAt)),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    indent: 20,
                    endIndent: 20,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
