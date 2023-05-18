import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:jangjeon/service/cloud_translate.dart';
import 'package:xml/xml.dart';

class MainController extends GetxController {
  // PageController pageController = PageController();
  // RxInt selectedIndex = 0.obs;
  RxDouble investmentIndex = (65.0).obs;
  RxDouble negative = (0.3).obs;
  RxDouble positive = (0.45).obs;
  RxDouble neutrality = (0.25).obs;
  RxInt bottomNavIndex = 0.obs;
  RxList news = [].obs;
  RxInt isSeletedFilter = 0.obs;
  // handleNavigationOnTap(int index) {
  //   selectedIndex(index);
  //   pageController.jumpToPage(selectedIndex.value);
  // }
  var newsUrl =
      'https://feeds.finance.yahoo.com/rss/2.0/headline?s=appl,googl,msft&region=US&lang=en-US';

  newsCrawling() async {
    var response = await http.get(Uri.parse(newsUrl));
    if (response.statusCode == 200) {
      var document = XmlDocument.parse(response.body);
      var items = document.findAllElements('item');
      for (var item in items) {
        var title = item.findElements('title').single.text;
        var url = item.findElements('link').single.text;
        //var description = item.findElements('description').single.text;
        var date = item.findElements('pubDate').single.text;
        var pubDate =
            HttpDate.parse('${date.substring(0, date.indexOf('+'))}GMT');
        // UTC 시간을 한국 시간으로 변환
        DateTime dateTime = pubDate.add(const Duration(hours: 9));
        String kstDateString =
            DateFormat('yyyy.MM.dd HH:mm').format(dateTime); // 한국 시간을 문자열로 변환

        //기사 링크 들어가서 썸네일, 기사 내용 가져오기
        var res = await http.get(Uri.parse(url));
        if (res.statusCode == 200) {
          var docu = parse(res.body);
          //썸네일
          var thumbnail = docu
              .querySelector('meta[property="og:image"]')
              ?.attributes['content'];
          //가져올 수 있는 기사 내용
          var articleBody = docu.querySelector('div.caas-body');
          var paragraphs = articleBody?.querySelectorAll('p') ?? [];
          var articleContent = '';
          for (var p in paragraphs) {
            articleContent += p.text;
          }
          // 문자열을 UTF-8로 디코딩
          // List<int> bytes = utf8.encode(articleContent);
          // articleContent = utf8.decode(bytes);
          // articleContent = articleContent.replaceAll(RegExp(r"'[^']*'"), "'");
          // articleContent = articleContent.replaceAll(RegExp(r'"([^"]*)"'), '"');
          // articleContent = HtmlUnescape().convert(articleContent);

          //현재 시간과 비교하여 몇 시간 전에 올라왔는지
          var now = DateTime.now();
          var diff = now.difference(pubDate.add(const Duration(hours: 9)));
          String time;
          if (diff.inDays >= 1) {
            time = '${diff.inDays}일 전';
          } else if (diff.inHours >= 1) {
            time = '${diff.inHours}시간 전';
          } else if (diff.inMinutes >= 1) {
            time = '${diff.inMinutes}분 전';
          } else {
            time = '방금 전';
          }
          title = await CloudTranslate().getTranslation(title);
          news.add({
            'title': title,
            'url': url,
            'thumbnail': thumbnail,
            //'description': description,
            'article': articleContent,
            'pubDate': pubDate,
            'date': kstDateString,
            'time': time
          });
        } else {
          print('Failed to fetch page.');
        }
      }
    } else {
      print('Failed to fetch RSS feed.');
    }
  }

  filterNews(int index) {
    if (index == 0) {
      //최신순
      news.sort((a, b) => b['pubDate'].compareTo(a['pubDate']));
    } else if (index == 1) {
      //오래된 순
      news.sort((a, b) => a['pubDate'].compareTo(b['pubDate']));
    } else if (index == 2) {
      //투자지수 높은순
    } else if (index == 3) {
      //댓글 순
    }
    isSeletedFilter(index);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    news.clear();
    newsCrawling();
  }
}
