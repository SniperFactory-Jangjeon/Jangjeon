import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/terms_of_service_controller.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/util/app_text_style.dart';

class TermsOfServicePage extends GetView<TermsOfServiceController> {
  const TermsOfServicePage({super.key});
  static const route = '/termsofservice';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back_ios_new))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              style: AppTextStyle.h2B28(),
              '이용약관',
            ),
            const SizedBox(height: 40),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.agreement.length,
              itemBuilder: (context, index) {
                return Obx(
                  () => Column(
                    children: [
                      Row(
                        children: [
                          Text(controller.agreement[index]['title']),
                          const Expanded(child: SizedBox()),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: AppColor.grayscale50,
                            ),
                            onPressed: controller.handleClickTextButton,
                            child: controller.isContentVisible.value
                                ? const Text('닫기')
                                : const Text('자세히 보기'),
                          )
                        ],
                      ),
                      Visibility(
                        visible: controller.isContentVisible.value,
                        child: Container(
                          height: 227,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColor.grayscale10,
                            ),
                          ),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Text(
                              controller.agreement[index]['content'],
                              style: AppTextStyle.b3R16(
                                  color: AppColor.grayscale70),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
