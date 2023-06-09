class PaymentRequest {
  final String payBy;
  int? amount;
  String? orderId;
  String? orderName;
  String? customerName;

  // billing auth
  String? customerKey;

  // card direct
  String? flowMode;
  String? cardCompany;

  // virtual account
  int? validHours;
  Map<String, String>? cashReceipt;

  // account transfer
  String? bank;

  PaymentRequest({
    required this.payBy,
    this.amount,
    this.orderId,
    this.orderName,
    this.customerName,

    // billing auth
    this.customerKey,

    // card direct
    this.flowMode,
    this.cardCompany,

    // virtual account
    // this.validHours,
    // this.cashReceipt,
    // account transfer
    this.bank,
  });

  Map<String, dynamic> get json {
    Map<String, dynamic> ret = {};

    ret.addAll({"pay_by": payBy});

    if (amount != null) {
      ret.addAll({"amount": "$amount"});
    }

    if (orderId != null) {
      ret.addAll({"order_id": orderId});
    }
    if (orderName != null) {
      ret.addAll({"order_name": orderName});
    }
    if (customerName != null) {
      ret.addAll({"customer_name": customerName});
    }
    if (customerKey != null) {
      ret.addAll({"customer_key": customerKey});
    }
    if (flowMode != null) {
      ret.addAll({"flow_mode": flowMode});
    }
    if (cardCompany != null) {
      ret.addAll({"card_company": cardCompany});
    }
    // if (validHours != null) {
    //   ret.addAll({"valid_hours": "$validHours"});
    // }
    // if (cashReceipt != null) {
    //   ret.addAll({"cash_receipt": cashReceipt});
    // }

    if (bank != null) {
      ret.addAll({"bank": bank});
    }

    return ret;
  }

  factory PaymentRequest.card({
    required int amount,
    required String orderId,
    required String orderName,
    required String customerName,
  }) {
    return PaymentRequest(
      payBy: "카드",
      amount: amount,
      orderId: orderId,
      orderName: orderName,
      customerName: customerName,
    );
  }

  static PaymentRequest? fromJson(json) {
    PaymentRequest? ret;
    if (json['pay_by'] == '카드') {
      ret = PaymentRequest.card(
          amount: int.parse(json['amount']),
          orderId: json['order_id'],
          orderName: json['order_name'],
          customerName: json['customer_name']);
    }
    return ret;
  }
}
