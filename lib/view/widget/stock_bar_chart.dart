import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/util/app_text_style.dart';

class StockBarChart extends StatelessWidget {
  const StockBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: 200,
      child: BarChart(
        BarChartData(
          maxY: 350,
          minY: 0,
          barGroups: [
            BarChartGroupData(
              barsSpace: 4,
              x: 0,
              barRods: [
                BarChartRodData(
                  borderRadius: BorderRadius.circular(3),
                  toY: 100,
                  color: Colors.green,
                  width: 15,
                ),
                BarChartRodData(
                  borderRadius: BorderRadius.circular(3),
                  toY: 10,
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
                  toY: 150,
                  color: Colors.green,
                  width: 15,
                ),
                BarChartRodData(
                  borderRadius: BorderRadius.circular(3),
                  toY: 50,
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
                  toY: 190,
                  color: Colors.green,
                  width: 15,
                ),
                BarChartRodData(
                  borderRadius: BorderRadius.circular(3),
                  toY: 80,
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
                  toY: 220,
                  color: Colors.green,
                  width: 15,
                ),
                BarChartRodData(
                  borderRadius: BorderRadius.circular(3),
                  toY: 40,
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
                  if (value == 0) {
                    text = '0';
                  } else if (value == 50) {
                    text = '50억';
                  } else if (value == 100) {
                    text = '100억';
                  } else if (value == 150) {
                    text = '150억';
                  } else if (value == 200) {
                    text = '200억';
                  } else if (value == 250) {
                    text = '250억';
                  } else if (value == 300) {
                    text = '300억';
                  } else if (value == 350) {
                    text = '350억';
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SideTitleWidget(
                      axisSide: meta.axisSide,
                      space: 0,
                      child: Text(
                        text,
                        style: AppTextStyle.b5R12(color: AppColor.grayscale60),
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
