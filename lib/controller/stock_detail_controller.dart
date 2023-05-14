import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:yahoofin/yahoofin.dart';

class StockDetailController extends GetxController {
  RxList<FlSpot> chartData = RxList<FlSpot>();

  RxString selectedTime = '1일'.obs;
  RxList time = ['1일', '1주', '3달', '1년', '5년'].obs;

  FlSpot maxStock = const FlSpot(0, 0);
  FlSpot minStock = const FlSpot(0, 0);

  RxBool isLoading = false.obs;

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

  getStockData() async {
    final symbol = 'AAPL';
    final url = 'https://finance.yahoo.com/quote/$symbol/profile';

    http.get(Uri.parse(url)).then((response) {
      if (response.statusCode == 200) {
        final document = htmlParser.parse(response.body);
        final companyNameElement =
            document.querySelector('.Mt\\(0\\.5em\\) > h1');
        final companyDescriptionElement =
            document.querySelector('.description');

        if (companyNameElement != null && companyDescriptionElement != null) {
          final companyName = companyNameElement.text;
          final companyDescription = companyDescriptionElement.text;

          print('Company Name: $companyName');
          print('Company Description: $companyDescription');
        }
      }
    }).catchError((error) => print(error));
  }

  @override
  void onInit() async {
    super.onInit();
    await readStockData('TSLA');
    //await getStockData();
  }
}
