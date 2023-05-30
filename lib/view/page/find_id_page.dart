import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/find_id_controller.dart';
import 'package:jangjeon/util/app_text_style.dart';
import 'package:jangjeon/view/widget/app_elevated_button.dart';
import 'package:jangjeon/view/widget/app_text_field.dart';
import 'package:jangjeon/view/widget/app_toggle_button.dart';
import 'package:jangjeon/view/widget/success_tile.dart';

class FindIdPage extends GetView<FindIdController> {
  const FindIdPage({super.key});
  static const route = '/find/id';

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
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Text(
                          style: AppTextStyle.h2B28(),
                          '이메일 주소 찾기',
                        ),
                        const SizedBox(height: 27),
                        Text(
                          style: AppTextStyle.b3M16(),
                          '이름',
                        ),
                        const SizedBox(height: 10),
                        AppTextField(
                          controller: controller.nameController,
                          hintText: '이름입력',
                          onChanged: (_) => controller.activateNextButton(),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          style: AppTextStyle.b3M16(),
                          '주민번호',
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: AppTextField(
                                controller: controller.frontPriNumController,
                                hintText: '생년월일',
                                onChanged: (_) =>
                                    controller.activateNextButton(),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: AppTextField(
                                obscureText: true,
                                controller: controller.backPriNumController,
                                hintText: '뒷자리',
                                onChanged: (_) =>
                                    controller.activateNextButton(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Text(
                          style: AppTextStyle.b3M16(),
                          '통신사',
                        ),
                        const SizedBox(height: 10),
                        const AppToggleButton(),
                        const SizedBox(height: 18),
                        Text(
                          style: AppTextStyle.b3M16(),
                          '휴대폰번호',
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: AppTextField(
                                controller: controller.phoneController,
                                hintText: '-를 제외한 휴대폰번호 입력',
                                onChanged: (_) =>
                                    controller.checkPhoneValidation(),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 1,
                              child: Obx(
                                () => AppElevatedButton(
                                  childText: '인증요청',
                                  onPressed: controller
                                          .isVerificationBtnActivated.value
                                      ? controller.requestVerificationCode
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Text(
                          style: AppTextStyle.b3M16(),
                          '인증번호',
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: AppTextField(
                                controller:
                                    controller.verificationCodeController,
                                errorText:
                                    controller.verificationCodeError.value,
                                hintText: '인증번호 입력',
                                onChanged: (_) =>
                                    controller.checkCodeValidation(),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 1,
                              child: Obx(
                                () => AppElevatedButton(
                                  childText: '확인',
                                  onPressed:
                                      controller.isConfirmCodeBtnActivated.value
                                          ? controller.checkVerificationCode
                                          : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => AppElevatedButton(
                      childText: '아이디 찾기',
                      onPressed: controller.isNextBtnActivated.value
                          ? controller.findId
                          : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            SuccessTile(
              title: '문자를 전송했습니다.',
              message: '인증하신 번호로 이메일 주소를 보냈습니다.\n이메일 주소를 확인하여 로그인해주세요.',
              btnText: '로그인하기',
              onPressed: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }
}
