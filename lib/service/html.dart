import 'package:jangjeon/model/payment_request.dart';

class PaymentHtml {
  static String generate(PaymentRequest request) {
    String ret = "";
    if (request.payBy == '카드') {
      ret = card(request);
    }

    return ret;
  }

  static String card(PaymentRequest request) {
    return '''<html>
      <head>
   <script src="https://js.tosspayments.com/v1"></script>
   </head>
   <body>
   <script>
   var tossPayments = TossPayments('test_ck_OEP59LybZ8Bdv6A1JxkV6GYo7pRe')
   tossPayments.requestPayment('카드', {
   amount: ${request.amount},
   orderId: '${request.orderId}',
   orderName: '${request.orderName}',
   customerName: '${request.customerName}',
   successUrl: window.location.origin + '/success',
   failUrl: window.location.origin + '/fail',
   })
   </script>
   </body>
   </html>
   ''';
  }
}

String successHtml = '''<html><h1>Success</h1></html>''';
String failHtml = '''<html><h1>Fail</h1></html>''';
