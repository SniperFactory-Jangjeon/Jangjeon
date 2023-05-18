import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/personal_info_edit_controller.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/util/app_routes.dart';
import 'package:jangjeon/util/app_text_style.dart';
import 'package:jangjeon/view/widget/app_elevated_button.dart';
import 'package:jangjeon/view/widget/app_text_field.dart';

class PersonalInfoEditPage extends GetView<PersonalInfoEditController> {
  const PersonalInfoEditPage({super.key});
  static const route = '/myinfoedit';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_new)),
        actions: [
          TextButton(
              onPressed: () {}, child: Text('저장', style: AppTextStyle.b2M18())),
          const SizedBox(width: 12)
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('개인정보 설정', style: AppTextStyle.b1B24()),
              const SizedBox(height: 17),
              Container(
                alignment: const Alignment(0, 0),
                child: GestureDetector(
                  onTap: () => showCupertinoModalPopup(
                      context: context,
                      builder: (context) => controller.cupertinoActionSheet()),
                  child: Obx(
                    () => CircleAvatar(
                      radius: 43,
                      backgroundColor: Colors.white,
                      backgroundImage: controller.profileUrl.value != null
                          ? NetworkImage(controller.profileUrl.value!)
                          : null,
                      child: controller.profileUrl.value == null
                          ? Image.asset('assets/icons/circle-user.png')
                          : null,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '이름',
                style: AppTextStyle.b3M16(color: AppColor.grayscale100),
              ),
              const SizedBox(height: 10),
              AppTextField(
                controller: null,
                hintText: controller.user.value.displayName!,
                errorText: null,
                onChanged: null,
              ),
              const SizedBox(height: 10),
              Text(
                '이메일',
                style: AppTextStyle.b3M16(color: AppColor.grayscale100),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.circle),
                  const SizedBox(width: 10),
                  Text(controller.user.value.email!)
                ],
              ),
              const SizedBox(height: 10),
              Text(
                '휴대폰번호',
                style: AppTextStyle.b3M16(color: AppColor.grayscale100),
              ),
              const SizedBox(height: 10),
              Obx(
                () => AppTextField(
                  controller: null,
                  hintText: controller.userInfo.value!.phone,
                  errorText: null,
                  onChanged: null,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '비밀번호',
                style: AppTextStyle.b3M16(color: AppColor.grayscale100),
              ),
              const SizedBox(height: 10),
              AppTextField(
                controller: null,
                hintText: '비밀번호 입력',
                errorText: null,
                onChanged: null,
                obscureText: true,
              ),
              const SizedBox(height: 33),
              const Text(
                style: TextStyle(
                  fontSize: 16,
                ),
                '비밀번호 확인',
              ),
              const SizedBox(height: 10),
              AppTextField(
                controller: null,
                hintText: '비밀번호 확인',
                errorText: null,
                onChanged: null,
                obscureText: true,
              ),
              Container(
                alignment: const Alignment(1.1, 0),
                child: TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.accountDelete),
                  child: Text(
                    '회원탈퇴',
                    style: AppTextStyle.b4M14(color: AppColor.grayscale30),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
