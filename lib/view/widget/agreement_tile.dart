import 'package:flutter/material.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/util/app_text_style.dart';

class AgreementTile extends StatefulWidget {
  AgreementTile({
    super.key,
    required this.title,
    required this.content,
    this.checkValue = false,
    required this.onChanged,
  });

  final String title; //약관 제목
  final String content; //약관 내용
  bool checkValue; //약관 동의 여부
  final Function(bool?) onChanged; //약관 동의 변경 이벤트

  @override
  State<AgreementTile> createState() => _AgreementTileState();
}

class _AgreementTileState extends State<AgreementTile> {
  bool isContentVisible = false;

  _handleClickTextButton() {
    isContentVisible = !isContentVisible;
    setState(() {});
  }

  //체크박스 값
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
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
                value: widget.checkValue,
                onChanged: widget.onChanged,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              style: AppTextStyle.b3M16(),
              widget.title,
            ),
            const Expanded(child: SizedBox()),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: AppColor.grayscale50,
              ),
              onPressed: _handleClickTextButton,
              child: isContentVisible ? const Text('닫기') : const Text('자세히 보기'),
            )
          ],
        ),
        Visibility(
          visible: isContentVisible,
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
                style: AppTextStyle.b3R16(color: AppColor.grayscale70),
                widget.content,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
