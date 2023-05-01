import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/signup_controller.dart';
import 'package:jangjeon/view/screen/signup_screen.dart';
import 'package:jangjeon/view/screen/signup_success_screen.dart';
import 'package:jangjeon/view/screen/verification_screen.dart';

class SignupPage extends GetView<SignupController> {
  const SignupPage({super.key});
  static const route = '/signup';

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: controller.currentPage.value != 2
            ? AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.black,
                leading: IconButton(
                  icon: const Icon(Icons.navigate_before),
                  onPressed: () =>
                      controller.backToPage(controller.currentPage.value - 1),
                ),
              )
            : null,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: PageView(
            controller: controller.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              VerificationScreen(),
              SignupScreen(),
              SignupSuccessScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
