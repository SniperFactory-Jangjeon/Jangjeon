import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/withdrawal_controller.dart';
import 'package:jangjeon/util/app_text_style.dart';

class WithdrawalPage extends GetView<WithdrawalController> {
  const WithdrawalPage({super.key});
  static const route = '/withdrawal';

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(TextSpan(
                      text: 'userName',
                      style: AppTextStyle.h2B28(color: Color(0xFFEB0F29)),
                      children: [
                        TextSpan(
                          text: ' 님\n정말로 탈퇴하시겠어요?',
                          style: AppTextStyle.h2B28(),
                        )
                      ])),
                  const SizedBox(height: 29),
                  Text(
                    '1. 지금 탈퇴하시게 되면 저장하신 모든 기업들의 기사 및 리스트가 사라지게 됩니다!',
                    style: AppTextStyle.b3R16(color: const Color(0xFF737373)),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '2. 탈퇴 후에는 작성하신 리뷰를 수정 혹은 삭제하실 수 없어요. 탈퇴 신청 전에 꼭 확인해주세요!',
                    style: AppTextStyle.b3R16(color: const Color(0xFF737373)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 36),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Obx(
                    () => IconButton(
                        onPressed: () {
                          controller.withdrawalAgree();
                        },
                        icon: controller.isWithdrawalAgree()
                            ? const Icon(
                                Icons.circle,
                                color: Color(0xFFEB0F29),
                              )
                            : const Icon(Icons.circle_outlined,
                                color: Color(0xFFEB0F29))),
                  ),
                ),
                Text(
                  '회원탈퇴 유의사항을 확인하였으며 동의합니다.',
                  style: AppTextStyle.b2M18(color: Color(0xFFEB0F29)),
                )
              ],
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                '떠나시는 이유를 알려주세요.',
                style: AppTextStyle.h4B20(color: Color(0xFF444444)),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: controller.withdrawalReason,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                    fillColor: const Color(0xFFF0F0F0),
                    filled: true,
                    contentPadding: const EdgeInsets.all(20),
                    hintStyle: AppTextStyle.b3R16(
                        color: const Color(0xFFC4C4C4), letterSpacing: 2),
                    hintText:
                        '서비스 탈퇴 이유를 알려주세요.\n고객님의 소중한 피드백을 받아 더 나은 서비스로 탈바꿈하겠습니다.'),
                maxLines: 8,
                style: const TextStyle(decorationThickness: 0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
