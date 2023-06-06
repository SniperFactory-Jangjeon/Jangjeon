import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class News {
  final int aiScore;
  final String article;
  final String date;
  final String stock;
  final String thumbnail;
  final String title;
  final String url;
  final Timestamp pubDate;

  News({
    required this.aiScore,
    required this.article,
    required this.date,
    required this.stock,
    required this.thumbnail,
    required this.title,
    required this.url,
    required this.pubDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'aiScore': aiScore,
      'article': article,
      'date': date,
      'stock': stock,
      'thumbnail': thumbnail,
      'title': title,
      'url': url,
      'pubDate': pubDate,
    };
  }

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      aiScore: map['aiScore'] as int,
      article: map['article'] as String,
      date: map['date'] as String,
      stock: map['stock'] as String,
      thumbnail: map['thumbnail'] as String,
      title: map['title'] as String,
      url: map['url'] as String,
      pubDate: map['pubDate'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory News.fromJson(String source) =>
      News.fromMap(json.decode(source) as Map<String, dynamic>);
}
