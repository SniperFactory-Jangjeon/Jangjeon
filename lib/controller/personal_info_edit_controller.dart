import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/auth_controller.dart';
import 'package:jangjeon/controller/setting_controller.dart';
import 'package:jangjeon/service/auth_service.dart';
import 'package:jangjeon/service/db_service.dart';
import 'package:jangjeon/service/sms_service.dart';
import 'package:jangjeon/service/storage_service.dart';
import 'package:jangjeon/model/userInfo.dart' as profile;
import 'package:jangjeon/view/widget/app_dialog.dart';

class PersonalInfoEditController extends GetxController {
  Rx<User> get user => Get.find<AuthController>().user!.obs;
  Rxn<String> profileUrl =
      Rxn<String>(Get.find<SettingController>().profileUrl.value);
  Rxn<String> name = Rxn<String>(Get.find<SettingController>().name.value);
  PageController pageController = PageController(); //페이지 뷰 컨트롤러
  RxInt currentPage = 0.obs; //개인정보 설정 첫 페이지(휴대폰인증)

  //firebase userInfo 가져오기
  Rxn<profile.UserInfo> userInfo = Rxn<profile.UserInfo>();

  static const int lIMITTIME = 10;
  final RxInt currentTime = 10.obs; //SMS타이머 1분
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
  RxnString nicknameError = RxnString('변경할 닉네임을 입력해주세요.');
  RxnString pwError =
      RxnString('영문 대문자, 소문자, 숫자, 특수문자 중 2가지 이상을 조합하여 8~20자로 입력해주세요.');
  RxnString pwConfirmError =
      RxnString('영문 대문자, 소문자, 숫자, 특수문자 중 2가지 이상을 조합하여 8~20자로 입력해주세요.');

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

  //로그인 제공업체에 따라 아이콘 변경
  providerUserIcon() {}

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
    isCertifyButton.value = false;
    code = (Random().nextInt(899999) + 100000).toString();
    await SMSService().requestVerificationCode(phoneController.text, code);
    isShowAuthNumberField.value = true;
    if (!isCertifyButton.value) {
      resetTimer();
    }
    if (!(timer?.isActive ?? false)) {
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (timer.tick == lIMITTIME) {
          resetTimer();
          isCertifyButton.value = true;
        } else {
          currentTime.value -= 1;
        }
      });
    } else {
      isCertifyButton.value = false;
    }
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

  //닉네임 중복 체크
  checkDuplicateNickname(String value) async {
    if (await Get.find<AuthController>()
        .checkDuplicateNickname(nameController.text)) {
      nicknameError('사용중인 닉네임입니다. 다른 닉네임을 입력해 주세요.');
    } else {
      nicknameError('사용 가능한 닉네임입니다.');
    }
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
  }

  //개인정보 수정
  changeUserInfo() {
    if (nicknameError.value!.length < 15 || pwConfirmError.value!.length < 15) {
      Get.dialog(AppDialog(
          content: '저장완료',
          subcontent: '개인정보 변경이 완료되었습니다.',
          onCancel: () => Get.back(),
          onConfirm: () => Get.back(),
          cancelText: '취소',
          confirmText: '확인'));
      if (nameController.text.isEmpty) {
        AuthService().changePassword(pwconfirmController.text);
      }
      if (pwConfirmError.value!.length > 15) {
        DBService().updatename(user.value.uid, nameController.text);
      }
      if (nicknameError.value!.length < 15 &&
          pwConfirmError.value!.length < 15) {
        AuthService().changePassword(pwconfirmController.text);
        DBService().updatename(user.value.uid, nameController.text);
      }
    } else {
      // Get.snackbar('개인정보를 수정하세요.', '개인정보를 수정하지 않았습니다.');
      null;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    userInfo(await getUserInfo());
  }

  resetTimer() {
    currentTime.value = lIMITTIME;
    timer?.cancel(); //특정 기대치에 도달하면 타이머 중지
    timer = null;
  }

  @override
  void dispose() {
    resetTimer();
    super.dispose();
  }
}
