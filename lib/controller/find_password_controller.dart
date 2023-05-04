import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/service/auth_service.dart';

class FindPasswordController extends GetxController {
  PageController pageController = PageController(); //페이지 뷰 컨트롤러
  RxInt currentPage = 0.obs; //회원가입 현재 페이지

  TextEditingController nameController = TextEditingController(); //이름 컨트롤러
  TextEditingController phoneController = TextEditingController(); //전화번호 컨트롤러
  TextEditingController emailController = TextEditingController(); //이메일 컨트롤러

  RxBool isBtnActivated = false.obs; //비밀번호 찾기 버튼 활성화 여부

  //페이지 이동
  jumpToPage(page) {
    currentPage(page);
    pageController.jumpToPage(page);
  }

  //비밀번호 찾기 버튼 활성화
  activeBtn() {
    if (nameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        emailController.text.isNotEmpty) {
      isBtnActivated(true);
    } else {
      isBtnActivated(false);
    }
  }

  //비밀번호 재설정
  resetPassword() => AuthService().resetPassword(emailController.text);

  //비밀번호 찾기 버튼 핸들러
  handleFindPassword() {
    resetPassword();
    jumpToPage(1);
  }
}
