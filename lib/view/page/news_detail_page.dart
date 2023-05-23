import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jangjeon/controller/news_detail_controller.dart';
import 'package:jangjeon/util/app_routes.dart';
import 'package:jangjeon/util/app_text_style.dart';
import 'package:jangjeon/view/widget/ai_chart_bar.dart';
import 'package:jangjeon/view/widget/comment_tile.dart';
import 'package:jangjeon/view/widget/news_tile.dart';

class NewsDetailPage extends GetView<NewsDetailController> {
  const NewsDetailPage({super.key});
  static const route = '/newsDetail';

  @override
  Widget build(BuildContext context) {
    var news = Get.arguments;
    controller.summarizeText(news['article']);
    controller.getOtherNews(news['stock']);
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        SizedBox(
                          width: Get.width * 0.7,
                          child: Text(
                            news['title'],
                            style: AppTextStyle.h4B20(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: Colors.grey,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/svg/ai_positive.svg'),
                                  Text('+ 50', style: AppTextStyle.b4B14())
                                ],
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      news['date'],
                      style: AppTextStyle.b5R12(),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                        width: Get.width,
                        height: 180,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            news['thumbnail'] != ''
                                ? news['thumbnail']
                                : 'https://picsum.photos/200/200',
                            fit: BoxFit.cover,
                          ),
                        )),
                    const SizedBox(height: 10),
                    Obx(
                      () => Text(
                        controller.summarContent.value,
                        style:
                            AppTextStyle.b3R16(height: 1.5, wordSpacing: 1.4),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const Divider(thickness: 1),
              Center(
                child: TextButton(
                  onPressed: () async {
                    Get.toNamed(AppRoutes.news, arguments: news['url']);
                  },
                  child: Text(
                    '본문 뉴스 보러가기',
                    style: AppTextStyle.b3R16(),
                  ),
                ),
              ),
              const Divider(thickness: 10),
              Padding(
                padding: const EdgeInsets.all(20.0),
                //파트 2
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI가 분석한 키워드',
                      style: AppTextStyle.h4B20(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(thickness: 10),
              //파트 3
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
              //파트 4
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '관련 주식 댓글',
                      style: AppTextStyle.h4B20(),
                    ),
                    const SizedBox(height: 12),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: InkWell(
                          onTap: () {},
                          child: CommentTile(
                            onTap: () {},
                            nickname: '개굴개구리',
                            profileImg: '',
                            content: '친슬라 가게 해줘이',
                            like: 5,
                            comment: 1,
                            time: '20분전',
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          const Divider(thickness: 1),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '다른 뉴스',
                      style: AppTextStyle.h4B20(),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                      () => ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.otherNews.length > 4
                            ? 4
                            : controller.otherNews.length,
                        itemBuilder: (context, index) => index == 0
                            ? const SizedBox()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: InkWell(
                                  onTap: () {},
                                  child: NewsTile(
                                      title: controller.otherNews[index]
                                          ['title'],
                                      time: controller.otherNews[index]['date'],
                                      aiScore: 50,
                                      img: controller.otherNews[index]
                                          ['thumbnail']),
                                ),
                              ),
                        separatorBuilder: (context, index) => index == 0
                            ? const SizedBox()
                            : const Divider(thickness: 1),
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
            ],
          ),
        ),
      ),
    );
  }
}
