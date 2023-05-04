import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/login_controller.dart';
import 'package:jangjeon/util/app_routes.dart';
import 'package:jangjeon/util/app_text_style.dart';
import 'package:jangjeon/view/widget/app_elevated_button.dart';
import 'package:jangjeon/view/widget/app_text_field.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});
  static const route = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/svg/app_logo.svg',
                width: Get.width * 0.5,
              ),
              const SizedBox(height: 25),
              AppTextField(
                hintText: '아이디 입력',
                controller: controller.idController,
                onChanged: (_) => controller.activateLoginBtn(),
              ),
              const SizedBox(height: 10),
              AppTextField(
                obscureText: true,
                hintText: '비밀번호 입력',
                controller: controller.pwController,
                onChanged: (_) => controller.activateLoginBtn(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => Get.toNamed(AppRoutes.findId),
                        child: Text('아이디 찾기', style: AppTextStyle.b5M12()),
                      ),
                      const Text('|'),
                      TextButton(
                        onPressed: () => Get.toNamed(AppRoutes.findPassword),
                        child: Text('비밀번호 찾기', style: AppTextStyle.b5M12()),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.signup),
                    child: Text('회원가입', style: AppTextStyle.b5M12()),
                  ),
                ],
              ),
              Obx(
                () => AppElevatedButton(
                  childText: '로그인',
                  onPressed: controller.isButtonActivate.value
                      ? controller.login
                      : null,
                ),
              ),
              const SizedBox(height: 30),
              Text('SNS 계정으로 로그인하기', style: AppTextStyle.b4M14()),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: controller.kakaoLoign,
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: SvgPicture.asset('assets/svg/kakao.svg')),
                    ),
                  ),
                  // TextButton(
                  //   onPressed: controller.signOut,
                  //   child: Text(
                  //     '로그아웃',
                  //     style: AppTextStyle.b4M14(color: Color(0xFFEB0F29)),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
