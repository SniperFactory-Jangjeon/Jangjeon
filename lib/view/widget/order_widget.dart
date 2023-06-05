//사용안함 삭제해도될듯?

// import 'dart:convert';
// import 'dart:math';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:jangjeon/model/payment_request.dart';
// import 'package:jangjeon/model/product.dart';

// class OrderWidget extends StatelessWidget {
//   final String payBy;
//   final String title;
//   final Product product;
//   final Function(PaymentRequest request) onTap;

//   const OrderWidget({
//     Key? key,
//     required this.payBy,
//     required this.title,
//     required this.product,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         onTap(paymentRequest);
//       },
//       child: Container(
//         margin: const EdgeInsets.all(4),
//         decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey.shade700),
//             borderRadius: const BorderRadius.all(Radius.circular(8))),
//         child: Center(
//           child: Text(title),
//         ),
//       ),
//     );
//   }

//   PaymentRequest get paymentRequest {
//     PaymentRequest? ret;
//     if (payBy == '카드') {
//       ret = PaymentRequest.card(
//         amount: product.price,
//         orderId: _generateOrderId(),
//         orderName: product.name,
//         customerName: _customerName,
//       );
//     }
//     return ret!;
//   }

//   String _generateOrderId() {
//     var ret = base64Encode([
//       Random(DateTime.now().millisecond).nextInt(9),
//       Random(DateTime.now().millisecond).nextInt(9),
//       Random(DateTime.now().millisecond).nextInt(9),
//       Random(DateTime.now().millisecond).nextInt(9),
//       Random(DateTime.now().millisecond).nextInt(9),
//       Random(DateTime.now().millisecond).nextInt(9),
//     ]).toString();
//     return ret;
//   }

//   String _generateCustomerKey() {
//     // var ret = base64Encode([
//     //   Random(DateTime.now().millisecond).nextInt(9),
//     //   Random(DateTime.now().millisecond).nextInt(9),
//     //   Random(DateTime.now().millisecond).nextInt(9),
//     //   Random(DateTime.now().millisecond).nextInt(9),
//     //   Random(DateTime.now().millisecond).nextInt(9),
//     //   Random(DateTime.now().millisecond).nextInt(9),
//     // ]).toString();
//     return 'Y12n2V0fIRS_DUQyp6dsF';
//   }

//   String get _customerName => "레토스";
// }
