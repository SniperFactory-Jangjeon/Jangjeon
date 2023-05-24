import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyStock {
  SharedPreferences? prefs;
  List<String> myStockList = ['TSLA', 'MSFT'];
  List myStockInfo = [];
  //관심 주식 등록
  addMyStock(String stock) {
    if (myStockList.contains(stock)) {
      myStockList.remove(stock);
    } else {
      myStockList.add(stock);
    }
    if (prefs != null) {
      prefs!.setStringList('myStockList', myStockList);
    }
  }

  //관심 주식 불러오기
  getMyStock() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      myStockList = prefs!.getStringList('myStockList') ?? ['TSLA'];
    }
  }

  readMyStock() async {
    myStockInfo.clear();
    for (var myStock in myStockList) {
      var stock = await FirebaseFirestore.instance
          .collection('stockList')
          .where('symbol', isEqualTo: myStock)
          .get();
      myStockInfo.add(stock.docs.first.data());
    }
    return myStockInfo;
  }
}
