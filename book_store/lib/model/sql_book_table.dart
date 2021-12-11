import 'dart:convert';
import 'package:flutter/services.dart';

class SqlBook {
  String id;
  String imageUrl;
  String title;
  String authorName;
  double price;
  String checkNetwork;
  SqlBook(
      {required this.id,
      required this.imageUrl,
      required this.title,
      required this.authorName,
      required this.price,
      required this.checkNetwork});
  factory SqlBook.fromJson(Map<String, dynamic> json) {
    return SqlBook(
        id: json['id'].toString(),
        imageUrl: json['image'] as String,
        title: json['title'] as String,
        authorName: json['author'] as String,
        price: double.parse(json['price']),
        checkNetwork: json['checkNetwork'] as String);
  }
}
