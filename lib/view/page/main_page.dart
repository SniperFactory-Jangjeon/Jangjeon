import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/main_controller.dart';
import 'package:jangjeon/view/page/home_page.dart';
import 'package:jangjeon/view/page/setting_page.dart';
import 'package:jangjeon/view/page/stock_detail_page.dart';
import 'package:jangjeon/view/widget/app_floatingaction_button.dart';
import 'package:jangjeon/view/widget/app_navigation_bar.dart';

class MainPage extends GetView<MainController> {
  const MainPage({super.key});
  static const route = '/main';

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          body: SafeArea(
              child: [
            const StockDetailPage(),
            const SettingPage(),
            const HomePage()
          ][controller.bottomNavIndex.value]),
          floatingActionButton: GestureDetector(
              onTap: () {
                controller.bottomNavIndex(2);
              },
              child: const AppFloatingActionButton()),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: const AppNavigationBar()),
    );
  }
}
