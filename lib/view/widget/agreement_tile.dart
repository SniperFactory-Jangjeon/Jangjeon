import 'package:flutter/material.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/util/app_text_style.dart';

class AgreementTile extends StatelessWidget {
  AgreementTile(
      {super.key,
      required this.title,
      this.checkValue = false,
      required this.onChanged});

  final String title; //약관 제목
  bool checkValue; //약관 동의 여부
  final Function(bool?) onChanged; //약관 동의 변경 이벤트

  //체크박스 값
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            splashRadius: 0,
            activeColor: AppColor.red100,
            shape: const CircleBorder(),
            side: const BorderSide(
              color: AppColor.red100,
            ),
            value: checkValue,
            onChanged: onChanged,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          style: AppTextStyle.b3M16(),
          title,
        ),
        const Expanded(child: SizedBox()),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: AppColor.grayscale50,
          ),
          onPressed: () {},
          child: const Text('자세히 보기'),
        )
      ],
    );
  }
}
