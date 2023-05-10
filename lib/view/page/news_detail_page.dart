import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/news_detail_controller.dart';
import 'package:jangjeon/util/app_text_style.dart';
import 'package:jangjeon/view/widget/ai_chart_bar.dart';
import 'package:jangjeon/view/widget/comment_tile.dart';
import 'package:jangjeon/view/widget/news_tile.dart';

class NewsDetailPage extends GetView<NewsDetailController> {
  const NewsDetailPage({super.key});
  static const route = '/newsDetail';

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
              //파트 2
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Divider(thickness: 10),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '다른 뉴스',
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
