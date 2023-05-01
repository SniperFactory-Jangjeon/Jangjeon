import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:jangjeon/util/app_routes.dart';
import 'package:jangjeon/util/app_text_style.dart';

class PersonalInfoEditPage extends StatelessWidget {
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
              onPressed: () {},
              child:
                  Text('저장', style: AppTextStyle.b2M18(color: Colors.black))),
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
              Container(
                alignment: const Alignment(1.1, 0),
                child: TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.withdrawal),
                  child: Text(
                    '회원탈퇴',
                    style: AppTextStyle.b4M14(color: const Color(0xFFB0B0B0)),
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
