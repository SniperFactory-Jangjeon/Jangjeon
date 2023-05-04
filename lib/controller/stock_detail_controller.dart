import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class StockDetailController extends GetxController {
  RxList<FlSpot> chartData = [
    FlSpot(0, 500),
    FlSpot(1, 892.5),
    FlSpot(2, 792.5),
    FlSpot(3, 592.5),
    FlSpot(4, 622.5),
    FlSpot(5, 752.5),
    FlSpot(6, 226.65),
    FlSpot(7, 430),
    FlSpot(8, 450),
    FlSpot(9, 550),
    FlSpot(10, 655),
    FlSpot(11, 670)
  ].obs;
  RxString selectedTime = '1일'.obs;
}
