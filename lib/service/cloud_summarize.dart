import 'dart:convert';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:jangjeon/service/cloud_translate.dart';
import 'package:http/http.dart' as http;

class CloudSummarize {
  String apiKey = 'f0dce2f983cc65a00b24617ac3b1aadd';
  String apiUrl = 'https://api.meaningcloud.com/summarization-1.0';
  RegExp regex = RegExp(r'[.!?]');
  Future<String> summarizeText(String articleContent, int sentences) async {
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
        return HtmlUnescape()
            .convert(await CloudTranslate().getTranslation(data['summary']));
      }
      // 요청이 실패하면 오류 메시지 반환하기
      else {
        return 'Error: ${response.statusCode}';
      }
    } else {
      return HtmlUnescape()
          .convert(await CloudTranslate().getTranslation(articleContent));
    }
  }
}
