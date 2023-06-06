import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/util/app_text_style.dart';

class AIChartBar extends StatelessWidget {
  const AIChartBar({super.key, required this.investmentIndex});
  final double investmentIndex;
  @override
  Widget build(BuildContext context) {
    var width = Get.width * 0.82;
    return Column(
      children: [
        investmentIndex < 0
            ? const SizedBox()
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: investmentIndex == 0
                          ? 10
                          : width * investmentIndex * 0.01),
                  Column(
                    children: [
                      Text(
                        '+${investmentIndex.toInt().toString()}',
                        style: AppTextStyle.b5B12(),
                      ),
                      const SizedBox(height: 3),
                      const FaIcon(FontAwesomeIcons.locationDot,
                          color: AppColor.red100)
                    ],
                  ),
                ],
              ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: width * 0.4,
              height: 30,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    bottomLeft: Radius.circular(5.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 6),
                child: Text(
                  '부정',
                  style: AppTextStyle.b4M14(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Container(
              width: width * 0.2,
              height: 30,
              decoration: const BoxDecoration(color: Colors.yellow),
              child: Center(
                  child: Text(
                '중립',
                style: AppTextStyle.b4M14(),
                overflow: TextOverflow.ellipsis,
              )),
            ),
            Container(
              width: width * 0.4,
              height: 30,
              decoration: const BoxDecoration(
                color: AppColor.red100,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5.0),
                    bottomRight: Radius.circular(5.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      '긍정',
                      style: AppTextStyle.b4M14(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
