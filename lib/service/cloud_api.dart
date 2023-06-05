import 'dart:convert';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:http/http.dart' as http;

class CloudAPI {
  RegExp regex = RegExp(r'[.!?]');
  Future<String> summarizeText(String articleContent, int sentences) async {
    String apiKey = 'f0dce2f983cc65a00b24617ac3b1aadd';
    String apiUrl = 'https://api.meaningcloud.com/summarization-1.0';
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
        var summaryText = HtmlUnescape()
            .convert(await getTranslation(data['summary']))
            .replaceAll("[...]", "\n\n");
        return summaryText;
      }
      // 요청이 실패하면 오류 메시지 반환하기
      else {
        return 'Error: ${response.statusCode}';
      }
    } else {
      return HtmlUnescape().convert(await getTranslation(articleContent));
    }
  }

  Future<String> getTranslation(String text) async {
    var baseUrl = 'https://translation.googleapis.com/language/translate/v2';
    var key = 'AIzaSyDFssDe48Lbb0NfpeISB8b9W5pv_tMUwds';
    var to = "ko";
    var result = text;
    var response = await http.post(
      Uri.parse('$baseUrl?target=$to&key=$key&q=$text'),
    );
    if (response.statusCode == 200) {
      var dataJson = jsonDecode(response.body);
      result = dataJson['data']['translations'][0]['translatedText'];
    } else {
      result = response.statusCode.toString();
    }
    return result;
  }

  Future getNatural(String text) async {
    var apikey = 'AIzaSyDFssDe48Lbb0NfpeISB8b9W5pv_tMUwds';
    var url =
        'https://language.googleapis.com/v1/documents:analyzeSentiment?key=$apikey';

    var requestBody = {
      'document': {
        'type': 'PLAIN_TEXT',
        'content': text,
      },
      'encodingType': 'UTF8',
    };

    var response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      var dataJson = jsonDecode(response.body);
      var sentimentScore = dataJson['documentSentiment']['score'];
      return sentimentScore;
    } else {
      return 400;
    }
  }

  Future<double> getPositiveNatural(String txt) async {
    var num = await getNatural(txt);
    num = num < 0 ? -num : num;
    num = (num + 1) / 2;
    return (num * 100).toDouble();
  }
}
