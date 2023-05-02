import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/signup_controller.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/util/app_text_style.dart';
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
                Text(
                  style: AppTextStyle.h2B28(),
                  '회원가입',
                ),
                const SizedBox(height: 27),
                Text(
                  style: AppTextStyle.b3M16(),
                  '아이디',
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Obx(
                        () => AppTextField(
                          controller: controller.idController,
                          hintText: '아이디 입력',
                          errorText: controller.idError.value,
                          onChanged: controller.checkIdValidation,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Obx(
                        () => AppElevatedButton(
                          childText: '중복확인',
                          onPressed: controller.idError.value == null
                              ? controller.checkIdDuplicate
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 33),
                Text(
                  style: AppTextStyle.b3M16(),
                  '비밀번호',
                ),
                const SizedBox(height: 10),
                Obx(
                  () => AppTextField(
                    controller: controller.pwController,
                    hintText: '비밀번호 입력',
                    errorText: controller.pwError.value,
                    onChanged: controller.checkPwValidation,
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 33),
                Text(
                  style: AppTextStyle.b3M16(),
                  '비밀번호 확인',
                ),
                const SizedBox(height: 10),
                Obx(
                  () => AppTextField(
                    controller: controller.pwConfirmController,
                    hintText: '비밀번호 확인',
                    errorText: controller.pwConfirmError.value,
                    onChanged: controller.checkPwConfirmValidation,
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 33),
                Text(
                  style: AppTextStyle.b3M16(),
                  '이메일 주소',
                ),
                const SizedBox(height: 10),
                AppTextField(
                  controller: controller.emailController,
                  hintText: '이메일 주소 입력',
                  onChanged: (_) => controller.activateSignupButton(),
                ),
                const SizedBox(height: 48),
                Text(
                  style: AppTextStyle.h2B28(),
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
                    Text(
                      style: AppTextStyle.b2M18(),
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
        Obx(
          () => AppElevatedButton(
            childText: '가입하기',
            onPressed: controller.isSignupBtnActivated.value
                ? controller.signup
                : null,
          ),
        ),
      ],
    );
  }
}
