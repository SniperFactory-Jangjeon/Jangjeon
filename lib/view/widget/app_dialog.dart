import 'package:flutter/material.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/util/app_text_style.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.content,
    required this.subcontent,
    required this.onCancel,
    required this.onConfirm,
    required this.cancelText,
    required this.confirmText,
  });

  final String content;
  final String subcontent;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;
  final String cancelText;
  final String confirmText;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 28),
            child: Text(content, style: AppTextStyle.b2B18()),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 8),
            child: Text(
              subcontent,
              textAlign: TextAlign.center,
              style: AppTextStyle.b3R16(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  width: 115,
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColor.grayscale90),
                  child: TextButton(
                    onPressed: onCancel,
                    child: Text(
                      cancelText,
                      style: AppTextStyle.b3M16(color: AppColor.grayscale0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  width: 115,
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColor.red100),
                  child: TextButton(
                    onPressed: onConfirm,
                    child: Text(
                      confirmText,
                      style: AppTextStyle.b3B16(color: AppColor.grayscale0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
