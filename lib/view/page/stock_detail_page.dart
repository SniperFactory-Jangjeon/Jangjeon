import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/stock_detail_controller.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/util/app_text_style.dart';
import 'package:jangjeon/view/widget/ai_chart_bar.dart';
import 'package:jangjeon/view/widget/comment_tile.dart';
import 'package:jangjeon/view/widget/news_tile.dart';
import 'package:jangjeon/view/widget/stock_bar_chart.dart';
import 'package:jangjeon/view/widget/stock_line_chart.dart';

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
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '테슬라',
                              style: AppTextStyle.b2M18(),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '1,341,400원',
                              style: AppTextStyle.h3B24(),
                            ),
                            const SizedBox(height: 3),
                            Text('+0.58(0.2%)',
                                style:
                                    AppTextStyle.b5M12(color: AppColor.red100))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: AppColor.red100,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: const Icon(
                                    Icons.attach_money_outlined,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: AppColor.grayscale10,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Text(
                                      '원',
                                      style: AppTextStyle.b3B16(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '환율 1319.5원',
                              style: AppTextStyle.b4M14(),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '8/25 오전 8:40 기준',
                              style: AppTextStyle.b5R12(),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Obx(() => StockLineChart(
                            chartData: controller.chartData,
                            bestX: controller.chartData[1].x,
                            bestY: controller.chartData[1].y,
                            lowsetX: controller.chartData[6].x,
                            lowsetY: controller.chartData[6].y,
                          )),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Get.width * 0.6,
                          height: 30,
                          decoration: BoxDecoration(
                              color: AppColor.grayscale10,
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: Get.width * 0.1,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: controller.selectedTime.value == '1일'
                                        ? Colors.white
                                        : AppColor.grayscale10,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Center(
                                  child: Text(
                                    '1일',
                                    style: AppTextStyle.b4M14(),
                                  ),
                                ),
                              ),
                              Container(
                                width: Get.width * 0.1,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: controller.selectedTime.value == '1주'
                                        ? Colors.white
                                        : AppColor.grayscale10,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Center(
                                  child: Text(
                                    '1주',
                                    style: AppTextStyle.b4M14(),
                                  ),
                                ),
                              ),
                              Container(
                                width: Get.width * 0.1,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: controller.selectedTime.value == '3달'
                                        ? Colors.white
                                        : AppColor.grayscale10,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Center(
                                  child: Text(
                                    '3달',
                                    style: AppTextStyle.b4M14(),
                                  ),
                                ),
                              ),
                              Container(
                                width: Get.width * 0.1,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: controller.selectedTime.value == '1년'
                                        ? Colors.white
                                        : AppColor.grayscale10,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Center(
                                  child: Text(
                                    '1년',
                                    style: AppTextStyle.b4M14(),
                                  ),
                                ),
                              ),
                              Container(
                                width: Get.width * 0.1,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: controller.selectedTime.value == '5년'
                                        ? Colors.white
                                        : AppColor.grayscale10,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Center(
                                  child: Text(
                                    '5년',
                                    style: AppTextStyle.b4M14(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: Get.width * 0.12,
                          height: 30,
                          decoration: BoxDecoration(
                              color: AppColor.red100,
                              borderRadius: BorderRadius.circular(30)),
                          child: const Center(
                            child: FaIcon(
                              FontAwesomeIcons.chartSimple,
                              size: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          width: Get.width * 0.12,
                          height: 30,
                          decoration: BoxDecoration(
                              color: AppColor.grayscale10,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: Text(
                              '호가',
                              style: AppTextStyle.b4M14(),
                            ),
                          ),
                        )
                      ],
                    )
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
                    AIChartBar(
                        negative: 0.3,
                        neutrality: 0.2,
                        positive: 0.5,
                        investmentIndex: 60),
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
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: InkWell(
                          onTap: () {},
                          child: NewsTile(
                              title: '테슬라 액면 분할, 삼백슬라되나',
                              time: 1,
                              aiScore: 50,
                              img: 'https://picsum.photos/100/200'),
                        ),
                      ),
                      separatorBuilder: (context, index) => const Divider(
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1),
              Center(
                child: TextButton(
                  onPressed: () {},
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
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: InkWell(
                          onTap: () {},
                          child: CommentTile(
                            nickname: '개굴개구리',
                            profileImg: '',
                            content: '친슬라 가게 해줘이',
                            like: 5,
                            comment: 1,
                            time: '20분전',
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => const Divider(
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1),
              Center(
                child: TextButton(
                  onPressed: () {},
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
                        child: StockBarChart()),
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
                      child: Text(
                          '''테슬라는 미국 캘리포니아 팰로앨토에 기반을 둔 전기자동차 회사이다. 2003년, 마틴 에버하드와 마크 타페닝이 창업했다.
2004년 페이팔의 창업자이던 일론 머스크가 투자자로 참여했고 몇 년 후에 일론 머스크가 최대주주로 회장이 되었다.''',
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text('전기차',
                                  style: AppTextStyle.b3M16(
                                      color: AppColor.red100)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text('주요 제품', style: AppTextStyle.h4B20()),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Column(children: [
                            SizedBox(
                                width: 100,
                                height: 100,
                                child: Image.network(
                                  'https://picsum.photos/50/20',
                                  fit: BoxFit.cover,
                                )),
                            const SizedBox(height: 10),
                            Text(
                              '모델 $index',
                              style: AppTextStyle.b5R12(),
                            )
                          ]),
                        ),
                      ),
                    )
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
