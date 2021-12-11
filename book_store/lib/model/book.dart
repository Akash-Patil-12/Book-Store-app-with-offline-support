import 'dart:convert';
import 'package:flutter/services.dart';

class Book {
  String id;
  String imageUrl;
  String title;
  String authorName;
  double price;
  Book(
      {required this.id,
      required this.imageUrl,
      required this.title,
      required this.authorName,
      required this.price});
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        id: json['id'] as String,
        imageUrl: json['image'] as String,
        title: json['title'] as String,
        authorName: json['author'] as String,
        price: double.parse(json['price']));
  }
}
