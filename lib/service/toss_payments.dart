import 'dart:convert';

import 'package:http/http.dart' as http;

class TossPayments {
  //클라이언트 키는 브라우저에서 결제창을 연동할 때 사용합니다.
  var clientapiKey = 'test_ck_5mBZ1gQ4YVXgmZY1ZN23l2KPoqNb';
  //시크릿 키는 토스페이먼츠 API를 호출할 때 사용합니다.
  var secretapiKey = 'test_sk_OALnQvDd2VJ297B5eoYVMj7X41mN';

  //결제 생성 메서드
  Future<Map<String, dynamic>> createPayment(
      String orderId, double amount) async {
    //Toss Payments API의 결제 생성 엔드포인트를 나타내는 URL
    var url = 'https://api.tosspayments.com/v1/payments';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $clientapiKey',
    };

    var requestBody = {
      'order_id': orderId,
      'amount': amount,
      // 추가 필요한 매개변수들
    };

    var response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(requestBody));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to create payment: ${response.statusCode}');
    }
  }
}
