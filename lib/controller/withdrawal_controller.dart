import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class WithdrawalController extends GetxController {
  RxBool isWithdrawalAgree = false.obs;
  var withdrawalReason = TextEditingController();

  //회원탈퇴 동의
  withdrawalAgree() {
    if (isWithdrawalAgree.isTrue) {
      isWithdrawalAgree(false);
    } else {
      isWithdrawalAgree(true);
    }
  }
}
