import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/login_controller.dart';
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('JANGJEON'),
              SizedBox(height: 25),
              AppTextField(hintText: '아이디 입력'),
              SizedBox(height: 10),
              AppTextField(hintText: '비밀번호 입력'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text('아이디 찾기', style: AppTextStyle.b5M12())),
                      Text('|'),
                      TextButton(
                          onPressed: () {},
                          child: Text('비밀번호 찾기', style: AppTextStyle.b5M12())),
                    ],
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text('회원가입', style: AppTextStyle.b5M12())),
                ],
              ),
              AppElevatedButton(childText: '로그인'),
              SizedBox(height: 25),
              Text('SNS 계정으로 로그인하기', style: AppTextStyle.b4M14()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: controller.kakaoLoign,
                      child: Text('카카오톡 로그인')),
                  TextButton(
                      onPressed: controller.signOut,
                      child: Text(
                        '로그아웃',
                        style: AppTextStyle.b4M14(color: Color(0xFFEB0F29)),
                      )),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
