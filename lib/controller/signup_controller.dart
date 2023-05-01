import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/auth_controller.dart';
import 'package:jangjeon/model/userInfo.dart';

class SignupController extends GetxController {
  PageController pageController = PageController(); //페이지 뷰 컨트롤러
  RxInt currentPage = 0.obs; //회원가입 현재 페이지

  TextEditingController nameController = TextEditingController(); //이름 컨트롤러
  TextEditingController phoneController = TextEditingController(); //전화번호 컨트롤러
  TextEditingController idController = TextEditingController(); //아이디 컨트롤러
  TextEditingController pwController = TextEditingController(); //비밀번호 컨트롤러
  TextEditingController pwConfirmController =
      TextEditingController(); //비밀번호 확인 컨트롤러
  TextEditingController emailController = TextEditingController(); //이메일 컨트롤러

  RxnString idError = RxnString('영문 소문자, 숫자를 조합하여 6~12자로 입력해주세요.');
  RxnString pwError =
      RxnString('영문 대문자, 소문자, 숫자, 특수문자 중 2가지 이상을 조합하여 8~20자로 입력해주세요.');
  RxnString pwConfirmError =
      RxnString('영문 대문자, 소문자, 숫자, 특수문자 중 2가지 이상을 조합하여 8~20자로 입력해주세요.');

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

  RxBool isSignupBtnActivated = false.obs; //가입하기 버튼 활성화 여부

  //페이지 이동
  jumpToPage(page) {
    currentPage(page);
    pageController.jumpToPage(page);
  }

  //이전 페이지 이동
  backToPage(page) {
    currentPage(page);
    if (currentPage.value < 0.0) {
      Get.back();
    } else {
      pageController.jumpToPage(page);
    }
  }

  //아이디 형식 체크
  checkIdValidation(String value) {
    if (!RegExp(r'''^(?=.*[a-z])(?=.*[0-9]).{6,12}$''').hasMatch(value)) {
      idError('영문 소문자, 숫자를 조합하여 6~12자로 입력해주세요.');
    } else {
      idError.value = null;
    }
    activateSignupButton();
  }

  //비밀번호 형식 체크
  checkPwValidation(String value) {
    if (!RegExp(
            r'''^(?!((?:[A-Z]+)|(?:[a-z]+)|(?:[~!@#$%^&*()_+=]+)|(?:[0-9]+))$)[A-Z\da-z\d~!@#$%^&*()_+=]{8,20}$''')
        .hasMatch(value)) {
      pwError('영문 대문자, 소문자, 숫자, 특수문자 중 2가지 이상을 조합하여 8~20자로 입력해주세요.');
    } else {
      pwError('사용 가능한 비밀번호입니다.');
    }
    activateSignupButton();
  }

  //비밀번호 확인 형식 체크
  checkPwConfirmValidation(String value) {
    if (!RegExp(
            r'''^(?!((?:[A-Z]+)|(?:[a-z]+)|(?:[~!@#$%^&*()_+=]+)|(?:[0-9]+))$)[A-Z\da-z\d~!@#$%^&*()_+=]{8,20}$''')
        .hasMatch(value)) {
      pwConfirmError('영문 대문자, 소문자, 숫자, 특수문자 중 2가지 이상을 조합하여 8~20자로 입력해주세요.');
    } else {
      pwConfirmError.value = null;
      if (pwController.text == value) {
        pwConfirmError('비밀번호가 확인되었습니다.');
      }
    }
    activateSignupButton();
  }

  //아이디 중복 확인
  checkIdDuplicate() async {
    if (await Get.find<AuthController>().checkIdDuplicate(idController.text)) {
      idError('사용 가능한 아이디입니다.');
    } else {
      idError('해당 아이디는 다른 사람이 사용중인 아이디입니다.');
    }
    activateSignupButton();
  }

  //회원가입
  signup() async {
    UserInfo user = UserInfo(
        name: nameController.text,
        phone: phoneController.text,
        email: emailController.text);

    await Get.find<AuthController>()
        .signup(idController.text, pwController.text, user);
    jumpToPage(2);
  }

  //약관 동의
  checkAgreement(index, value) {
    agreement[index]['value'](value);
    for (var data in agreement) {
      if (data['value'].value == false) {
        isAllChecked(false);
      }
    }
    activateSignupButton();
  }

  //전체 약관 동의
  checkAllAgreement(value) {
    isAllChecked(value);
    for (var i = 0; i < 4; i++) {
      agreement[i]['value'](value);
    }
    activateSignupButton();
  }

  //가입하기 버튼 활성화 체크
  activateSignupButton() {
    if (idError.value != null &&
        idError.value!.length < 25 &&
        pwError.value != null &&
        pwError.value!.length < 25 &&
        pwConfirmError.value != null &&
        pwConfirmError.value!.length < 25 &&
        emailController.text.isNotEmpty &&
        agreement[0]['value'].value &&
        agreement[1]['value'].value &&
        agreement[2]['value'].value) {
      isSignupBtnActivated(true);
    } else {
      isSignupBtnActivated(false);
    }
  }
}
