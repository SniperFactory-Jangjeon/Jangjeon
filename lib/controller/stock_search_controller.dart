import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/main_controller.dart';
import 'package:jangjeon/model/stock.dart';
import 'package:jangjeon/service/db_service.dart';

class StockSearchController extends GetxController {
  FocusNode focusNode = FocusNode();
  TextEditingController searchTextController = TextEditingController();
  List stockList = [];
  RxList searchList = [].obs;
  var main = Get.find<MainController>();

  readStock() async {
    stockList.addAll(await DBService()
        .readStock()
        .then((e) => e.map((value) => Stock.fromMap(value.data()))));

    searchList.addAll(stockList);
  }

  searchStock() {
    searchList.clear();
    for (var i = 0; i < stockList.length; i++) {
      if (stockList[i].nameForSearch.contains(searchTextController.text)) {
        searchList.add(stockList[i]);
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    readStock();
  }
}
