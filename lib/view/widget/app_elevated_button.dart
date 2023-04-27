import 'package:flutter/material.dart';
import 'package:jangjeon/util/app_color.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({super.key, required this.childText, this.onPressed});

  final String childText; //버튼 텍스트
  final VoidCallback? onPressed; //onPressed 이벤트

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: AppColor.red100,
            disabledBackgroundColor: AppColor.grayscale90,
            disabledForegroundColor: AppColor.grayscale0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            style: const TextStyle(
              fontSize: 16,
            ),
            childText,
          ),
        ),
      ),
    );
  }
}
