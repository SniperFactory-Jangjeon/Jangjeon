import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindPasswordController extends GetxController {
  PageController pageController = PageController(); //페이지 뷰 컨트롤러
  RxInt currentPage = 0.obs; //회원가입 현재 페이지

  //페이지 이동
  jumpToPage(page) {
    currentPage(page);
    pageController.jumpToPage(page);
  }
}
