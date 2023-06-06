import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/model/payment_request.dart';
import 'package:jangjeon/model/product.dart';
import 'package:jangjeon/service/toss_payments.dart';
import 'package:toss_payment/feature/payments/webview/payment_webview.dart';

class TicketController extends GetxController {
  PageController pageController = PageController(); //페이지 뷰 컨트롤러
  RxInt currentPage = 0.obs; //결제 현재 페이지
  bool isContentVisible = false;
  RxInt currentTicketIndex = 0.obs; //현재 선택된 옵션 인덱스
  RxList<bool> isSelected = [true, false, false].obs; //선택 여부 리스트
  RxBool isNextPageBtnActivated = false.obs; //다음단계 버튼 활성화 여부
  Product selectProduct = Product(price: 0, name: 'Basic');

  TossPayments tossPayMents = TossPayments();

  List<Product> step = [
    Product(price: 0, name: 'Basic'),
    Product(price: 3900, name: 'Advan'),
    Product(price: 8000, name: 'Pro')
  ];

  //페이지 이동
  jumpToPage(page) {
    currentPage(page);
    pageController.jumpToPage(page);
  }

  //옵션 선택 핸들러
  handleSelectOption(index) {
    currentTicketIndex.value = index;
    selectProduct = step[index];
    for (var i = 0; i < isSelected.length; i++) {
      if (i == index) {
        isSelected[i] = true;
      } else {
        isSelected[i] = false;
      }
    }
    activateNextPageButton();
  }

  //다음단계 버튼 활성화
  activateNextPageButton() {
    if (currentTicketIndex.value == 1 || currentTicketIndex.value == 2) {
      isNextPageBtnActivated.value = true;
    } else {
      isNextPageBtnActivated.value = false;
    }
  }

  showPayment(BuildContext context, PaymentRequest request) async {
    var ret = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        enableDrag: false,
        isDismissible: false,
        builder: (context) {
          bool success = false;
          return Container(
            margin: const EdgeInsets.only(top: 110),
            child: PaymentWebView(
              title: selectProduct.name,
              paymentRequestUrl: request.url,
              onPageStarted: (url) {
                dev.log('onPageStarted.url = $url', name: "PaymentWebView");
              },
              onPageFinished: (url) {
                dev.log('onPageFinished.url = $url', name: "PaymentWebView");
                // TODO something to decide the payment is successful or not.
                success = url.contains('success');
              },
              onDisposed: () {},
              onTapCloseButton: () {
                Navigator.of(context).pop(success);
              },
            ),
          );
        });
    dev.log('ret = $ret', name: '_showPayment');
  }
}

extension PaymentRequestExtension on PaymentRequest {
  Uri get url {
    // TODO 토스페이를 위해 만든 Web 주소를 넣어주세요. 아래는 예시입니다.
    return Uri.http("localhost:8080", "payment", json);
  }
}
