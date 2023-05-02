import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/signup_controller.dart';
import 'package:jangjeon/view/widget/success_tile.dart';

class SignupSuccessScreen extends GetView<SignupController> {
  const SignupSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SuccessTile(
      title: '회원가입 완료',
      message: '서학개미들,\n총알 장전할 준비 됐나?',
      btnText: '로그인하기',
      onPressed: () => Get.back(),
    );
  }
}
