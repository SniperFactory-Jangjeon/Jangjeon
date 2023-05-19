import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/service/db_service.dart';
import 'package:jangjeon/service/sms_service.dart';

class FindIdController extends GetxController {
  PageController pageController = PageController(); //페이지 뷰 컨트롤러
  RxInt currentPage = 0.obs; //회원가입 현재 페이지

  TextEditingController nameController = TextEditingController(); //이름 컨트롤러
  TextEditingController frontPriNumController =
      TextEditingController(); //주민번호 앞자리
  TextEditingController backPriNumController =
      TextEditingController(); //주민번호 뒷자리
  TextEditingController phoneController = TextEditingController(); //전화번호 컨트롤러
  TextEditingController verificationCodeController =
      TextEditingController(); //인증번호 컨트롤러

  String code = '000000';
  RxnString verificationCodeError = RxnString();

  RxBool isVerificationBtnActivated = false.obs; //인증하기 버튼 활성화 여부
  RxBool isConfirmCodeBtnActivated = false.obs; //코드 확인 버튼 활성화 여부
  RxBool isNextBtnActivated = false.obs; //아이디찾기 버튼 활성화 여부

  //페이지 이동
  jumpToPage(page) {
    currentPage(page);
    pageController.jumpToPage(page);
  }

  //전화번호 형식 체크
  checkPhoneValidation() {
    if (phoneController.text.isNotEmpty) {
      isVerificationBtnActivated(true);
    } else {
      isVerificationBtnActivated(false);
    }
    activateNextButton();
  }

  //인증번호 형식 체크
  checkCodeValidation() {
    if (verificationCodeController.text.isNotEmpty) {
      isConfirmCodeBtnActivated(true);
    } else {
      isConfirmCodeBtnActivated(false);
    }
    activateNextButton();
  }

  //인증번호 요청
  requestVerificationCode() async {
    code = (Random().nextInt(899999) + 100000).toString();
    await SMSService().requestVerificationCode(phoneController.text, code);
    activateNextButton();
  }

  //인증번호 확인
  checkVerificationCode() {
    if (code == verificationCodeController.text) {
      verificationCodeError('인증이 완료되었습니다.');
    } else {
      verificationCodeError('인증 번호가 일치하지 않습니다. 다시 입력해주세요.');
    }
    activateNextButton();
  }

  //다음단계 버튼 활성화 체크
  activateNextButton() {
    if (nameController.text.isNotEmpty &&
        frontPriNumController.text.isNotEmpty &&
        backPriNumController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        verificationCodeController.text.isNotEmpty &&
        verificationCodeError.value != null &&
        verificationCodeError.value!.length < 25) {
      isNextBtnActivated(true);
    } else {
      isNextBtnActivated(false);
    }
  }

  //아이디 찾기
  findId() async {
    var email = await DBService().getEmailWithPhone(phoneController.text);
    await SMSService().sendEmail(phoneController.text, email);
    jumpToPage(1);
  }
}
