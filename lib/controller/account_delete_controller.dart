import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/auth_controller.dart';
import 'package:jangjeon/service/db_service.dart';
import 'package:jangjeon/util/app_routes.dart';
import 'package:jangjeon/model/userInfo.dart' as profile;

class AccountDeleteController extends GetxController {
  Rx<User> get user => Get.find<AuthController>().user!.obs;
  PageController pageController = PageController(); //페이지 뷰 컨트롤러
  RxInt currentPage = 0.obs; //회원탈퇴 현재 페이지
  RxBool isAccountDeleteAgree = false.obs; //동의하기 버튼 활성화 여부
  RxBool isAccountDeleteBtnActivated = false.obs; //탈퇴하기 버튼 활성화 여부
  var accountDeleteReasonController = TextEditingController(); //회원탈퇴 이유

  Rxn<profile.UserInfo> userInfo = Rxn<profile.UserInfo>();

  //유저 정보 가져오기
  getUserInfo() async {
    var res = await DBService().getUserInfo(user.value.uid);
    return res;
  }

  getData() async {
    await DBService().getUserInfo(user.value.uid);
  }

  //페이지 이동
  jumpToPage(page) {
    currentPage(page);
    pageController.jumpToPage(page);
  }

  //회원탈퇴
  deleteUser() {
    Get.find<AuthController>().deleteUser();
    Get.offAllNamed(AppRoutes.login);
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

  @override
  void onInit() async {
    super.onInit();
    userInfo(await getUserInfo());
  }
}
