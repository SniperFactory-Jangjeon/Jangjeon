import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:jangjeon/service/news_crawling.dart';
import 'package:yahoofin/yahoofin.dart';

class StockDetailController extends GetxController {
  var ticker = 'ARMP';
  RxList<FlSpot> chartData = RxList<FlSpot>();

  RxString selectedTime = '1일'.obs;
  RxList time = ['1일', '1주', '3달', '1년', '5년'].obs;

  FlSpot maxStock = const FlSpot(0, 0);
  FlSpot minStock = const FlSpot(0, 0);

  RxBool isLoading = false.obs;

  RxString companyInfo = ''.obs;
  
  RxList relevantNews = [].obs;

  //주식 주가 데이터 가져오기
  readStockData(ticker) async {
    isLoading(true);
    var yfin = YahooFin();
    StockHistory hist = yfin.initStockHistory(ticker: ticker);
    StockChart chart = await yfin.getChartQuotes(
      stockHistory: hist,
      interval: StockInterval.oneDay,
      period: StockRange.fiveYear,
    );

    List<FlSpot> result = chart.chartQuotes!.close!
        .asMap()
        .entries
        .map((e) =>
            FlSpot(e.key.toDouble(), double.parse(e.value.toStringAsFixed(2))))
        .toList();

    chartData.addAll(result);

    maxStock = result.reduce((curr, next) => curr.y > next.y ? curr : next);
    minStock = result.reduce((curr, next) => curr.y < next.y ? curr : next);
    print(maxStock);
    isLoading(false);
  }

  //기업 정보 가져오기
  getCompanyInfo(ticker) async {
    final response = await http
        .get(Uri.parse('https://finance.yahoo.com/quote/$ticker/profile'));
    if (response.statusCode == 200) {
      final document = parser.parse(response.body);
      final elements = document.querySelectorAll('#Col1-0-Profile-Proxy p');
      if (elements.isNotEmpty) {
        companyInfo(elements[2].text.trim());
      }
    } else {
      throw Exception('Failed to fetch data from Yahoo Finance');
    }
  }

  getRelevantNews(String stock){
    NewsCrawling().newsCrawling(stock, relevantNews);
  }

  @override
  void onInit() async {
    super.onInit();
    await readStockData('TSLA');
    await getCompanyInfo('TSLA');
  }
}
