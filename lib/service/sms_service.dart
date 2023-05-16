import 'package:http/http.dart' as http;

class SMSService {
  final String url = "https://apis.aligo.in/send/";

  //인증코드 요청
  Future<String> requestVerificationCode(String receiver, String code) async {
    final response = await http.post(Uri.parse(url), body: <String, String>{
      'key': 'api키 입력',
      'user_id': 'ymsco',
      'sender': '01056819450',
      'receiver': receiver,
      'msg': '장전 앱에서 전송한 인증번호입니다.\n[$code]를 사용해 인증을 진행하세요.',
      'testmode_yn ': 'Y',
    });

    return response.body;
  }

  //이메일 주소 전송
  Future<String> sendEmail(String receiver, String email) async {
    final response = await http.post(Uri.parse(url), body: <String, String>{
      'key': 'api키 입력',
      'user_id': 'ymsco',
      'sender': '01056819450',
      'receiver': receiver,
      'msg': email.isNotEmpty
          ? '장전 앱에 가입된 이메일 주소는 \n[$email]입니다. 해당 이메일 주소로 로그인 해주세요. '
          : '장전 앱에 가입된 이메일 주소가 없습니다. 회원가입을 통해 장전을 사용해 보세요!!',
      'testmode_yn ': 'Y',
    });

    return response.body;
  }
}
