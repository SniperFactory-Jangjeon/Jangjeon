import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  // PageController pageController = PageController();
  // RxInt selectedIndex = 0.obs;
  RxDouble investmentIndex = (65.0).obs;
  RxDouble negative = (0.3).obs;
  RxDouble positive = (0.45).obs;
  RxDouble neutrality = (0.25).obs;
  RxInt bottomNavIndex = 0.obs;
  // handleNavigationOnTap(int index) {
  //   selectedIndex(index);
  //   pageController.jumpToPage(selectedIndex.value);
  // }
}
