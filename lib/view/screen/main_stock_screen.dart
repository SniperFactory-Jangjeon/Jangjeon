import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/main_controller.dart';
import 'package:jangjeon/util/app_filter.dart';
import 'package:jangjeon/util/app_routes.dart';
import 'package:jangjeon/util/app_text_style.dart';
import 'package:jangjeon/view/widget/ai_chart_bar.dart';
import 'package:jangjeon/view/widget/ai_chart_pie.dart';
import 'package:jangjeon/view/widget/filter_tile.dart';
import 'package:jangjeon/view/widget/main_news_tile.dart';

class MainStockScreen extends GetView<MainController> {
  const MainStockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
            child: Text('실시간 핫이슈', style: AppTextStyle.h4B20()),
          ),
          Stack(
            children: [
              Container(
                width: Get.width,
                height: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage('https://picsum.photos/500/200'),
                        colorFilter: const ColorFilter.mode(
                            Colors.black45, BlendMode.darken),
                        fit: BoxFit.cover)),
              ),
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
                            'Tesla주식이 오늘 브레이크를 밟은 이유',
                            style: AppTextStyle.b3B16(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                            onTap: () {
                              //Get.toNamed(AppRoutes.newsDetail);
                            },
                            child: Text('기사보기 >',
                                style: AppTextStyle.b5R12(color: Colors.white)))
                      ],
                    ),
                  ))
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('관심 주식', style: AppTextStyle.h4B20()),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) => Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                      AppRoutes.stockDetail); //추후 arguments 추가
                                },
                                child: CircleAvatar(radius: 22)),
                            const SizedBox(height: 5),
                            Text('테슬라$index', style: AppTextStyle.b4M14())
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Text('AI가 분석한 오늘의 투자 지수', style: AppTextStyle.h4B20()),
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
            padding: const EdgeInsets.only(top: 10, bottom: 20.0),
            child: Obx(() => AIChartBar(
                  negative: controller.negative.value,
                  neutrality: controller.neutrality.value,
                  positive: controller.positive.value,
                  investmentIndex: controller.investmentIndex.value,
                )),
          ),
          const Divider(thickness: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Get.width * 0.8,
                      height: 70,
                      child: ListView.builder(
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
                    GestureDetector(
                        onTap: () {},
                        child: const FaIcon(FontAwesomeIcons.sliders))
                  ],
                ),
                Obx(
                  () => ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        controller.news.length > 5 ? 5 : controller.news.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.newsDetail,
                              arguments: controller.news[index]);
                        },
                        child: MainNewsTile(
                            title: controller.news[index]['title'],
                            time: controller.news[index]['date'],
                            aiScore: 50,
                            img: controller.news[index]['thumbnail']),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
