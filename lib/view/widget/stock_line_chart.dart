import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/util/app_text_style.dart';

class StockLineChart extends StatelessWidget {
  const StockLineChart(
      {super.key,
      required this.chartData,
      required this.bestX,
      required this.bestY,
      required this.lowsetX,
      required this.lowsetY});
  final List<FlSpot> chartData;
  final double bestX;
  final double bestY;
  final double lowsetX;
  final double lowsetY;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: 200,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: chartData,
              barWidth: 0.8,
              color: AppColor.grayscale100,
              dotData: FlDotData(
                show: false,
              ),
            ),
          ],
          minY: lowsetY, //시작 y값 (최저)
          borderData: FlBorderData(
            show: false,
          ),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  if (value == lowsetX) {
                    // 최저 그래프 x값
                    return Row(
                      children: [
                        Text(
                          "최저",
                          style: AppTextStyle.b5M10(
                            color: Colors.blue,
                          ),
                        ),
                        const Icon(
                          Icons.attach_money_outlined,
                          color: Colors.blue,
                          size: 12,
                        ),
                        Text(
                          lowsetY.toString(), // 최저 그래프 y값
                          style: AppTextStyle.b5M10(
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    if (value == bestX) {
                      // 최고 그래프 x 값
                      return Row(
                        children: [
                          Text(
                            "최고",
                            style: AppTextStyle.b5M10(color: AppColor.red100),
                          ),
                          const Icon(
                            Icons.attach_money_outlined,
                            color: AppColor.red100,
                            size: 12,
                          ),
                          Text(
                            bestY.toString(), // 최고 그래프 y값
                            style: AppTextStyle.b5M10(color: AppColor.red100),
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  }),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 1,
            checkToShowHorizontalLine: (double value) {
              return value == (lowsetY + 0.9).toInt(); //최저 y값에 올림
            },
          ),
        ),
      ),
    );
  }
}
