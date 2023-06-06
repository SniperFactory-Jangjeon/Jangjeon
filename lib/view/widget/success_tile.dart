import 'package:flutter/material.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/util/app_text_style.dart';
import 'package:jangjeon/view/widget/app_elevated_button.dart';

class SuccessTile extends StatelessWidget {
  const SuccessTile(
      {super.key,
      required this.title,
      required this.message,
      required this.btnText,
      required this.onPressed});

  final String title; //타이틀
  final String message; //메세지
  final String btnText; //버튼 텍스트
  final VoidCallback onPressed; //onPressed 이벤트

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(child: SizedBox()),
        const Icon(
          size: 75,
          color: AppColor.red100,
          Icons.check_circle,
        ),
        const SizedBox(height: 23),
        Text(
          style: AppTextStyle.h2B28(color: AppColor.red100),
          title,
        ),
        const SizedBox(height: 26),
        Text(
          textAlign: TextAlign.center,
          style: AppTextStyle.b2M18(),
          message,
        ),
        const Expanded(child: SizedBox()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: AppElevatedButton(
            childText: btnText,
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}
