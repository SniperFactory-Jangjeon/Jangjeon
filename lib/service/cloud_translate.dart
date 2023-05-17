import 'dart:convert';
import 'package:http/http.dart' as http;

class CloudTranslate {
  // 사용 방법 await CloudTranslate().getTranslation(text);
  Future<String> getTranslation(String text) async {
    var baseUrl = 'https://translation.googleapis.com/language/translate/v2';
    var key = 'AIzaSyDFssDe48Lbb0NfpeISB8b9W5pv_tMUwds';
    //var apiKey = Platform.environment['API_KEY'];
    var to = "ko";
    var result;
    var response = await http.post(
      Uri.parse('$baseUrl?target=$to&key=$key&q=$text'),
    );
    if (response.statusCode == 200) {
      var dataJson = jsonDecode(response.body);
      result = dataJson['data']['translations'][0]['translatedText'];
    } else {
      result = response.statusCode;
    }
    return result;
  }
}
