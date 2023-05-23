import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jangjeon/util/app_text_style.dart';
import 'package:jangjeon/view/widget/ai_score.dart';

class NewsTile extends StatelessWidget {
  const NewsTile(
      {super.key,
      required this.title,
      required this.time,
      required this.aiScore,
      required this.img});
  final String title;
  final String time;
  final int aiScore;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Get.width * 0.6,
            height: 95,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.b3M16(),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(time, style: AppTextStyle.b5R12()),
                    AiScore(aiScore: aiScore)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      Container(
          width: Get.width * 0.25,
          height: Get.width * 0.25,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                image: NetworkImage(
                  img,
                ),
                fit: BoxFit.cover,
              ))),
    ]);
  }
}
