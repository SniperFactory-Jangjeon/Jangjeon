import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/main_controller.dart';
import 'package:jangjeon/util/app_text_style.dart';
import '../../util/app_color.dart';

class AppNavigationBar extends GetView<MainController> {
  const AppNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
        itemCount: 2,
        tabBuilder: (index, isActive) {
          final color = isActive ? Colors.black : AppColor.grayscale60;
          var text;
          var icon;
          if (index == 0) {
            text = '주식';
            icon = Icons.bar_chart;
          } else {
            text = '설정';
            icon = Icons.person;
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24, color: color),
              Text(
                text,
                style: AppTextStyle.b4M14(color: color),
              )
            ],
          );
        },
        activeIndex: controller.bottomNavIndex.value,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.defaultEdge,
        backgroundColor: AppColor.grey,
        onTap: (index) => controller.bottomNavIndex.value = index);
  }
}
