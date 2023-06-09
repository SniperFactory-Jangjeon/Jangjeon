import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/ticket_controller.dart';
import 'package:jangjeon/model/payment_request.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/util/app_text_style.dart';
import 'package:jangjeon/view/widget/app_elevated_button.dart';

class TicketScreen extends GetView<TicketController> {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back_ios_new))),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('이용권 구매', style: AppTextStyle.b1B24()),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => InkWell(
                      onTap: () => controller.handleSelectOption(0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 6.8),
                        decoration: BoxDecoration(
                          color: controller.currentTicketIndex.value == 0
                              ? AppColor.red10
                              : AppColor.grey,
                          borderRadius: BorderRadius.circular(10),
                          border: controller.currentTicketIndex.value == 0
                              ? Border.all(
                                  color: AppColor.red100,
                                )
                              : null,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Basic',
                                  style: AppTextStyle.h3B24(
                                    color:
                                        controller.currentTicketIndex.value == 0
                                            ? AppColor.red100
                                            : AppColor.grayscale30,
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(17),
                                      color:
                                          controller.currentTicketIndex.value ==
                                                  0
                                              ? AppColor.red100
                                              : AppColor.grayscale30),
                                  child: Center(
                                    child: Text('이용중',
                                        style: AppTextStyle.b5R12(
                                            color: AppColor.grayscale0)),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Free / 월',
                              style: AppTextStyle.b5R12(
                                  color:
                                      controller.currentTicketIndex.value == 0
                                          ? AppColor.grayscale80
                                          : AppColor.grayscale30),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 5,
                                  color:
                                      controller.currentTicketIndex.value == 0
                                          ? AppColor.grayscale100
                                          : AppColor.grayscale30,
                                ),
                                Flexible(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      ' 관심기업 개수 10개',
                                      style: AppTextStyle.b4M14(
                                          color: controller.currentTicketIndex
                                                      .value ==
                                                  0
                                              ? AppColor.grayscale100
                                              : AppColor.grayscale30),
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 5,
                                  color:
                                      controller.currentTicketIndex.value == 0
                                          ? AppColor.grayscale100
                                          : AppColor.grayscale30,
                                ),
                                Flexible(
                                  child: Text(
                                    ' 실시간 번역서비스 10개 조회',
                                    style: AppTextStyle.b4M14(
                                        color: controller
                                                    .currentTicketIndex.value ==
                                                0
                                            ? AppColor.grayscale100
                                            : AppColor.grayscale30),
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 5,
                                  color:
                                      controller.currentTicketIndex.value == 0
                                          ? AppColor.grayscale100
                                          : AppColor.grayscale30,
                                ),
                                Flexible(
                                  child: Text(
                                    ' 10개 이상 조회 시 광고',
                                    style: AppTextStyle.b4M14(
                                        color: controller
                                                    .currentTicketIndex.value ==
                                                0
                                            ? AppColor.grayscale100
                                            : AppColor.grayscale30),
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Obx(
                    () => InkWell(
                      onTap: () => controller.handleSelectOption(1),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 6.8),
                        decoration: BoxDecoration(
                          color: controller.currentTicketIndex.value == 1
                              ? AppColor.red10
                              : AppColor.grey,
                          borderRadius: BorderRadius.circular(10),
                          border: controller.currentTicketIndex.value == 1
                              ? Border.all(
                                  color: AppColor.red100,
                                )
                              : null,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Advan',
                                  style: AppTextStyle.h3B24(
                                    color:
                                        controller.currentTicketIndex.value == 1
                                            ? AppColor.red100
                                            : AppColor.grayscale30,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '3,900 / 단순결제',
                              style: AppTextStyle.b5R12(
                                  color:
                                      controller.currentTicketIndex.value == 1
                                          ? AppColor.grayscale80
                                          : AppColor.grayscale30),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 5,
                                  color:
                                      controller.currentTicketIndex.value == 1
                                          ? AppColor.grayscale100
                                          : AppColor.grayscale30,
                                ),
                                Flexible(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      ' 관심기업 개수 10개',
                                      style: AppTextStyle.b4M14(
                                          color: controller.currentTicketIndex
                                                      .value ==
                                                  1
                                              ? AppColor.grayscale100
                                              : AppColor.grayscale30),
                                      softWrap: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 5,
                                  color:
                                      controller.currentTicketIndex.value == 1
                                          ? AppColor.grayscale100
                                          : AppColor.grayscale30,
                                ),
                                Flexible(
                                  child: Text(
                                    ' 실시간 번역서비스 10개 조회',
                                    style: AppTextStyle.b4M14(
                                        color: controller
                                                    .currentTicketIndex.value ==
                                                1
                                            ? AppColor.grayscale100
                                            : AppColor.grayscale30),
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 5,
                                  color:
                                      controller.currentTicketIndex.value == 1
                                          ? AppColor.grayscale100
                                          : AppColor.grayscale30,
                                ),
                                Flexible(
                                  child: Text(
                                    ' 10개 이상 조회 시 광고',
                                    style: AppTextStyle.b4M14(
                                        color: controller
                                                    .currentTicketIndex.value ==
                                                1
                                            ? AppColor.grayscale100
                                            : AppColor.grayscale30),
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Obx(
                    () => InkWell(
                      onTap: () => controller.handleSelectOption(2),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 15),
                        decoration: BoxDecoration(
                          color: controller.currentTicketIndex.value == 2
                              ? AppColor.red10
                              : AppColor.grey,
                          borderRadius: BorderRadius.circular(10),
                          border: controller.currentTicketIndex.value == 2
                              ? Border.all(
                                  color: AppColor.red100,
                                )
                              : null,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pro',
                              style: AppTextStyle.h3B24(
                                  color:
                                      controller.currentTicketIndex.value == 2
                                          ? AppColor.red100
                                          : AppColor.grayscale30),
                            ),
                            const SizedBox(height: 2),
                            Text('8,000원 / 월',
                                style: AppTextStyle.b5R12(
                                    color:
                                        controller.currentTicketIndex.value == 2
                                            ? AppColor.grayscale80
                                            : AppColor.grayscale30)),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.circle,
                                    size: 5,
                                    color:
                                        controller.currentTicketIndex.value == 2
                                            ? AppColor.grayscale100
                                            : AppColor.grayscale30),
                                const SizedBox(width: 2),
                                Flexible(
                                  child: Text(
                                    ' 관심기업 개수 무제한',
                                    style: AppTextStyle.b4M14(
                                        color: controller
                                                    .currentTicketIndex.value ==
                                                2
                                            ? AppColor.grayscale100
                                            : AppColor.grayscale30),
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Icon(Icons.circle,
                                    size: 5,
                                    color:
                                        controller.currentTicketIndex.value == 2
                                            ? AppColor.grayscale100
                                            : AppColor.grayscale30),
                                const SizedBox(width: 2),
                                Flexible(
                                  child: Text(
                                    ' 실시간 번역서비스 무제한',
                                    style: AppTextStyle.b4M14(
                                        color: controller
                                                    .currentTicketIndex.value ==
                                                2
                                            ? AppColor.grayscale100
                                            : AppColor.grayscale30),
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Icon(Icons.circle,
                                    size: 5,
                                    color:
                                        controller.currentTicketIndex.value == 2
                                            ? AppColor.grayscale100
                                            : AppColor.grayscale30),
                                Text(
                                  ' 광고 제거',
                                  style: AppTextStyle.b4M14(
                                      color:
                                          controller.currentTicketIndex.value ==
                                                  2
                                              ? AppColor.grayscale100
                                              : AppColor.grayscale30),
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Obx(
                () => AppElevatedButton(
                    childText: '다음단계',
                    onPressed: controller.isNextPageBtnActivated.value
                        ? () {
                            if (controller.currentTicketIndex.value == 1) {
                              controller.showPayment(
                                  context,
                                  PaymentRequest.card(
                                      amount: 3900,
                                      orderId: 'orderId',
                                      orderName: 'Advan',
                                      customerName: 'customerName'));
                            } else if (controller.currentTicketIndex.value ==
                                2) {
                              controller.jumpToPage(1);
                            }
                          }
                        : null),
              ),
            )
          ],
        ),
      ),
    );
  }
}
