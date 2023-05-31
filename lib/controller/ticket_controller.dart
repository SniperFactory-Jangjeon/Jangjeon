import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/service/toss_payments.dart';

class TicketController extends GetxController {
  PageController pageController = PageController(); //페이지 뷰 컨트롤러
  RxInt currentPage = 0.obs; //결제 현재 페이지
  bool isContentVisible = false;
  RxInt currentTicketIndex = 0.obs; //현재 선택된 옵션 인덱스
  RxList<bool> isSelected = [true, false].obs; //선택 여부 리스트
  RxBool isNextPageBtnActivated = false.obs; //다음단계 버튼 활성화 여부

  TossPayments tossPayMents = TossPayments();

  //페이지 이동
  jumpToPage(page) {
    currentPage(page);
    pageController.jumpToPage(page);
  }

  //옵션 선택 핸들러
  handleSelectOption(index) {
    currentTicketIndex.value = index;
    for (var i = 0; i < isSelected.length; i++) {
      if (i == index) {
        isSelected[i] = true;
      } else {
        isSelected[i] = false;
      }
    }
    activateNextPageButton();
  }

  //다음단계 버튼 활성화
  activateNextPageButton() {
    if (currentTicketIndex.value == 1) {
      isNextPageBtnActivated.value = true;
    } else {
      isNextPageBtnActivated.value = false;
    }
  }
}
