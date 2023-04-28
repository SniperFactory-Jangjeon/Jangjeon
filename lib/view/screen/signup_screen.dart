import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/signup_controller.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/view/widget/agreement_tile.dart';
import 'package:jangjeon/view/widget/app_elevated_button.dart';
import 'package:jangjeon/view/widget/app_text_field.dart';

class SignupScreen extends GetView<SignupController> {
  const SignupScreen({super.key});

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
                  '회원가입',
                ),
                const SizedBox(height: 27),
                const Text(
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  '아이디',
                ),
                const SizedBox(height: 10),
                const AppTextField(hintText: '아이디 입력'),
                const SizedBox(height: 33),
                const Text(
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  '비밀번호',
                ),
                const SizedBox(height: 10),
                const AppTextField(hintText: '비밀번호 입력'),
                const SizedBox(height: 33),
                const Text(
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  '비밀번호 확인',
                ),
                const SizedBox(height: 10),
                const AppTextField(hintText: '비밀번호 확인'),
                const SizedBox(height: 33),
                const Text(
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  '이메일 주소',
                ),
                const SizedBox(height: 10),
                const AppTextField(hintText: '이메일 주소 입력'),
                const SizedBox(height: 48),
                const Text(
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  '약관동의',
                ),
                const SizedBox(height: 20),
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
                            value: controller.isAllChecked.value,
                            onChanged: controller.checkAllAgreement,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      '모두 동의합니다',
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.agreement.length,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => AgreementTile(
                        title: controller.agreement[index]['title'],
                        checkValue: controller.agreement[index]['value'].value,
                        onChanged: (value) =>
                            controller.checkAgreement(index, value),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        AppElevatedButton(
          childText: '다음단계',
          onPressed: () => controller.jumpToPage(2),
        ),
      ],
    );
  }
}
