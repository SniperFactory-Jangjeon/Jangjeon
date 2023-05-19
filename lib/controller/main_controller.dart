import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/service/news_crawling.dart';

class MainController extends GetxController {
  // PageController pageController = PageController();
  // RxInt selectedIndex = 0.obs;
  RxDouble investmentIndex = (65.0).obs;
  RxDouble negative = (0.3).obs;
  RxDouble positive = (0.45).obs;
  RxDouble neutrality = (0.25).obs;
  RxInt bottomNavIndex = 0.obs;
  RxList news = [].obs;
  RxInt isSeletedFilter = 0.obs;
  // handleNavigationOnTap(int index) {
  //   selectedIndex(index);
  //   pageController.jumpToPage(selectedIndex.value);
  // }

  var stockList = ['appl', 'googl', 'msft'];

  getNews() async {
    for (var i = 0; i < stockList.length; i++) {
      NewsCrawling().newsCrawling(stockList[i], news);
    }
    news.toSet().toList();
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
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    news.clear();
    getNews();
  }
}
