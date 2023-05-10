import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/util/app_text_style.dart';

class StockTimeTile extends StatelessWidget {
  const StockTimeTile(
      {super.key, required this.selectedTime, required this.time});
  final String selectedTime;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.1,
      height: 20,
      decoration: BoxDecoration(
          color: time == selectedTime ? Colors.white : AppColor.grayscale10,
          borderRadius: BorderRadius.circular(30)),
      child: Center(
        child: Text(
          time,
          style: AppTextStyle.b4M14(
            color: time == selectedTime ? AppColor.red100 : Colors.black,
          ),
        ),
      ),
    );
  }
}
