import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:jangjeon/model/comment.dart';
import 'package:jangjeon/service/cloud_translate.dart';
import 'package:jangjeon/service/db_service.dart';
import 'package:jangjeon/service/news_crawling.dart';
import 'package:yahoofin/yahoofin.dart';

class StockDetailController extends GetxController {
  var ticker = 'ARMP';
  List<FlSpot> chartData = [];

  RxString selectedTime = '1일'.obs;
  RxList time = ['1일', '1주', '3달', '1년', '5년'].obs;

  FlSpot maxStock = const FlSpot(0, 0);
  FlSpot minStock = const FlSpot(0, 0);

  RxBool isLoading = false.obs;
  RxBool isChartLoading = false.obs;

  List cost = [];
  String companyInfo = '';
  String industry = '';
  List revenus = [];
  List earnings = [];

  List<Comment> comments = [];
  RxList relevantNews = [].obs;

  //주가 차트 기간 선택
  handleChangePeriod(index) {
    selectedTime.value = time[index];
    StockRange period = StockRange.oneDay;
    if (index == 0) {
      period = StockRange.oneDay;
    } else if (index == 1) {
      period = StockRange.fiveDay;
    } else if (index == 2) {
      period = StockRange.threeMonth;
    } else if (index == 3) {
      period = StockRange.oneYear;
    } else if (index == 4) {
      period = StockRange.fiveYear;
    }
    readStockData(period);
  }

  //현재 가격과 인상률 가져오기
  getCost() async {
    final url = 'https://finance.yahoo.com/quote/$ticker'; // 야후 파이낸스 URL

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final document = parser.parse(response.body);

      final elements =
          document.querySelectorAll('#Lead-5-QuoteHeader-Proxy fin-streamer');

      cost.addAll([elements[0].text, elements[1].text, elements[2].text]);
    }
  }

  //주식 주가 데이터 가져오기
  readStockData(period) async {
    isChartLoading(true);
    chartData.clear();
    var yfin = YahooFin();
    StockHistory hist = yfin.initStockHistory(ticker: ticker);

    StockInterval interval = StockInterval.sixtyMinute; //
    if (period == StockRange.oneDay) {
      interval = StockInterval.sixtyMinute;
    } else if (period == StockRange.fiveDay) {
      interval = StockInterval.oneDay;
    } else if (period == StockRange.threeMonth) {
      interval = StockInterval.oneWeek;
    } else if (period == StockRange.oneYear) {
      interval = StockInterval.oneMonth;
    } else if (period == StockRange.fiveYear) {
      interval = StockInterval.threeMonth;
    }

    StockChart chart = await yfin.getChartQuotes(
      stockHistory: hist,
      interval: interval,
      period: period,
    );

    if (chart.chartQuotes != null) {
      List<FlSpot> result = chart.chartQuotes!.close!
          .asMap()
          .entries
          .map((e) => FlSpot(
              e.key.toDouble(), double.parse(e.value.toStringAsFixed(2))))
          .toList();

      chartData.addAll(result);

      maxStock = result.reduce((curr, next) => curr.y > next.y ? curr : next);
      minStock = result.reduce((curr, next) => curr.y < next.y ? curr : next);

      if (period == StockRange.threeMonth) {
        if (maxStock.x % 2 != 0) {
          maxStock = FlSpot(maxStock.x + 1, maxStock.y);
        }
        if (minStock.x % 2 != 0) {
          minStock = FlSpot(minStock.x + 1, minStock.y);
        }
      }

      if (period == StockRange.fiveYear) {
        if (maxStock.x % 5 != 0) {
          maxStock = FlSpot(maxStock.x - (maxStock.x % 5), maxStock.y);
        }
        if (minStock.x % 5 != 0) {
          minStock = FlSpot(minStock.x - (minStock.x % 5), minStock.y);
        }
      }
    }

    isChartLoading(false);
  }

  //기업 정보 가져오기
  getCompanyInfo() async {
    final response = await http
        .get(Uri.parse('https://finance.yahoo.com/quote/$ticker/profile'));
    if (response.statusCode == 200) {
      final document = parser.parse(response.body);
      final elements = document.querySelectorAll('#Col1-0-Profile-Proxy p');
      if (elements.isNotEmpty) {
        industry =
            await CloudTranslate().getTranslation(elements[1].children[4].text);
        companyInfo =
            await CloudTranslate().getTranslation(elements[2].text.trim());
      }
    } else {
      throw Exception('Failed to fetch data from Yahoo Finance');
    }
  }

  //기업 실적 가져오기
  getCompanyPerfomance() async {
    final url =
        'https://finance.yahoo.com/quote/$ticker/financials'; // 야후 파이낸스 URL

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final document = parser.parse(response.body);

      final elements = document.querySelectorAll(
          '#Col1-1-Financials-Proxy div[data-test="fin-col"] span');

      revenus.addAll([
        elements[4].text, //2019년도 매출
        elements[3].text, //2020년도 매출
        elements[2].text, //2021년도 매출
        elements[1].text //2022년도 매출
      ]);

      earnings.addAll([
        elements[46].text, //2019년도 이익
        elements[47].text, //2020년도 이익
        elements[48].text, //2021년도 이익
        elements[49].text //2022년도 이익
      ]);

      print(revenus);
      print(earnings);
    }
  }

  //댓글 읽어오기
  readComments() async {
    comments = await DBService().readComments(ticker);
  }

  //댓글 좋아요 수 증가
  increseCommentLikes(comment) {
    DBService().increseCommentLikes(ticker, comment.id);
    comment.likes += 1;
  }

  getRelevantNews(String stock) {
    NewsCrawling().newsCrawling(stock, relevantNews);
  }

  @override
  void onInit() async {
    super.onInit();
    isLoading(true);
    await getCost();
    await readStockData(StockRange.oneDay);
    await getCompanyInfo();
    await getCompanyPerfomance();
    await readComments();
    isLoading(false);
  }
}
