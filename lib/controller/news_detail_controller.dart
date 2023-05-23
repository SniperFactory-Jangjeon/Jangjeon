import 'dart:convert';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:http/http.dart' as http;
import 'package:jangjeon/service/cloud_natural_language.dart';
import 'package:jangjeon/service/cloud_translate.dart';
import 'package:jangjeon/service/news_crawling.dart';

class NewsDetailController extends GetxController {
  String apiKey = 'f0dce2f983cc65a00b24617ac3b1aadd';
  String apiUrl = 'https://api.meaningcloud.com/summarization-1.0';
  RxDouble investmentIndex = (-1.0).obs;
  int sentences = 4;
  RxString summarContent = ''.obs;
  RxList otherNews = [].obs;
  var news = Get.arguments;
  RegExp regex = RegExp(r'[.!?]');
  summarizeText(String articleContent) async {
    if (regex.allMatches(articleContent).length > 4) {
      // API 요청 본문
      var requestBody = {
        'txt': articleContent,
        'sentences': sentences.toString(),
      };

      // API 요청 보내기
      var response = await http.post(
        Uri.parse('$apiUrl?key=$apiKey'),
        body: requestBody,
      );

      // 요청이 성공하면 응답에서 요약문 추출하기
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        summarContent.value =
            await CloudTranslate().getTranslation(data['summary']);
        summarContent.value = HtmlUnescape().convert(summarContent.value);
      }
      // 요청이 실패하면 오류 메시지 반환하기
      else {
        summarContent('Error: ${response.statusCode}');
      }
    } else {
      //summarContent(articleContent);
      summarContent.value =
          await CloudTranslate().getTranslation(articleContent);
      summarContent.value = HtmlUnescape().convert(summarContent.value);
    }
  }

  getOtherNews(String stock) async {
    NewsCrawling().newsCrawling(stock, otherNews);
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    investmentIndex.value =
        await CloudNaturalLanguage().getPositiveNatural('오늘의 ${news['stock']}');
    summarizeText(news['article']);
    getOtherNews(news['stock']);
  }
}
