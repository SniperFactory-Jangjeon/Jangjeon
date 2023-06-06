import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/terms_of_service_controller.dart';
import 'package:jangjeon/util/app_text_style.dart';
import 'package:jangjeon/view/widget/terms_of_service_tile.dart';

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
                return TermsOfServiceTile(
                    title: controller.agreement[index]['title'],
                    content: controller.agreement[index]['content'],
                    checkValue: controller.agreement[index]['value'],
                    onChanged: (value) {});
              },
            )
          ],
        ),
      ),
    );
  }
}
