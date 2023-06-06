import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/service/db_service.dart';
import 'package:jangjeon/util/app_text_style.dart';
import 'package:jangjeon/view/widget/ai_score.dart';

class MainNewsTile extends StatelessWidget {
  const MainNewsTile(
      {super.key,
      required this.title,
      required this.time,
      required this.aiScore,
      required this.img,
      required this.route,
      required this.news,
      required this.url,
      required this.uploadtime});
  final String title;
  final String time;
  final int aiScore;
  final String img;
  final String route;
  final Map news;
  final String url;
  final Timestamp uploadtime;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(route, arguments: news);
        DBService().clickNews(url, news, uploadtime);
      },
      child: Container(
        width: Get.width,
        height: 140,
        decoration: BoxDecoration(
          border: Border.all(
            width: 0.5,
            color: Colors.grey,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Get.width * 0.5,
                  height: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyle.b3M16(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(time.toString(), style: AppTextStyle.b5R12()),
                    ],
                  ),
                ),
                AiScore(aiScore: aiScore)
              ],
            ),
          ),
          Container(
              width: Get.width * 0.3,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  image: DecorationImage(
                    image: NetworkImage(
                      img,
                    ),
                    fit: BoxFit.cover,
                  ))),
        ]),
      ),
    );
  }
}
