import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/ticket_controller.dart';
import 'package:jangjeon/util/app_color.dart';

class PaymentMethodPage extends GetView<TicketController> {
  const PaymentMethodPage({super.key});
  static const route = '/paymentmethod';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: AppColor.grayscale100,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back_ios_new))),
      body: Center(child: Text('결제수단 페이지')),
    );
  }
}
