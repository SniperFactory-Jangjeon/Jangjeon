import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/main_controller.dart';
import 'package:jangjeon/util/app_routes.dart';
import 'package:jangjeon/view/screen/setting_screen.dart';
import 'package:jangjeon/view/screen/main_stock_screen.dart';
import 'package:jangjeon/view/widget/app_floatingaction_button.dart';
import 'package:jangjeon/view/widget/app_navigation_bar.dart';

class MainPage extends GetView<MainController> {
  const MainPage({super.key});
  static const route = '/main';

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          appBar: [
            AppBar(
              leading: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.notifications)),
              elevation: 0,
              foregroundColor: Colors.black,
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                  onPressed: () => Get.toNamed(AppRoutes.search),
                  icon: const Icon(Icons.search),
                )
              ],
            ),
            AppBar(
              leading: IconButton(
                  onPressed: () {
                    controller.bottomNavIndex.value = 0;
                  },
                  icon: const Icon(Icons.navigate_before)),
              elevation: 0,
              foregroundColor: Colors.black,
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                    onPressed: () => Get.toNamed(AppRoutes.ticket),
                    icon: const Icon(CupertinoIcons.ticket))
              ],
            )
          ][controller.bottomNavIndex.value],
          body: SafeArea(
            child: [
              MainStockScreen(),
              SettingScreen()
            ][controller.bottomNavIndex.value],
          ),
          floatingActionButton: AppFloatingActionButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AppNavigationBar()),
    );
  }
}
