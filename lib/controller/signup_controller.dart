import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/auth_controller.dart';
import 'package:jangjeon/model/userInfo.dart';
import 'package:jangjeon/service/sms_service.dart';

class SignupController extends GetxController {
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
  TextEditingController emailController = TextEditingController(); //아이디 컨트롤러
  TextEditingController pwController = TextEditingController(); //비밀번호 컨트롤러
  TextEditingController pwConfirmController =
      TextEditingController(); //비밀번호 확인 컨트롤러

  String code = '000000';

  RxnString verificationCodeError = RxnString();
  RxnString emailError = RxnString('인증메일을 받을 수 있는 이메일 주소를 입력해주세요.');
  RxnString pwError =
      RxnString('영문 대문자, 소문자, 숫자, 특수문자 중 2가지 이상을 조합하여 8~20자로 입력해주세요.');
  RxnString pwConfirmError =
      RxnString('영문 대문자, 소문자, 숫자, 특수문자 중 2가지 이상을 조합하여 8~20자로 입력해주세요.');

  RxBool isAllChecked = false.obs; //약관 전체 동의
  List agreement = [
    {
      'title': '[필수] 서비스 이용약관',
      'value': false.obs,
      'content': '''[서비스 이용약관]
제1조 (목적) 이 약관은 "장전" 앱(이하 '서비스'라 함)을 이용함에 있어 이용자와 "장전" 앱 운영자 간의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.
제2조 (용어의 정의)
"서비스"는 "장전" 앱을 의미합니다.
"이용자"는 "장전" 앱에 접속하여 이 약관에 따라 "장전" 앱이 제공하는 서비스를 받는 회원 및 비회원을 의미합니다.
"회원"은 "장전" 앱에 회원가입을 하여 아이디(ID)와 비밀번호를 부여받은 자로서, "장전" 앱이 제공하는 서비스를 지속적으로 이용할 수 있는 자를 의미합니다.
"비회원"은 회원가입 없이 "장전" 앱이 제공하는 일부 서비스를 이용하는 자를 의미합니다.
"운영자"는 "장전" 앱을 운영하는 사람을 의미합니다.
제3조 (약관의 게시와 개정)
"장전" 앱은 본 약관을 이용자가 쉽게 알 수 있도록 초기 화면에 게시합니다.
"장전" 앱은 필요하다고 인정되면 언제든지 본 약관을 개정할 수 있습니다.
"장전" 앱이 본 약관을 개정할 경우에는 개정된 약관을 적용하고 그 개정된 약관의 적용일자와 개정 사유를 명시하여 현행 약관과 함께 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 다만, 회원에게 불리하게 약관 내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다.
제4조 (서비스의 제공 및 변경)
"장전" 앱은 이용자에게 아래와 같은 서비스를 제공합니다.
해외주식 시장에서 실시간으로 제공되는 뉴스 번역 서비스
다양한 언어로 제공되는 뉴스 자동 번역 서비스
분석 및 예측 보고서 제공
기타 "장전" 앱이 추가로 개발하거나 다른 회사와의 제휴 계약 등을 통해 이용자에게 제공
"장전" 앱은 서비스의 향상을 위해 필요한 경우에는 서비스의 전부 또는 일부를 변경할 수 있습니다. 이 경우 "장전" 앱은 변경된 서비스의 내용 및 제공일자를 명시하여 현행 서비스와 함께 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다.
제5조 (서비스 이용 계약의 성립)
이용자는 "장전" 앱에서 제공하는 이용신청 양식에서 요구하는 모든 사항을 정확하게 기재하여 신청해야 합니다.
"장전" 앱은 제1항과 같이 이용자가 요구하는 사항을 정확히 기재하였을 경우 서비스 이용 계약을 승낙합니다.
서비스 이용 계약은 이용자가 "장전" 앱에서 제공하는 회원가입 양식에 동의하고 가입을 완료하는 시점에 성립합니다.
제6조 (서비스 이용의 제한)
"장전" 앱은 이용자가 본 약관에 위반되는 행위를 한 경우, 서비스 이용을 일시적으로 제한하거나 영구적으로 이용을 중단할 수 있습니다.
이용자는 다음 각 호의 행위를 하여서는 안 됩니다.
타인의 정보 도용 및 사칭
서비스 이용 중 개인정보를 포함한 타인의 정보를 수집, 저장, 공개하는 행위
"장전" 앱의 서비스 운영을 방해하는 행위
"장전" 앱의 저작권 및 지적재산권을 침해하는 행위
기타 불법적이거나 부당한 행위
이용자가 제2항에서 규정한 행위를 한 경우, "장전" 앱은 해당 이용자에 대하여 서비스 이용 제한, 강제 탈퇴, 손해배상청구 등 법적인 조치를 취할 수 있습니다.
제7조 (이용자의 개인정보 보호)
"장전" 앱은 이용자의 개인정보를 보호하기 위해 관련 법령에 따라 개인정보 처리 방침을 정하고 이를 공지합니다.
"장전" 앱은 이용자의 개인정보를 보호하기 위해 보안 시스템을 운영하며, 이용자의 개인정보를 수집, 이용, 제공하는 경우에는 이용자의 동의를 받습니다.제8조 (손해배상)
"장전" 앱은 이용자의 귀책사유로 인하여 "장전" 앱이 손해를 입게 되는 경우, 해당 이용자는 "장전" 앱에 대하여 그 손해를 배상하여야 합니다.
이용자가 이 약관을 위반함으로써 "장전" 앱에 손해를 입힌 경우, "장전" 앱은 해당 이용자에 대하여 손해배상을 청구할 수 있습니다.
제9조 (면책조항)
"장전" 앱은 천재지변, 전쟁, 기간통신사업자의 서비스 중단, 해킹 등으로 인한 시스템 오류 및 불법적인 사용자의 공격 등으로 인한 서비스 이용의 장애 등으로 인하여 이용자에게 발생한 손해에 대하여는 책임을 지지 않습니다.
"장전" 앱은 이용자의 귀책사유로 인한 서비스 이용 장애 및 손해에 대하여 책임을 지지 않습니다.
제10조 (분쟁해결 및 관할법원)
"장전" 앱과 이용자 간에 발생한 분쟁에 관한 소송은 대한민국 법령에 따라 결정됩니다.
"장전" 앱과 이용자 간에 발생한 분쟁으로 인하여 소송이 제기될 경우, 관할법원은 "장전" 앱의 본사 소재지를 관할하는 법원으로 합니다.
부칙
이 약관은 2023년 4월 27일부터 적용됩니다.''',
    },
    {
      'title': '[필수] 개인정보 수집 및 이용 동의',
      'value': false.obs,
      'content': '''[개인정보 수집 및 이용 동의]
제1조 (목적) 본 약관은 "장전" 앱이 제공하는 서비스 이용과 관련하여, 이용자의 개인정보를 수집, 이용하는 절차 및 방법 등에 관한 사항을 규정함을 목적으로 합니다.
제2조 (수집하는 개인정보 항목)
수집항목 : 이용자의 이메일 주소, 닉네임, 로그인 기록, 기기정보, 이용시간, 이용로그
수집방법 : "장전" 앱 내 회원가입 시 이용자가 직접 입력하는 방식으로 수집됩니다.
제3조 (개인정보의 수집 및 이용 목적)
이메일 주소 : 회원 식별, 이용자에 대한 서비스 제공, 고지사항 전달
닉네임 : 서비스 이용에 필요한 식별 정보 제공
로그인 기록 : 서비스 이용에 대한 통계자료 분석 및 서비스 개선을 위한 자료로 활용
기기정보 : 서비스 이용 환경 개선 및 통계 분석 자료로 활용
이용시간 및 이용로그 : 서비스 이용 현황 파악 및 서비스 개선을 위한 자료로 활용
제4조 (개인정보의 보유 및 이용기간) 이용자의 개인정보는 수집 및 이용목적이 달성되면 지체 없이 파기합니다. 단, 관계법령에 따라 보관할 필요성이 있는 경우에는 해당 기간 보관합니다.
제5조 (개인정보의 제3자 제공) "장전" 앱은 이용자의 개인정보를 본인의 동의 없이 제3자에게 제공하지 않습니다. 단, 다음의 경우에는 예외로 합니다.
이용자가 사전에 제3자에게 개인정보 제공에 동의한 경우
법령의 규정에 의거하거나, 수사 등 공익을 위하여 필요한 경우제6조 (이용자의 권리) 3. 이용자는 언제든지 개인정보의 수집, 이용, 제공에 대한 동의 철회를 요청할 수 있습니다. 이 경우 "장전" 앱은 지체 없이 이용자의 개인정보를 파기합니다.
이용자가 개인정보의 수집, 이용, 제공에 대한 동의를 철회하는 경우, "장전" 앱은 해당 이용자에게 불이익이 발생하지 않도록 조치합니다.
제7조 (개인정보의 파기)
"장전" 앱은 개인정보 보유기간의 경과, 수집 목적 달성 등 개인정보가 불필요하게 되었을 경우에는 지체 없이 해당 정보를 파기합니다.
이용자가 개인정보 수집 및 이용에 대한 동의를 철회한 경우, "장전" 앱은 지체 없이 해당 이용자의 개인정보를 파기합니다.
제8조 (개인정보의 안전성 확보 조치) "장전" 앱은 개인정보의 안전성을 확보하기 위하여 다음과 같은 조치를 취하고 있습니다.
개인정보의 암호화 : 이용자의 개인정보는 비밀번호 등의 보안기능을 통해 암호화되어 저장 및 관리됩니다.
개인정보 처리 직원의 최소화 및 교육 : 개인정보를 처리하는 직원은 최소화되며, 개인정보 처리에 필요한 교육을 받고 있습니다.
개인정보보호전담기구의 운영 : 개인정보보호전담기구를 운영하여 개인정보의 안전성을 확보하고 있습니다.
개인정보 처리시스템 점검 및 개선 : "장전" 앱은 개인정보 처리시스템의 취약점을 파악하고 이를 보완하기 위해 개선에 최선을 다하고 있습니다.
제9조 (개인정보 보호책임자) "장전" 앱은 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 이용자의 불만처리 및 피해구제를 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.
개인정보 보호책임자 이름 : [이름] 직책 : [직책] 연락처 : [연락처''',
    },
    {
      'title': '[필수] 개인정보 제 3자 제공 동의',
      'value': false.obs,
      'content': '''[개인정보의 제3자 제공 동의]
제1조 (목적) 본 약관은 "장전" 앱에서 제공하는 서비스를 이용함에 있어, "장전" 앱이 이용자의 개인정보를 어떠한 목적과 방식으로 수집, 이용하고 있는지, 그리고 개인정보를 보호하기 위한 조치 등을 규정함을 목적으로 합니다.
제2조 (수집하는 개인정보 항목 및 수집 방법)
"장전" 앱은 서비스 제공을 위하여 이용자로부터 다음과 같은 개인정보를 수집할 수 있습니다.
필수 수집 정보: 이메일 주소, 이름, 비밀번호, 프로필 이미지 등
선택 수집 정보: 거주 지역, 관심 주식 종목, 투자 성향 등
"장전" 앱은 다음과 같은 방식으로 개인정보를 수집합니다.
이용자가 직접 입력한 정보
이용자가 제공한 외부 계정 정보
서비스 이용 과정에서 생성된 정보
제3조 (개인정보의 제3자 제공)
"장전" 앱은 이용자의 개인정보를 제3자에게 제공하지 않습니다. 다만, 이용자의 동의가 있거나 법령의 규정에 의한 경우에는 예외로 합니다.
제4조 (개인정보의 보유 및 이용 기간)
"장전" 앱은 이용자의 개인정보를 수집한 목적이 달성되면 지체 없이 파기합니다. 단, 이용자의 요청에 의해 개인정보를 보유하여야 하는 경우, 법령에서 정한 일정한 기간 동안 보관할 수 있습니다.
"장전" 앱은 이용자가 서비스를 이용하는 동안에만 개인정보를 이용하며, 이용목적이 달성되거나 이용자의 요청에 의해 파기될 때까지 보유 및 이용됩니다.
제5조 (개인정보의 제3자 제공)
"장전" 앱은 이용자의 개인정보를 제1조에서 고지한 범위 내에서만 사용하며, 이용자의 사전 동의 없이는 동 범위를 초과하여 이용하거나 원칙적으로 제3자에게 제공하지 않습니다.
다음은 개인정보를 제3자에게 제공하는 경우이며, 이용자의 사전 동의를 받고 있습니다.
개인정보를 제공받는 자: [제공받는 자의 성명 또는 상호]
제공받는 자의 개인정보 이용목적: [제공받는 자의 개인정보 이용목적]
제공하는 개인정보의 항목: [제공하는 개인정보의 항목]
개인정보 보유 및 이용기간: [개인정보 보유 및 이용기간]
제6조 (개인정보의 안전성 확보 조치)
"장전" 앱은 이용자의 개인정보를 안전하게 관리하기 위하여 다음과 같은 조치를 취하고 있습니다.
이용자의 개인정보를 암호화하여 저장하고 있습니다.
개인정보를 처리하는 데이터베이스에 대한 접근권한을 가진 사람을 최소한으로 제한하고 있습니다.
개인정보보호 업무를 수행하는 담당자를 지정하여 이를 강화하고 있습니다.
제7조 (개인정보 보호책임자)
"장전" 앱은 이용자의 개인정보 처리와 관련한 업무를 총괄해서 책임지고, 개인정보와 관련한 이용자의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.
개인정보 보호책임자 성명: [보호책임자 성명]
개인정보 보호책임자 연락처: [보호책임자 연락처]
이용자는 "장전" 앱을 이용하면서 발생한 모든 개인정보 보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자에게 문의하실 수 있습니다. "장전" 앱은 이용자의 문의에 대해 신속하게 답변 및 처리해드릴 것입니다.
제8조 (개인정보 처리방침 변경)
이 개인정보 처리방침은 법령, 정책 또는 보안기술의 변경에 따라 내용이 추가, 삭제, 수정될 수 있습니다.
이용자는 개인정보 처리방침 변경 시 개인정보보호 관련 법령 등에 따라 "장전" 앱이 고지하는 절차에 따라 변경된 개인정보 처리방침에 대해 동의 또는 거부할 수 있습니다.
"장전" 앱은 이 개인정보 처리방침을 변경할 경우 변경 사항을 시행하기 최소 7일 전에 서비스 초기 화면, 이메일, 문자 등을 통해 이용자에게 알리고, 이용자가 동의하지 않는 경우 이용자의 개인정보는 변경 전의 방침에 따라 이용됩니다.
이 개인정보 처리방침은 2023년 4월 27일부터 적용됩니다.''',
    },
    {
      'title': '[선택] 마케팅 정보 수신 동의',
      'value': false.obs,
      'content': '''[마케팅 정보 수신 동의]
"장전" 앱은 이용자에게 별도의 동의가 없는 한, 이용자의 개인정보를 기반으로 제3자에게 광고 및 마케팅 정보를 제공하지 않습니다.
이용자가 "장전" 앱에서 제공하는 광고, 마케팅 정보 등의 정보 수신에 동의할 경우에만 해당 정보를 제공하며, 이 경우 이용자의 개인정보는 안전하게 보호됩니다.
이용자가 "장전" 앱에서 제공하는 광고, 마케팅 정보 등의 정보 수신에 동의하지 않을 경우, "장전" 앱은 해당 정보를 제공하지 않습니다.
이용자는 언제든지 "장전" 앱의 마케팅 정보 수신 동의를 철회할 수 있으며, 이 경우 "장전" 앱은 즉시 해당 정보의 제공을 중단합니다.
[동의 철회 방법] 이용자는 언제든지 "장전" 앱에서 제공하는 마케팅 정보 수신 동의를 철회할 수 있습니다. 동의 철회를 원하는 경우에는 "장전" 앱 내 마케팅 정보 수신 동의 관리 메뉴를 이용하시거나, "장전" 앱의 고객센터를 통해 신청하실 수 있습니다.''',
    },
  ]; //이용약관

  RxBool isVerificationBtnActivated = false.obs; //인증하기 버튼 활성화 여부
  RxBool isConfirmCodeBtnActivated = false.obs; //코드 확인 버튼 활성화 여부
  RxBool isNextBtnActivated = false.obs; //다음단계 버튼 활성화 여부
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

  //이메일 형식 체크
  checkEmailValidation(String value) {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      emailError('인증메일을 받을 수 있는 이메일 주소를 입력해주세요.');
    } else {
      emailError.value = null;
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
    if (await Get.find<AuthController>()
        .checkIdDuplicate(emailController.text)) {
      emailError('사용 가능한 이메일입니다.');
    } else {
      emailError('가입된 이메일입니다. 다른 이메일을 입력해 주세요.');
    }
    activateSignupButton();
  }

  //회원가입
  signup() async {
    UserInfo user = UserInfo(
        name: nameController.text,
        phone: phoneController.value.text,
        email: emailController.text,
        commentCount: 0,
        optionalAgreement: agreement[3]['value'].value);

    await Get.find<AuthController>()
        .signup(emailController.text, pwController.text, user);
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
    if (emailError.value != null &&
        emailError.value!.length < 25 &&
        pwError.value != null &&
        pwError.value!.length < 25 &&
        pwConfirmError.value != null &&
        pwConfirmError.value!.length < 25 &&
        agreement[0]['value'].value &&
        agreement[1]['value'].value &&
        agreement[2]['value'].value) {
      isSignupBtnActivated(true);
    } else {
      isSignupBtnActivated(false);
    }
  }
}
