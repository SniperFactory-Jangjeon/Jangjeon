import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jangjeon/model/stock.dart';
import 'package:jangjeon/service/db_service.dart';

class SearchController extends GetxController {
  TextEditingController searchTextController = TextEditingController();
  List stockList = [];
  RxList searchList = [].obs;

  readStock() async {
    stockList.addAll(await DBService()
        .readStock()
        .then((e) => e.map((value) => Stock.fromMap(value.data()))));

    searchList.addAll(stockList);
  }

  void searchStock() async {
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
