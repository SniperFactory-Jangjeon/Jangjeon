import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:jangjeon/model/stock.dart';
import 'package:jangjeon/service/cloud_natural_language.dart';
import 'package:jangjeon/service/db_service.dart';
import 'package:jangjeon/service/news_crawling.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController extends GetxController {
  RxDouble investmentIndex = (-1.0).obs;
  RxInt bottomNavIndex = 2.obs;
  RxList news = [].obs;
  RxInt isSeletedFilter = 0.obs;
  RxMap hotIssueNews = {}.obs;
  RxString currentStock = ''.obs;
  RxList<Stock> stockList = <Stock>[].obs;
  RxList myStockList = [].obs;
  List<String> myStockSymbolList = [];
  SharedPreferences? prefs;
  List myStockInfo = [];

  bool readBookmark(String stock) {
    return myStockSymbolList.contains(stock);
  }

  //관심 주식 등록
  addMyStock(String stock) {
    if (myStockSymbolList.contains(stock)) {
      myStockSymbolList.remove(stock);
    } else {
      myStockSymbolList.add(stock);
    }
    if (prefs != null) {
      prefs!.setStringList('myStockSymbolList', myStockSymbolList);
    }
  }

  readMyStockInfo() async {
    myStockInfo.clear();
    for (var myStock in myStockSymbolList) {
      var stock = await FirebaseFirestore.instance
          .collection('stockList')
          .where('symbol', isEqualTo: myStock)
          .get();
      myStockInfo.add(stock.docs.first.data());
    }
    return myStockInfo;
  }

  getNews() {
    isSeletedFilter(10);
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
      news.sort((a, b) => b['aiScore'].compareTo(a['aiScore']));
    } else if (index == 3) {
      //댓글 순
      news.sort((a, b) => a['aiScore'].compareTo(b['aiScore']));
    }
    isSeletedFilter(index);
  }

  todayStockNatural(String txt) async {
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
    myStockList(await readMyStockInfo());
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      myStockSymbolList = prefs!.getStringList('myStockSymbolList') ?? ['TSLA'];
    }
    getMyStock();
    currentStock.value = myStockSymbolList.first;
    getNews();
    todayStockNatural('오늘의 ${currentStock.value} 투자 지수');
    getHotIssueNews();
  }
}
