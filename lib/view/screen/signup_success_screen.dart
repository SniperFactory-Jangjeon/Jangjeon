import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/signup_controller.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/view/widget/app_elevated_button.dart';

class SignupSuccessScreen extends GetView<SignupController> {
  const SignupSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(child: SizedBox()),
        const Icon(
          size: 75,
          color: AppColor.red100,
          Icons.check_circle,
        ),
        const SizedBox(height: 23),
        const Text(
          style: TextStyle(
            color: AppColor.red100,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          '회원가입 완료',
        ),
        const SizedBox(height: 26),
        const Text(
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
          ),
          '서학개미들,\n총알 장전할 준비 됐나?',
        ),
        const Expanded(child: SizedBox()),
        AppElevatedButton(
          childText: '로그인하기',
          onPressed: () => controller.jumpToPage(0),
        ),
      ],
    );
  }
}
