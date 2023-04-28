import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:jangjeon/view/widget/app_floatingaction_button.dart';
import 'package:jangjeon/view/widget/app_navigation_bar.dart';

class StockPage extends StatelessWidget {
  const StockPage({super.key});
  static const route = '/stock';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back_ios_new)),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            const SizedBox(width: 12)
          ],
        ),
        body: Center(
          child: Text('주식 페이지'),
        ),
        floatingActionButton: AppFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AppNabigationBar());
  }
}
