import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/news_detail_controller.dart';
import 'package:jangjeon/util/app_routes.dart';
import 'package:jangjeon/view/widget/news_tile.dart';

class AllNewsPage extends StatelessWidget {
  const AllNewsPage({super.key});
  static const route = '/allNews';

  @override
  Widget build(BuildContext context) {
    RxList allnews = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.search),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: allnews.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: NewsTile(
                    title: allnews[index]['title'],
                    time: allnews[index]['date'],
                    aiScore: allnews[index]['aiScore'],
                    img: allnews[index]['thumbnail'],
                    news: allnews[index],
                    route: AppRoutes.newsDetail,
                    uploadtime: allnews[index]['pubDate'],
                    url: allnews[index]['url'],
                    isOffAndTo: true),
              ),
              separatorBuilder: (context, index) => const Divider(thickness: 1),
            ),
          ),
        ),
      ),
    );
  }
}
