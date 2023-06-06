import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jangjeon/controller/stock_detail_controller.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/util/app_routes.dart';
import 'package:jangjeon/util/app_text_style.dart';
import 'package:jangjeon/view/widget/ai_chart_bar.dart';
import 'package:jangjeon/view/widget/comment_tile.dart';
import 'package:jangjeon/view/widget/news_shimmer_box.dart';
import 'package:jangjeon/view/widget/news_tile.dart';
import 'package:jangjeon/view/widget/stock_bar_chart.dart';
import 'package:jangjeon/view/widget/stock_line_chart.dart';
import 'package:jangjeon/view/widget/stock_time_tile.dart';
import '../../controller/main_controller.dart';

class StockDetailPage extends GetView<StockDetailController> {
  const StockDetailPage({super.key});
  static const route = '/stockDetail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.find<MainController>().bottomNavIndex(2);
            },
            icon: const Icon(Icons.navigate_before)),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.search),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          if (!controller.isLoading.value) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  //파트 1
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.ticker,
                                    style: AppTextStyle.b2M18(),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    controller.isDollarChecked.value
                                        ? '\$ ${controller.cost[0]}'
                                        : '${NumberFormat('###,###,###,###').format(double.parse(controller.cost[0]) * controller.exchange!.exchange)} 원',
                                    style: AppTextStyle.h3B24(),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                      controller.isDollarChecked.value
                                          ? '${controller.cost[1]} ${controller.cost[2]}'
                                          : '${NumberFormat('###,###,###,###').format(double.parse(controller.cost[1]) * controller.exchange!.exchange)} ${controller.cost[2]}',
                                      style: AppTextStyle.b5M12(
                                          color: AppColor.red100))
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Obx(
                                  () => Row(
                                    children: [
                                      InkWell(
                                        onTap: () =>
                                            controller.isDollarChecked(true),
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: controller
                                                      .isDollarChecked.value
                                                  ? AppColor.red100
                                                  : AppColor.grayscale10,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Icon(
                                            Icons.attach_money_outlined,
                                            color:
                                                controller.isDollarChecked.value
                                                    ? AppColor.grayscale0
                                                    : Colors.black,
                                            size: 22,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      InkWell(
                                        onTap: () =>
                                            controller.isDollarChecked(false),
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: !controller
                                                      .isDollarChecked.value
                                                  ? AppColor.red100
                                                  : AppColor.grayscale10,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Center(
                                            child: Text(
                                              '원',
                                              style: AppTextStyle.b3B16(
                                                color: !controller
                                                        .isDollarChecked.value
                                                    ? AppColor.grayscale0
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  '환율 ${controller.exchange!.exchange}원',
                                  style: AppTextStyle.b4M14(),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  '${controller.exchange!.date} ${controller.exchange!.time} 기준',
                                  style: AppTextStyle.b5R12(),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Obx(() {
                              if (controller.isChartLoading.value) {
                                return const Center(
                                    child: CircularProgressIndicator(
                                  color: AppColor.red100,
                                ));
                              } else {
                                if (controller.chartData.isNotEmpty) {
                                  return StockLineChart(
                                    chartData: controller.chartData,
                                    bestX: controller.maxStock.x,
                                    bestY: controller.maxStock.y,
                                    lowsetX: controller.minStock.x,
                                    lowsetY: controller.minStock.y,
                                  );
                                } else {
                                  return Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Center(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle.b3R16(),
                                        '해당 기간의 주가 데이터가 없습니다. \n다른 기간을 선택해 주세요',
                                      ),
                                    ),
                                  );
                                }
                              }
                            })),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: Get.width * 0.6,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: AppColor.grayscale10,
                                  borderRadius: BorderRadius.circular(30)),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.time.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 3.5, vertical: 3),
                                  child: Obx(
                                    () => GestureDetector(
                                      onTap: () =>
                                          controller.handleChangePeriod(index),
                                      child: StockTimeTile(
                                          selectedTime:
                                              controller.selectedTime.value,
                                          time: controller.time[index]),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Container(
                            //   width: Get.width * 0.12,
                            //   height: 30,
                            //   decoration: BoxDecoration(
                            //       color: AppColor.red100,
                            //       borderRadius: BorderRadius.circular(30)),
                            //   child: const Center(
                            //     child: FaIcon(
                            //       FontAwesomeIcons.chartSimple,
                            //       size: 15,
                            //       color: Colors.white,
                            //     ),
                            //   ),
                            // ),
                            // Container(
                            //   width: Get.width * 0.12,
                            //   height: 30,
                            //   decoration: BoxDecoration(
                            //       color: AppColor.grayscale10,
                            //       borderRadius: BorderRadius.circular(30)),
                            //   child: Center(
                            //     child: Text(
                            //       '호가',
                            //       style: AppTextStyle.b4M14(),
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(thickness: 10),
                  //파트 2
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AI가 분석한 오늘의 투자 지수',
                          style: AppTextStyle.h4B20(),
                        ),
                        AIChartBar(investmentIndex: controller.investmentNum),
                      ],
                    ),
                  ),
                  const Divider(thickness: 10),
                  //파트 3
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '관련 뉴스',
                          style: AppTextStyle.h4B20(),
                        ),
                        const SizedBox(height: 8),
                        Obx(
                          () => ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.relevantNews.length > 3
                                ? 3
                                : controller.relevantNews.length,
                            itemBuilder: (context, index) {
                              if (controller.isNewsLoading.value &&
                                  controller.relevantNews.length < 3) {
                                return const NewsShimmerBox();
                              } else {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: NewsTile(
                                      title:
                                          controller.relevantNews[index].title,
                                      time: controller.relevantNews[index].date,
                                      aiScore: controller
                                          .relevantNews[index].aiScore,
                                      img: controller
                                          .relevantNews[index].thumbnail,
                                      news: controller.relevantNews[index],
                                      route: AppRoutes.newsDetail,
                                      uploadtime: controller
                                          .relevantNews[index].pubDate,
                                      url: controller.relevantNews[index].url,
                                      isOffAndTo: false),
                                );
                              }
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(thickness: 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(thickness: 1),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.allNews,
                            arguments: controller.relevantNews);
                      },
                      child: Text(
                        '더보기',
                        style: AppTextStyle.b3R16(),
                      ),
                    ),
                  ),
                  const Divider(thickness: 10),
                  //파트 4
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '댓글',
                          style: AppTextStyle.h4B20(),
                        ),
                        const SizedBox(height: 8),
                        Obx(
                          () => ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.comments.length < 3
                                ? controller.comments.length
                                : 3,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Obx(
                                () => CommentTile(
                                    onTap: () => controller.increseCommentLikes(
                                        controller.comments[index]),
                                    nickname: controller
                                        .comments[index].userInfo.name,
                                    profileImg: controller.comments[index]
                                            .userInfo.photoUrl ??
                                        '',
                                    content: controller.comments[index].comment,
                                    like:
                                        controller.comments[index].likes.value,
                                    comment: 1,
                                    time: DateFormat('yyyy/MM/dd hh시 mm분')
                                        .format(controller
                                            .comments[index].createdAt)),
                              ),
                            ),
                            separatorBuilder: (context, index) => const Divider(
                              thickness: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(thickness: 1),
                  Center(
                    child: TextButton(
                      onPressed: () async {
                        controller.comments.clear();
                        controller.comments.addAll(await Get.toNamed(
                            AppRoutes.comments,
                            arguments: {'ticker': controller.ticker}));
                      },
                      child: Text(
                        '더보기',
                        style: AppTextStyle.b3R16(),
                      ),
                    ),
                  ),
                  const Divider(thickness: 10),
                  //파트 5
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('실적', style: AppTextStyle.h4B20()),
                            const SizedBox(width: 20),
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColor.grey,
                                  borderRadius: BorderRadius.circular(13.5)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Row(
                                  children: [
                                    const Icon(Icons.circle,
                                        size: 8, color: Colors.green),
                                    Text(' 매출', style: AppTextStyle.b5M12()),
                                    const SizedBox(width: 5),
                                    const Icon(Icons.circle,
                                        size: 8, color: Colors.blue),
                                    Text(' 이익', style: AppTextStyle.b5M12()),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        //바 그래프
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 10, right: 10),
                            child: StockBarChart(
                              revenus: controller.revenus,
                              earnings: controller.earnings,
                            )),
                      ],
                    ),
                  ),
                  const Divider(thickness: 10),
                  //파트 6
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('기업 정보', style: AppTextStyle.h4B20()),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(controller.companyInfo,
                              style: AppTextStyle.b3R16()),
                        ),
                        Text('주요 사업', style: AppTextStyle.h4B20()),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Wrap(
                            spacing: 3,
                            children: [
                              Chip(
                                backgroundColor: AppColor.red10,
                                shape: const StadiumBorder(
                                  side: BorderSide(
                                    color: AppColor.red100,
                                    width: 1.0,
                                  ),
                                ),
                                label: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Text(controller.industry,
                                      style: AppTextStyle.b3M16(
                                          color: AppColor.red100)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text('주요 제품', style: AppTextStyle.h4B20()),
                        const SizedBox(height: 20),
                        Text(
                          style: AppTextStyle.b3R16(),
                          '준비 중입니다...',
                        ),
                        // SizedBox(
                        //   height: 150,
                        //   child: ListView.builder(
                        //     physics: const BouncingScrollPhysics(),
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount: 6,
                        //     itemBuilder: (context, index) => Padding(
                        //       padding: const EdgeInsets.only(right: 8.0),
                        //       child: Column(children: [
                        //         SizedBox(
                        //             width: 100,
                        //             height: 100,
                        //             child: Image.network(
                        //               'https://picsum.photos/50/20',
                        //               fit: BoxFit.cover,
                        //             )),
                        //         const SizedBox(height: 10),
                        //         Text(
                        //           '모델 $index',
                        //           style: AppTextStyle.b5R12(),
                        //         )
                        //       ]),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColor.red100,
            ));
          }
        }),
      ),
    );
  }
}
