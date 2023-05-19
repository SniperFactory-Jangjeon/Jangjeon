import 'dart:convert';
import 'package:http/http.dart' as http;

class CloudNaturalLanguage {
  var apikey = 'AIzaSyDFssDe48Lbb0NfpeISB8b9W5pv_tMUwds';
  Future<double> getNatural(String text) async {
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
}
