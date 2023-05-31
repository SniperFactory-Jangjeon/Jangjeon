import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/ticket_controller.dart';
import 'package:jangjeon/view/screen/payment_method_screen.dart';
import 'package:jangjeon/view/screen/ticket_screen.dart';

class TicketPage extends GetView<TicketController> {
  const TicketPage({super.key});
  static const route = '/ticket';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [TicketScreen(), PaymentMethodScreen()],
      ),
    );
  }
}
