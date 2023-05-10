// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/auth_controller.dart';
import 'package:jangjeon/service/storage_service.dart';

class PersonalInfoEditController extends GetxController {
  Rx<User> get user => Get.find<AuthController>().user!.obs;
  Rxn<String> profileUrl =
      Rxn<String>(Get.find<AuthController>().user!.photoURL);
  final Rxn<UserInfo> userInfo = Rxn<UserInfo>();

  gallery() async {
    var storageService = StorageService();
    var url = await storageService.gallery();
    profileUrl.value = url.value;
    Get.back();
  }

  camera() async {
    var storageService = StorageService();
    var url = await storageService.camera();
    profileUrl.value = url.value;
    Get.back();
  }

  cupertinoActionSheet() {
    return CupertinoActionSheet(
      title: const Text('프로필 사진 변경'),
      actions: [
        CupertinoActionSheetAction(
            onPressed: () {}, child: const Text('앨범에서 사진 선택')),
        CupertinoActionSheetAction(onPressed: () {}, child: const Text('카메라')),
        CupertinoActionSheetAction(
            onPressed: () {}, child: const Text('기본 이미지로 변경'))
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text('취소'),
        onPressed: () => Get.back(),
      ),
    );
  }

  // getProfile() {
  //   String uid = Get.find<AuthController>().user.value!.uid;
  //   FirebaseFirestore.instance.collection('userInfo').doc(uid).get();
  // }
}
