import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/find_password_controller.dart';
import 'package:jangjeon/util/app_text_style.dart';
import 'package:jangjeon/view/widget/app_elevated_button.dart';
import 'package:jangjeon/view/widget/app_text_field.dart';
import 'package:jangjeon/view/widget/success_tile.dart';

class FindPasswordPage extends GetView<FindPasswordController> {
  const FindPasswordPage({super.key});
  static const route = '/find/password';

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: controller.currentPage.value != 1
            ? AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.black,
                leading: IconButton(
                  icon: const Icon(Icons.navigate_before),
                  onPressed: () => Get.back(),
                ),
              )
            : null,
        body: PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    style: AppTextStyle.h2B28(),
                    '비밀번호 찾기',
                  ),
                  const SizedBox(height: 27),
                  Text(
                    style: AppTextStyle.b3M16(),
                    '이름',
                  ),
                  const SizedBox(height: 10),
                  AppTextField(hintText: '이름입력'),
                  const SizedBox(height: 18),
                  Text(
                    style: AppTextStyle.b3M16(),
                    '휴대폰번호',
                  ),
                  const SizedBox(height: 10),
                  AppTextField(hintText: '-를 제외한 휴대폰번호 입력'),
                  const SizedBox(height: 27),
                  Text(
                    style: AppTextStyle.b3M16(),
                    '이메일주소',
                  ),
                  const SizedBox(height: 10),
                  AppTextField(hintText: '이메일주소 입력'),
                  const Expanded(child: SizedBox()),
                  AppElevatedButton(
                    childText: '비밀번호 찾기',
                    onPressed: () => controller.jumpToPage(1),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SuccessTile(
                title: '메일을 전송했습니다.',
                message: '작성하신 이메일주소로 메일을 보냈습니다.\n비밀번호를 확인하여 로그인해주세요.',
                btnText: '로그인하기',
                onPressed: () => Get.back(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
