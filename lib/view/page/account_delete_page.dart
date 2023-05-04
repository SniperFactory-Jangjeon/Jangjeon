import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/account_delete_controller.dart';
import 'package:jangjeon/view/screen/account_delete_screen.dart';
import 'package:jangjeon/view/screen/account_delete_success_screen.dart';

class AccountDeletePage extends GetView<AccountDeleteController> {
  const AccountDeletePage({super.key});
  static const route = '/accountDelete';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          AccountDeleteScreen(),
          AccountDeleteSuccessScreen(),
        ],
      ),
    );
  }
}
