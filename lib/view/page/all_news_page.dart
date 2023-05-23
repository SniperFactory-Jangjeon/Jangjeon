import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/news_detail_controller.dart';
import 'package:jangjeon/util/app_routes.dart';
import 'package:jangjeon/view/widget/news_tile.dart';

class AllNewsPage extends GetView<NewsDetailController> {
  const AllNewsPage({super.key});
  static const route = '/allNews';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: SafeArea(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal:20.0),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.otherNews.length,
              itemBuilder: (context, index) => index == 0
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.newsDetail,
                              arguments: controller.otherNews[index]);
                        },
                        child: NewsTile(
                            title: controller.otherNews[index]['title'],
                            time: controller.otherNews[index]['date'],
                            aiScore: controller.otherNews[index]['aiScore'],
                            img: controller.otherNews[index]['thumbnail']),
                      ),
                    ),
              separatorBuilder: (context, index) =>
                  index == 0 ? const SizedBox() : const Divider(thickness: 1),
            ),
          ),
        ),
      ),
    );
  }
}
