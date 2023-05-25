import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/main_controller.dart';
import 'package:jangjeon/controller/search_controller.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/util/app_routes.dart';
import 'package:jangjeon/view/widget/search_tile.dart';

class SearchPage extends GetView<SearchController> {
  const SearchPage({super.key});
  static const route = '/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColor.grayscale100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TextField(
          controller: controller.searchTextController,
        ),
        leading: IconButton(
            onPressed: () {
              Get.find<MainController>().getMyStock();
              Get.back();
            },
            icon: Icon(Icons.navigate_before)),
        actions: [
          IconButton(
            onPressed: controller.searchStock,
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.searchList.length,
          itemBuilder: (context, index) {
            return SearchTile(
              index: index + 1,
              stock: controller.searchList[index],
            );
          },
        ),
      ),
    );
  }
}