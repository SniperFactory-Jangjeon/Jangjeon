import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class NewsDetailController extends GetxController {
  String apiKey = 'f0dce2f983cc65a00b24617ac3b1aadd';
  String apiUrl = 'https://api.meaningcloud.com/summarization-1.0';
  int sentences = 2;
  RxString summarContent = ''.obs;

  summarizeText(String articleContent) async {
    if (articleContent.length > 100) {
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
        summarContent(data['summary']);
        print(data['summary']);
      }
      // 요청이 실패하면 오류 메시지 반환하기
      else {
        summarContent('Error: ${response.statusCode}');
      }
    } else {
      summarContent(articleContent);
    }
  }

  openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
