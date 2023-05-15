// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/auth_controller.dart';
import 'package:jangjeon/controller/setting_controller.dart';
import 'package:jangjeon/service/db_service.dart';
import 'package:jangjeon/service/storage_service.dart';

class PersonalInfoEditController extends GetxController {
  Rx<User> get user => Get.find<AuthController>().user!.obs;
  Rxn<String> profileUrl =
      Rxn<String>(Get.find<SettingController>().profileUrl.value);

  var phoneController = TextEditingController();
  var certifyController = TextEditingController();
  RxBool isCertifyButton = false.obs;
  RxBool isNextPageButton = false.obs;
  RxBool isTextFieldVisible = false.obs;

  visibletextfield() {
    isTextFieldVisible.value = true;
  }

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

  //인증번호 버튼 활성화
  certifyButton() {
    //유저 폰번호랑 같으면..?
    if (phoneController.text.isNotEmpty) {
      isCertifyButton.value = true;
    } else {
      isCertifyButton.value = false;
    }
  }

  nextPageButton() {
    if (certifyController.text.isNotEmpty) {
      isNextPageButton.value = true;
    } else {
      isNextPageButton.value = false;
    }
  }
}
