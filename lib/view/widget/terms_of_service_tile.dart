import 'package:flutter/material.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/util/app_text_style.dart';

class TermsOfServiceTile extends StatefulWidget {
  TermsOfServiceTile({
    super.key,
    required this.title,
    required this.content,
    this.checkValue = true,
    required this.onChanged,
  });

  final String title; //약관 제목
  final String content; //약관 내용
  bool checkValue; //마케팅 정보 수신 동의 여부
  final Function(bool?) onChanged; //마케팅 정보 수신 동의 변경 이벤트

  @override
  State<TermsOfServiceTile> createState() => _TermsOfServiceTileState();
}

class _TermsOfServiceTileState extends State<TermsOfServiceTile> {
  bool isContentVisible = false;

  _handleClickTextButton() {
    isContentVisible = !isContentVisible;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.checkValue
                ? Container(
                    width: 40,
                    height: 20,
                    decoration: BoxDecoration(
                        color: AppColor.red100,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text('동의',
                          style: AppTextStyle.b5R10(color: Colors.white)),
                    ),
                  )
                : Container(
                    width: 40,
                    height: 20,
                    decoration: BoxDecoration(
                        color: AppColor.grayscale80,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        '미동의',
                        style: AppTextStyle.b5R10(color: Colors.white),
                      ),
                    ),
                  ),
            const SizedBox(width: 5),
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
