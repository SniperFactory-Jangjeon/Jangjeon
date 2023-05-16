import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/signup_controller.dart';
import 'package:jangjeon/util/app_text_style.dart';
import 'package:jangjeon/view/widget/app_elevated_button.dart';
import 'package:jangjeon/view/widget/app_text_field.dart';
import 'package:jangjeon/view/widget/app_toggle_button.dart';

class VerificationScreen extends GetView<SignupController> {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  style: AppTextStyle.h2B28(),
                  '본인인증',
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
                        onChanged: (_) => controller.activateNextButton(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppTextField(
                        obscureText: true,
                        controller: controller.backPriNumController,
                        hintText: '뒷자리',
                        onChanged: (_) => controller.activateNextButton(),
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
                        onChanged: (_) => controller.checkPhoneValidation(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Obx(
                        () => AppElevatedButton(
                          childText: '인증요청',
                          onPressed: controller.isVerificationBtnActivated.value
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
                      child: Obx(
                        () => AppTextField(
                          controller: controller.verificationCodeController,
                          errorText: controller.verificationCodeError.value,
                          hintText: '인증번호 입력',
                          onChanged: (_) => controller.checkCodeValidation(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Obx(
                        () => AppElevatedButton(
                          childText: '확인',
                          onPressed: controller.isConfirmCodeBtnActivated.value
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
        ),
        const SizedBox(height: 20),
        Obx(
          () => AppElevatedButton(
            childText: '다음단계',
            onPressed: controller.isNextBtnActivated.value
                ? () => controller.jumpToPage(1)
                : null,
          ),
        ),
      ],
    );
  }
}
