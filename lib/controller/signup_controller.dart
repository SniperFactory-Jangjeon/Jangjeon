import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  PageController pageController = PageController(); //페이지 뷰 컨트롤러
  RxInt currentPage = 0.obs;

  RxBool isAllChecked = false.obs; //약관 전체 동의
  List agreement = [
    {
      'title': '[필수] 서비스 이용약관',
      'value': false.obs,
    },
    {
      'title': '[필수] 개인정보 수집 및 이용 동의',
      'value': false.obs,
    },
    {
      'title': '[필수] 개인정보 제 3자 제공 동의',
      'value': false.obs,
    },
    {
      'title': '[선택] 마케팅 정보 수신 동의',
      'value': false.obs,
    },
  ]; //이용약관

  //페이지 이동
  jumpToPage(page) {
    currentPage(page);
    pageController.jumpToPage(page);
  }

  //약관 동의
  checkAgreement(index, value) {
    agreement[index]['value'](value);
    for (var data in agreement) {
      if (data['value'].value == false) {
        isAllChecked(false);
      }
    }
  }

  //전체 약관 동의
  checkAllAgreement(value) {
    isAllChecked(value);
    for (var i = 0; i < 4; i++) {
      agreement[i]['value'](value);
    }
  }
}
