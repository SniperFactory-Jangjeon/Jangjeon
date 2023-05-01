import 'package:flutter/material.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/util/app_text_style.dart';

class AppTextField extends StatelessWidget {
  AppTextField({
    super.key,
    required this.hintText,
    this.errorText,
    this.controller,
    this.onChanged,
    this.obscureText = false,
    this.errorTextColor = AppColor.grayscale80,
  });

  final String hintText; //힌트 텍스트
  final String? errorText; //에러 텍스트
  final TextEditingController? controller; //텍스트 필드 컨트롤러
  final Function(String)? onChanged; //onChanged 이벤트
  final bool obscureText;
  Color errorTextColor;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      cursorColor: AppColor.grayscale30,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 16,
          color: AppColor.grayscale30,
        ),
        errorText: errorText,
        errorStyle: AppTextStyle.b5R10(
          color: errorText != null && errorText!.length > 25
              ? AppColor.grayscale80
              : Colors.green,
        ),
        filled: true,
        fillColor: AppColor.grey,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
