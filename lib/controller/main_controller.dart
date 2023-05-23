import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/service/cloud_natural_language.dart';
import 'package:jangjeon/service/news_crawling.dart';

class MainController extends GetxController {
  // PageController pageController = PageController();
  // RxInt selectedIndex = 0.obs;
  RxDouble investmentIndex = (0.0).obs;
  RxInt bottomNavIndex = 0.obs;
  RxList news = [].obs;
  RxInt isSeletedFilter = 10.obs;
  // handleNavigationOnTap(int index) {
  //   selectedIndex(index);
  //   pageController.jumpToPage(selectedIndex.value);
  // }

  var stockList = ['appl', 'googl', 'msft', 'tsla'];

  getNews() async {
    for (var i = 0; i < stockList.length; i++) {
      NewsCrawling().newsCrawling(stockList[i], news);
    }
  }

  filterNews(int index) {
    if (index == 0) {
      //최신순
      news.sort((a, b) => b['pubDate'].compareTo(a['pubDate']));
    } else if (index == 1) {
      //오래된 순
      news.sort((a, b) => a['pubDate'].compareTo(b['pubDate']));
    } else if (index == 2) {
      //투자지수 높은순
    } else if (index == 3) {
      //댓글 순
    }
    isSeletedFilter(index);
  }

  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    news.clear();
    getNews();
    investmentIndex.value = await CloudNaturalLanguage().getPositiveNatural('오늘의 투자 지수');
  }
}
