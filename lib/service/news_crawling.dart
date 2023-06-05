import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:intl/intl.dart';
import 'package:jangjeon/service/cloud_api.dart';
import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;

class NewsCrawling {
  newsCrawling(String stock, RxList list) async {
    list.clear();
    var newsUrl =
        'https://feeds.finance.yahoo.com/rss/2.0/headline?s=$stock&region=US&lang=en-US';
    var response = await http.get(Uri.parse(newsUrl));
    if (response.statusCode == 200) {
      var document = XmlDocument.parse(response.body);
      var items = document.findAllElements('item');
      for (var item in items) {
        var title = item.findElements('title').single.text;
        var url = item.findElements('link').single.text;
        var date = item.findElements('pubDate').single.text;
        var pubDate = HttpDate.parse(
            '${date.substring(0, date.indexOf('+'))}GMT'); //문자열 시간 데이트 타입으로 형변환
        DateTime dateTime =
            pubDate.add(const Duration(hours: 9)); // UTC 시간을 한국 시간으로 변환
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
            articleContent += '${p.text}\n';
          }
          var aiScore = await CloudAPI().getNatural(title) * 100;
          title = await CloudAPI().getTranslation(title);
          list.add({
            'title': HtmlUnescape().convert(title),
            'url': url,
            'aiScore': aiScore.toInt(),
            'thumbnail': thumbnail,
            'stock': stock,
            'article': articleContent,
            'pubDate': Timestamp.fromDate(pubDate),
            'date': kstDateString,
          });
        } else {
          log('Failed to fetch page.');
        }
      }
    } else {
      log('Failed to fetch RSS feed.');
    }
  }
}
