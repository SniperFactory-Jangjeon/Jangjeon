import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/signup_controller.dart';
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
                const Text(
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  '본인인증',
                ),
                const SizedBox(height: 27),
                const Text(
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  '이름',
                ),
                const SizedBox(height: 10),
                const AppTextField(hintText: '이름입력'),
                const SizedBox(height: 18),
                const Text(
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  '주민번호',
                ),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Expanded(child: AppTextField(hintText: '생년월일')),
                    SizedBox(width: 10),
                    Expanded(child: AppTextField(hintText: '뒷자리')),
                  ],
                ),
                const SizedBox(height: 18),
                const Text(
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  '통신사',
                ),
                const SizedBox(height: 10),
                const AppToggleButton(),
                const SizedBox(height: 18),
                const Text(
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  '휴대폰번호',
                ),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Expanded(
                      flex: 2,
                      child: AppTextField(hintText: '-를 제외한 휴대폰번호 입력'),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: AppElevatedButton(childText: '인증요청'),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                const Text(
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  '휴대폰번호',
                ),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Expanded(
                      flex: 2,
                      child: AppTextField(hintText: '인증번호 입력'),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: AppElevatedButton(
                        childText: '확인',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        AppElevatedButton(
          childText: '다음단계',
          onPressed: () => controller.jumpToPage(1),
        ),
      ],
    );
  }
}
