import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/account_delete_controller.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/util/app_text_style.dart';
import 'package:jangjeon/view/widget/app_elevated_button.dart';

class AccountDeleteSuccessScreen extends GetView<AccountDeleteController> {
  const AccountDeleteSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
            '회원탈퇴 완료',
          ),
          const SizedBox(height: 26),
          Text('그동안 장전을 이용해주셔서 감사합니다.\n더욱 더 노력하는 장전이 되겠습니다.',
              textAlign: TextAlign.center,
              style: AppTextStyle.b2M18(color: const Color(0xFF444444))),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: AppElevatedButton(
              childText: '처음으로',
              onPressed: () => Get.back(),
            ),
          ),
        ],
      ),
    );
  }
}
