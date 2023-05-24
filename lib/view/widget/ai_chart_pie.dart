import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/util/app_text_style.dart';

class AIChartPie extends StatelessWidget {
  const AIChartPie({super.key, required this.value});
  final double value;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: Get.width * 0.3,
          height: Get.width * 0.3,
          child: PieChart(
            PieChartData(startDegreeOffset: 270, sections: [
              PieChartSectionData(
                  color: AppColor.red100, value: value, radius: 15, title: ''),
              PieChartSectionData(
                  color: AppColor.grayscale10,
                  value: 100 - value,
                  radius: 8,
                  title: ''),
            ]),
          ),
        ),
        Positioned(
          top: Get.width * 0.3 * 0.3,
          bottom: Get.width * 0.3 * 0.25,
          left: Get.width * 0.3 * 0.25,
          right: Get.width * 0.3 * 0.25,
          child: Column(
            children: [
              Text(value < 0 ? '' : value.toInt().toString(),
                  style: AppTextStyle.h2B28(color: AppColor.red100)),
              Text(
                '/ 100',
                style: AppTextStyle.b5M12(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
