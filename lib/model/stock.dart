import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Stock {
  String logo;
  String name;
  String nameForSearch;
  String symbol;
  double aiScore;
  Stock({
    required this.logo,
    required this.name,
    required this.nameForSearch,
    required this.symbol,
    required this.aiScore,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'logo': logo,
      'name': name,
      'nameForSearch': nameForSearch,
      'symbol': symbol,
      'aiScore': aiScore,
    };
  }

  factory Stock.fromMap(Map<String, dynamic> map) {
    return Stock(
      logo: map['logo'] as String,
      name: map['name'] as String,
      nameForSearch: map['name for search'] as String,
      symbol: map['symbol'] as String,
      aiScore: map['aiScore'].toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Stock.fromJson(String source) =>
      Stock.fromMap(json.decode(source) as Map<String, dynamic>);
}
