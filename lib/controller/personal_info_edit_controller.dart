import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/auth_controller.dart';
import 'package:jangjeon/controller/setting_controller.dart';
import 'package:jangjeon/service/db_service.dart';
import 'package:jangjeon/service/sms_service.dart';
import 'package:jangjeon/service/storage_service.dart';
import 'package:jangjeon/model/userInfo.dart' as profile;

class PersonalInfoEditController extends GetxController {
  Rx<User> get user => Get.find<AuthController>().user!.obs;
  Rxn<String> profileUrl =
      Rxn<String>(Get.find<SettingController>().profileUrl.value);

  Rxn<profile.UserInfo> userInfo = Rxn<profile.UserInfo>();

  final int limitTime = 300; //SMS타이머 5분
  Timer? timer;

  var phoneController = TextEditingController(); //본인인증 전화번호
  var certifyController = TextEditingController(); //본인인증 인증번호
  var nameController = TextEditingController(); //개인정보 설정 이름
  var pwController = TextEditingController(); //개인정보 설정 비밀번호
  var pwconfirmController = TextEditingController(); //개인정보 설정 비밀번호 확인
  RxBool isCertifyButton = false.obs; //인증요청버튼 활성화 여부
  RxBool isShowAuthNumberField = false.obs; //인증번호입력 텍스트필드 Visible 활성화 여부
  RxBool isConfirmCodeBtnActivated = false.obs; //코드 확인 버튼 활성화 여부
  RxBool isNextPageButton = false.obs; //개인정보수정하러가기 버튼 활성화 여부

  String code = '000000';

  RxnString verificationCodeError = RxnString();

  gallery() async {
    var storageService = StorageService();
    var url = await storageService.gallery();
    profileUrl.value = url.value;
    Get.find<SettingController>().profileUrl(url.value);
    Get.back();
  }

  camera() async {
    var storageService = StorageService();
    var url = await storageService.camera();
    profileUrl.value = url.value;
    Get.find<SettingController>().profileUrl(url.value);
    Get.back();
  }

  defaultImage() async {
    var storageService = StorageService();
    await storageService.defalutImage();
    profileUrl.value = null;
    Get.find<SettingController>().profileUrl.value = null;
    Get.back();
  }

  updateUserinfo(String uid, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection('userInfo')
        .doc(uid)
        .update(data);
  }

  cupertinoActionSheet() {
    return CupertinoActionSheet(
      title: const Text('프로필 사진 변경'),
      actions: [
        CupertinoActionSheetAction(
            onPressed: gallery, child: const Text('앨범에서 사진 선택')),
        CupertinoActionSheetAction(onPressed: camera, child: const Text('카메라')),
        CupertinoActionSheetAction(
            onPressed: defaultImage, child: const Text('기본 이미지로 변경'))
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text('취소'),
        onPressed: () => Get.back(),
      ),
    );
  }

  //유저 정보 가져오기
  getUserInfo() async {
    var res = await DBService().getUserInfo(user.value.uid);
    return res;
  }

  //인증요청 버튼 활성화
  certifyButton() {
    //유저 폰번호랑 같으면..?
    if (phoneController.text.isNotEmpty &&
        phoneController.text == userInfo.value?.phone) {
      isCertifyButton.value = true;
    } else {
      isCertifyButton.value = false;
    }
  }

//인증번호 형식 체크
  checkCodeValidation() {
    if (certifyController.text.isNotEmpty) {
      isConfirmCodeBtnActivated(true);
    } else {
      isConfirmCodeBtnActivated(false);
    }
    nextPageButton();
  }

  //인증번호 요청
  requestVerificationCode() async {
    code = (Random().nextInt(899999) + 100000).toString();
    await SMSService().requestVerificationCode(phoneController.text, code);
    isShowAuthNumberField.value = true;
    // if(){}
  }

  //인증번호 확인
  checkVerificationCode() {
    if (code == certifyController.text) {
      verificationCodeError('인증이 완료되었습니다.');
    } else {
      verificationCodeError('인증 번호가 일치하지 않습니다. 다시 입력해주세요.');
    }
    nextPageButton();
  }

  //개인정보 수정하러가기 버튼 활성화
  nextPageButton() {
    if (certifyController.text.isNotEmpty &&
        verificationCodeError.value != null &&
        verificationCodeError.value!.length < 25) {
      isNextPageButton.value = true;
    } else {
      isNextPageButton.value = false;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    userInfo(await getUserInfo());
  }

  resetTimer() {
    timer?.cancel();
    timer = null;
  }

  @override
  void dispose() {
    resetTimer();
    super.dispose();
  }
}
