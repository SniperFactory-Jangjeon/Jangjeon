import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/auth_controller.dart';

class SettingController extends GetxController {
  Rx<User> get user => Get.find<AuthController>().user!.obs;
  Rxn<String> profileUrl =
      Rxn<String>(Get.find<AuthController>().user!.photoURL);
  RxBool isNotifycation = false.obs;
  RxBool isMarketingAgree = false.obs;

  //로그아웃
  logout() => Get.find<AuthController>().logout();

  //뉴스 알림 체크?
  notifycation() {
    if (isNotifycation.isTrue) {
      isNotifycation(false);
    } else {
      isNotifycation(true);
    }
  }

  //마케팅 정보 수신 동의 체크?
  marketingAgree() {
    if (isMarketingAgree.isTrue) {
      isMarketingAgree(false);
    } else {
      isMarketingAgree(true);
    }
  }
}
