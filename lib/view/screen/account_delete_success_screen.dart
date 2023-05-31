import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/account_delete_controller.dart';
import 'package:jangjeon/view/widget/success_tile.dart';

class AccountDeleteSuccessScreen extends GetView<AccountDeleteController> {
  const AccountDeleteSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SuccessTile(
        title: '회원탈퇴 완료',
        message: '그동안 장전을 이용해주셔서 감사합니다.\n더욱 더 노력하는 장전이 되겠습니다.',
        btnText: '처음으로',
        onPressed: () => controller.deleteUser());
  }
}
