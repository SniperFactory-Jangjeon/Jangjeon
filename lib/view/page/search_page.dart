import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/main_controller.dart';
import 'package:jangjeon/controller/search_controller.dart';
import 'package:jangjeon/util/app_color.dart';
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
          focusNode: controller.focusNode,
          controller: controller.searchTextController,
          cursorColor: AppColor.grayscale30,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onChanged: (_) => controller.searchStock(),
        ),
        leading: IconButton(
          onPressed: () {
            Get.find<MainController>().bottomNavIndex(1);
            Get.back();
            Get.find<MainController>().bottomNavIndex(2);
          },
          icon: const Icon(Icons.navigate_before),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                FocusScope.of(context).requestFocus(controller.focusNode),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          const Divider(thickness: 10),
          Expanded(
            child: Obx(
              () => ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: controller.searchList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SearchTile(
                      index: index + 1,
                      stock: controller.searchList[index],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
