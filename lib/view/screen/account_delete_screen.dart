import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/account_delete_controller.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/util/app_routes.dart';
import 'package:jangjeon/util/app_text_style.dart';
import 'package:jangjeon/view/widget/app_elevated_button.dart';

class AccountDeleteScreen extends GetView<AccountDeleteController> {
  const AccountDeleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back_ios_new))),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Text.rich(TextSpan(
                        text: controller.userInfo.value?.name ?? '',
                        style: AppTextStyle.h2B28(color: AppColor.red100),
                        children: [
                          TextSpan(
                            text: ' 님\n정말로 탈퇴하시겠어요?',
                            style: AppTextStyle.h2B28(),
                          )
                        ])),
                  ),
                  const SizedBox(height: 29),
                  Text(
                    '1. 지금 탈퇴하시게 되면 저장하신 모든 기업들의 기사 및 리스트가 사라지게 됩니다!',
                    style: AppTextStyle.b3R16(color: AppColor.grayscale60),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '2. 탈퇴 후에는 작성하신 리뷰를 수정 혹은 삭제하실 수 없어요. 탈퇴 신청 전에 꼭 확인해주세요!',
                    style: AppTextStyle.b3R16(color: AppColor.grayscale60),
                  ),
                  const SizedBox(height: 36),
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Transform.scale(
                          scale: 1.3,
                          child: Obx(
                            () => Checkbox(
                              splashRadius: 0,
                              activeColor: AppColor.red100,
                              shape: const CircleBorder(),
                              side: const BorderSide(
                                color: AppColor.red100,
                              ),
                              value: controller.isAccountDeleteAgree.value,
                              onChanged: controller.accountDeleteAgree,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '회원탈퇴 유의사항을 확인하였으며 동의합니다.',
                        style: AppTextStyle.b2M18(color: AppColor.red100),
                      )
                    ],
                  ),
                  const SizedBox(height: 50),
                  Text(
                    '떠나시는 이유를 알려주세요.',
                    style: AppTextStyle.h4B20(color: const Color(0xFF444444)),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    onChanged: (_) => controller.activateButton(),
                    controller: controller.accountDeleteReasonController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                        fillColor: const Color(0xFFF0F0F0),
                        filled: true,
                        contentPadding: const EdgeInsets.all(20),
                        hintStyle: AppTextStyle.b3R16(
                            color: AppColor.grayscale20, letterSpacing: 2),
                        hintText:
                            '서비스 탈퇴 이유를 알려주세요.\n고객님의 소중한 피드백을 받아 더 나은 서비스로 탈바꿈하겠습니다.'),
                    maxLines: 8,
                    style: const TextStyle(decorationThickness: 0),
                  )
                ],
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 50, right: 20),
              child: Obx(
                () => AppElevatedButton(
                    childText: '탈퇴하기',
                    onPressed: controller.isAccountDeleteBtnActivated.value
                        ? () => controller.jumpToPage(1)
                        : null),
              ))
        ],
      ),
    );
  }
}
