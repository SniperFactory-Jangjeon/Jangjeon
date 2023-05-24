import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Stock {
  String logo;
  String name;
  String nameForSearch;
  String symbol;
  Stock({
    required this.logo,
    required this.name,
    required this.nameForSearch,
    required this.symbol,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'logo': logo,
      'name': name,
      'nameForSearch': nameForSearch,
      'symbol': symbol,
    };
  }

  factory Stock.fromMap(Map<String, dynamic> map) {
    return Stock(
      logo: map['logo'] as String,
      name: map['name'] as String,
      nameForSearch: map['nameForSearch'] as String,
      symbol: map['symbol'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Stock.fromJson(String source) =>
      Stock.fromMap(json.decode(source) as Map<String, dynamic>);
}
