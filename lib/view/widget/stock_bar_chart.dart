import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/util/app_text_style.dart';

class StockBarChart extends StatelessWidget {
  StockBarChart({super.key, required this.revenus, required this.earnings});

  final List<double> revenus;
  final List<double> earnings;

  double overallMax = 0;
  double overallMin = 0;

  getMaxY() {
    double max1 =
        revenus.reduce((value, element) => value > element ? value : element);
    double max2 =
        earnings.reduce((value, element) => value > element ? value : element);

    overallMax = max1 > max2 ? max1 : max2;
  }

  getMinY() {
    double min1 =
        revenus.reduce((value, element) => value < element ? value : element);
    double min2 =
        earnings.reduce((value, element) => value < element ? value : element);

    overallMin = min1 < min2 ? min1 : min2;
  }

  @override
  Widget build(BuildContext context) {
    getMaxY();
    getMinY();
    return SizedBox(
      width: Get.width,
      height: 200,
      child: BarChart(
        BarChartData(
          maxY: overallMax,
          minY: overallMin < 0 ? overallMin : 0,
          barGroups: [
            BarChartGroupData(
              barsSpace: 4,
              x: 0,
              barRods: [
                BarChartRodData(
                  borderRadius: BorderRadius.circular(3),
                  toY: revenus[0],
                  color: Colors.green,
                  width: 15,
                ),
                BarChartRodData(
                  borderRadius: BorderRadius.circular(3),
                  toY: earnings[0],
                  color: Colors.blue,
                  width: 15,
                ),
              ],
            ),
            BarChartGroupData(
              barsSpace: 4,
              x: 1,
              barRods: [
                BarChartRodData(
                  borderRadius: BorderRadius.circular(3),
                  toY: revenus[1],
                  color: Colors.green,
                  width: 15,
                ),
                BarChartRodData(
                  borderRadius: BorderRadius.circular(3),
                  toY: earnings[1],
                  color: Colors.blue,
                  width: 15,
                ),
              ],
            ),
            BarChartGroupData(
              barsSpace: 4,
              x: 2,
              barRods: [
                BarChartRodData(
                  borderRadius: BorderRadius.circular(3),
                  toY: revenus[2],
                  color: Colors.green,
                  width: 15,
                ),
                BarChartRodData(
                  borderRadius: BorderRadius.circular(3),
                  toY: earnings[2],
                  color: Colors.blue,
                  width: 15,
                ),
              ],
            ),
            BarChartGroupData(
              barsSpace: 4,
              x: 3,
              barRods: [
                BarChartRodData(
                  borderRadius: BorderRadius.circular(3),
                  toY: revenus[3],
                  color: Colors.green,
                  width: 15,
                ),
                BarChartRodData(
                  borderRadius: BorderRadius.circular(3),
                  toY: earnings[3],
                  color: Colors.blue,
                  width: 15,
                ),
              ],
            )
          ],
          titlesData: FlTitlesData(
            show: true,
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  String text = '';
                  if (value == overallMax) {
                    text = '${overallMax}M';
                  } else if (value == (overallMax * 0.75).round()) {
                    text = '${(overallMax * 0.75).round()}M';
                  } else if (value == (overallMax * 0.5).round()) {
                    text = '${(overallMax * 0.5).round()}M';
                  } else if (value == (overallMax * 0.25).round()) {
                    text = '${(overallMax * 0.25).round()}M';
                  } else if (overallMin < 0 && value == overallMin) {
                    text = '${overallMin}M';
                  } else if (overallMin < 0 &&
                      value == (overallMin * 0.75).round() &&
                      value != 0) {
                    text = '${(overallMin * 0.75).round()}M';
                  } else if (overallMin < 0 &&
                      value == (overallMin * 0.5).round() &&
                      value != 0) {
                    text = '${(overallMin * 0.5).round()}M';
                  } else if (overallMin < 0 &&
                      value == (overallMin * 0.25).round() &&
                      value != 0) {
                    text = '${(overallMin * 0.25).round()}M';
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SideTitleWidget(
                      axisSide: meta.axisSide,
                      space: 0,
                      child: Text(
                        text,
                        style: AppTextStyle.b5R10(color: AppColor.grayscale60),
                      ),
                    ),
                  );
                },
                interval: 1,
                reservedSize: 50,
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) => SideTitleWidget(
                  axisSide: AxisSide.bottom,
                  space: 5, //margin top
                  child: Text(
                    ['2019', '2020', '2021', '2022'][value.toInt()],
                    style: AppTextStyle.b4M14(),
                  ),
                ),
                reservedSize: 42,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 1,
            getDrawingHorizontalLine: (value) => FlLine(
              color: AppColor.grayscale10,
              strokeWidth: 0.8,
            ),
            checkToShowHorizontalLine: (double value) {
              return value % 50 == 0; //최저 y값에 올림
            },
          ),
        ),
      ),
    );
  }
}
