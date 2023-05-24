import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/model/stock.dart';
import 'package:jangjeon/service/cloud_natural_language.dart';
import 'package:jangjeon/service/db_service.dart';
import 'package:jangjeon/service/my_stock.dart';
import 'package:jangjeon/service/news_crawling.dart';

class MainController extends GetxController {
  // PageController pageController = PageController();
  // RxInt selectedIndex = 0.obs;
  RxDouble investmentIndex = (-1.0).obs;
  RxInt bottomNavIndex = 2.obs;
  RxList news = [].obs;
  RxInt isSeletedFilter = 10.obs;
  RxMap hotIssueNews = {}.obs;
  RxString currentStock = ''.obs;
  RxList<Stock> stockList = <Stock>[].obs;
  RxList myStockList = [].obs;
  // handleNavigationOnTap(int index) {
  //   selectedIndex(index);
  //   pageController.jumpToPage(selectedIndex.value);
  // }
  getNews() {
    news.clear();
    NewsCrawling().newsCrawling(currentStock.value.toLowerCase(), news);
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

  todayStockNatural(String txt)  async{
    investmentIndex.value =
        await CloudNaturalLanguage().getPositiveNatural(txt);
  }

  getHotIssueNews() async {
    var data = await DBService().readHotIssueNews();
    hotIssueNews.value = data.first.data()['news'];
  }

  getStockList() async {
    stockList(await DBService().readStock());
  }

  getMyStock() async {
    myStockList(await MyStock().readMyStock());
  }

  @override
  void onInit()  {
    // TODO: implement onInit
    super.onInit();
    currentStock.value = MyStock().myStockList.first;
    getNews();
    todayStockNatural('오늘의 ${currentStock.value} 투자 지수');
    getHotIssueNews();
    //getStockList();
    getMyStock();
  }
}
