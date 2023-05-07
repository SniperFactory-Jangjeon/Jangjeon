import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/auth_controller.dart';
import 'package:jangjeon/util/app_routes.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class LoginController extends GetxController {
  TextEditingController idController = TextEditingController(); //아이디 컨트롤러
  TextEditingController pwController = TextEditingController(); //비밀번호 컨트롤러

  RxBool isButtonActivate = false.obs; //로그인 버튼 활성화 여부

  //아이디 로그인
  login() async {
    var result = await Get.find<AuthController>()
        .login(idController.text, pwController.text);
    if (result) {
    } else {
      Get.snackbar('로그인 실패', '존재하지 않는 회원 정보입니다.');
    }
  }

  //카카오톡 로그인
  kakaoLogin() async {
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공');
        Get.toNamed(AppRoutes.main);
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
          Get.toNamed(AppRoutes.main);
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
        Get.toNamed(AppRoutes.main);
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }

  //카카오톡 로그아웃
  signOut() async {
    await UserApi.instance.logout();
    Get.toNamed(AppRoutes.login);
    print('로그아웃');
  }

  readUser() async {
    // 사용자 정보 재요청
    try {
      User user = await UserApi.instance.me();
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
          '\n이메일: ${user.kakaoAccount?.email}');
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }

  //로그인 버튼 활성화
  activateLoginBtn() {
    if (idController.text.isNotEmpty && pwController.text.isNotEmpty) {
      isButtonActivate.value = true;
    } else {
      isButtonActivate.value = false;
    }
  }
}
