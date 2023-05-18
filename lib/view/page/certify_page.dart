import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/personal_info_edit_controller.dart';
import 'package:jangjeon/util/app_text_style.dart';
import 'package:jangjeon/view/widget/app_elevated_button.dart';
import 'package:jangjeon/view/widget/app_text_field.dart';

class CertifyPage extends GetView<PersonalInfoEditController> {
  const CertifyPage({super.key});
  static const route = '/certify';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: Text('휴대폰 인증', style: AppTextStyle.h3B24()),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      '휴대폰 번호를 입력해 주세요.',
                      style: AppTextStyle.h4B20(),
                    ),
                    const SizedBox(height: 20),
                    AppTextField(
                      controller: controller.phoneController,
                      hintText: '-를 제외한 휴대폰 번호',
                      onChanged: (_) => controller.certifyButton(),
                    ),
                    const SizedBox(height: 20),
                    Container(
                        alignment: const Alignment(1, 0),
                        child: SizedBox(
                            width: 130,
                            child: Obx(
                              () => AppElevatedButton(
                                  childText: '인증요청',
                                  onPressed: controller.isCertifyButton.value
                                      ? () =>
                                          controller.requestVerificationCode()
                                      : null),
                            ))),
                    Visibility(
                        visible: controller.isTextFieldVisible.value,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 40),
                            const Text('인증번호를 보냈습니다.'),
                            const SizedBox(height: 20),
                            Obx(
                              () => AppTextField(
                                hintText: '인증번호를 입력하세요.',
                                errorText:
                                    controller.verificationCodeError.value,
                                controller: controller.certifyController,
                                onChanged: (_) =>
                                    controller.checkCodeValidation(),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                                alignment: const Alignment(1, 0),
                                child: SizedBox(
                                    width: 130,
                                    child: Obx(
                                      () => AppElevatedButton(
                                        childText: '확인',
                                        onPressed: controller
                                                .isConfirmCodeBtnActivated.value
                                            ? controller.checkVerificationCode
                                            : null,
                                      ),
                                    )))
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
            child: Obx(() => AppElevatedButton(
                  childText: '개인정보 수정하러 가기',
                  onPressed: controller.isNextPageButton.value
                      ? () => print('수정하는 페이지')
                      : null,
                )),
          ),
        ],
      ),
    );
  }
}
