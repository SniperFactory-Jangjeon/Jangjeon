import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AccountDeleteController extends GetxController {
  PageController pageController = PageController(); //페이지 뷰 컨트롤러
  RxInt currentPage = 0.obs; //회원탈퇴 현재 페이지
  RxBool isAccountDeleteAgree = false.obs; //동의하기 버튼 활성화 여부
  RxBool isAccountDeleteBtnActivated = false.obs; //탈퇴하기 버튼 활성화 여부
  var accountDeleteReasonController = TextEditingController();

  //페이지 이동
  jumpToPage(page) {
    currentPage(page);
    pageController.jumpToPage(page);
  }

  //회원탈퇴 동의
  accountDeleteAgree(value) {
    if (isAccountDeleteAgree(value)) {
      isAccountDeleteAgree(true);
    } else {
      isAccountDeleteAgree(false);
    }
    activateButton();
  }

  //탈퇴하기버튼 활성화 체크
  activateButton() {
    if (isAccountDeleteAgree.value &&
        accountDeleteReasonController.text.isNotEmpty) {
      isAccountDeleteBtnActivated.value = true;
    } else {
      isAccountDeleteBtnActivated.value = false;
    }
  }
}
