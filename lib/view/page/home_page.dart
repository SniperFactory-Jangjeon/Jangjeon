import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/main_controller.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/util/app_filter.dart';
import 'package:jangjeon/util/app_routes.dart';
import 'package:jangjeon/util/app_text_style.dart';
import 'package:jangjeon/view/widget/ai_chart_bar.dart';
import 'package:jangjeon/view/widget/ai_chart_pie.dart';
import 'package:jangjeon/view/widget/filter_tile.dart';
import 'package:jangjeon/view/widget/main_news_tile.dart';
import 'package:jangjeon/view/widget/news_shimmer_box.dart';

class HomePage extends GetView<MainController> {
  const HomePage({super.key});
  static const route = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
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
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
                child: Text('실시간 핫이슈', style: AppTextStyle.h4B20()),
              ),
              Obx(() => Stack(
                    children: [
                      Container(
                          width: Get.width,
                          height: 150,
                          decoration: controller.hotIssueNews['thumbnail'] !=
                                  null
                              ? BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          controller.hotIssueNews['thumbnail']),
                                      colorFilter: const ColorFilter.mode(
                                          Colors.black45, BlendMode.darken),
                                      fit: BoxFit.cover))
                              : const BoxDecoration(color: Colors.black45)),
                      Positioned(
                          top: 30,
                          left: 20,
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 190,
                                  child: Text(
                                    controller.hotIssueNews['title'] ?? '',
                                    style:
                                        AppTextStyle.b3B16(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                GestureDetector(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.newsDetail,
                                          arguments: controller.hotIssueNews);
                                    },
                                    child: Text('기사보기 >',
                                        style: AppTextStyle.b5R12(
                                            color: Colors.white)))
                              ],
                            ),
                          ))
                    ],
                  )),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('관심 주식', style: AppTextStyle.h4B20()),
                    SizedBox(
                      height: 100,
                      child: Obx(
                        () => ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.myStockList.length,
                          itemBuilder: (context, index) => Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      controller.currentStock.value = controller
                                          .myStockList[index]['symbol'];
                                      controller.getNews();
                                      controller.todayStockNatural(index);
                                    },
                                    child: Obx(
                                      () => CircleAvatar(
                                        backgroundColor: controller
                                                        .myStockList[index]
                                                    ['symbol'] ==
                                                controller.currentStock.value
                                            ? AppColor.red100
                                            : Colors.transparent,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: CircleAvatar(
                                            backgroundColor:
                                                AppColor.grayscale0,
                                            backgroundImage: NetworkImage(
                                                controller.myStockList[index]
                                                    ['logo']),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(controller.myStockList[index]['symbol'],
                                      style: AppTextStyle.b4M14()),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => Text(
                          'AI가 분석한 오늘의 ${controller.currentStock.value} 투자 지수',
                          style: AppTextStyle.h4B20()),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Obx(
                        () => Center(
                            child: AIChartPie(
                          value: controller.investmentIndex.value,
                        )),
                      ),
                    ),
                    Center(
                      child: Text(
                        controller.investmentIndex.value > 50
                            ? '장전해도 좋아요!'
                            : '장전은 미뤄두죠?',
                        style: AppTextStyle.b4R14(),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Obx(
                  () => AIChartBar(
                    investmentIndex: controller.investmentIndex.value,
                  ),
                ),
              ),
              const Divider(thickness: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 70,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: AppFilter.keyword.length,
                        itemBuilder: (context, index) => Center(
                          child: InkWell(
                            onTap: () {
                              controller.filterNews(index);
                            },
                            child: Obx(
                              () => FilterTile(
                                text: AppFilter.keyword[index],
                                selected:
                                    controller.isSeletedFilter.value == index,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.news.length > 3
                            ? 3
                            : controller.news.length,
                        itemBuilder: (context, index) {
                          if (controller.news.length < 3 &&
                              controller.isNewsLoading.value) {
                            return const NewsShimmerBox();
                          } else {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: MainNewsTile(
                                title: controller.news[index]['title'],
                                time: controller.news[index]['date'],
                                aiScore: controller.news[index]['aiScore'],
                                img: controller.news[index]['thumbnail'],
                                route: AppRoutes.newsDetail,
                                news: controller.news[index],
                                uploadtime: controller.news[index]['pubDate'],
                                url: controller.news[index]['url'],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
