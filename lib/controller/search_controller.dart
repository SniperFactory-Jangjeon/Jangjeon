import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jangjeon/service/db_service.dart';

class SearchController extends GetxController {
  TextEditingController searchTextController = TextEditingController();
  RxList searchList = [].obs;
  // Firestore 실시간 검색
  void searchStock() async {}
}
