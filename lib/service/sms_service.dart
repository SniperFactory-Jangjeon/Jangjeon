import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SMSService {
  final String url = "https://apis.aligo.in/send/";

  Future<String> requestVerificationCode(String receiver, String code) async {
    final response = await http.post(Uri.parse(url), body: <String, String>{
      'key': 'api 키',
      'user_id': 'ymsco',
      'sender': '01056819450',
      'receiver': receiver,
      'msg': '장전 앱에서 전송한 인증번호입니다.\n$code를 사용해 인증을 진행하세요.',
      'testmode_yn ': 'Y',
    });
    print(response.body);

    return response.body;
  }
}
