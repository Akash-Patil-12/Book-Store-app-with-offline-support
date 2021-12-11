import 'dart:convert';

import 'package:book_store/model/book.dart';
import 'package:book_store/model/sql_book_table.dart';
import 'package:book_store/sqflite/dbhelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';

Future<List<Book>> readBookListFromJsonFile() async {
  List<Book> bookData = [];
  final String response = await rootBundle.loadString('assets/books.json');
  var data = json.decode(response);
  for (var bookjson in data) {
    bookData.add(Book.fromJson(bookjson));
  }
  return bookData;
}

Future<List<SqlBook>> getAllCardDataFromSql() async {
  print('.................all data....................');
  List<SqlBook> cardData = [];

  final dbhelper = Databasehelper.instance;
  print('.................all data....................');
  var allrows = await dbhelper.queryall();
  for (var row in allrows) {
    print(row);
    cardData.add(SqlBook.fromJson(row));
  }
  return cardData;
}

Future<int> getCardItemLengthFromSql() async {
  print('.................all data....................');
  // List<SqlBook> cardData = [];

  final dbhelper = Databasehelper.instance;
  print('.................all data....................');
  var allrows = await dbhelper.queryall();
  // for (var row in allrows) {
  //   print(row);
  //   cardData.add(SqlBook.fromJson(row));
  // }
  return allrows.length;
}

addToCardBook(Map<String, dynamic> book) {
  FirebaseFirestore.instance.collection("Add-To-Card").add(book);
}

addToLocalDataBase(Map<String, dynamic> data) async {
  final dbhelper = Databasehelper.instance;

  var result = await Connectivity().checkConnectivity();
  if (result.toString() == "ConnectivityResult.mobile" ||
      result.toString() == "ConnectivityResult.wifi") {
    print('<<<<<<<<<<<<<<<<<<<<MObile>>>>>>>>>>>>>>>>>>>>>>');
    Map<String, dynamic> row = {
      Databasehelper.columnID: data['id'].toString(),
      Databasehelper.columnAuthor: data['author'].toString(),
      Databasehelper.columnImage: data['image'].toString(),
      Databasehelper.columnPrice: data['price'].toString(),
      Databasehelper.columnTitle: data['title'].toString(),
      Databasehelper.columnCheckNetwork: "false"
    };
    final response = await dbhelper.insert(row);
    print(',,,,,,,,,,,,,,,,,,,,,,,,,,');
    print(response);
    addToCardBook(row);
  }
  if (result.toString() == "ConnectivityResult.none") {
    print('<<<<<<<<<<<<<<<<<<<<Offline>>>>>>>>>>>>>>>>>>>>>>');
    Map<String, dynamic> row = {
      Databasehelper.columnID: data['id'].toString(),
      Databasehelper.columnAuthor: data['author'].toString(),
      Databasehelper.columnImage: data['image'].toString(),
      Databasehelper.columnPrice: data['price'].toString(),
      Databasehelper.columnTitle: data['title'].toString(),
      Databasehelper.columnCheckNetwork: "true"
    };
    final response = await dbhelper.insert(row);
    print(',,,,,,,,,,,,,,,,,,,,,,,,,,');
    print(response);
  }
}

Future<void> getAllCardData() async {
  print('.................all data....................');

  final dbhelper = Databasehelper.instance;
  print('.................all data....................');
  var allrows = await dbhelper.queryall();
  for (var row in allrows) {
    print(row);
  }
}

Future<void> getquerySpecific() async {
  print('...........get specific data.............');
  final dbhelper = Databasehelper.instance;
  var allrows = await dbhelper.querySpecific("true");
  if (allrows.isNotEmpty) {
    print('/////////////////////////isnotempty//////////////////');
    for (var row in allrows) {
      print(row);
      addToCardBook(row);
    }
    update();
  } else {
    print('-------------------------else------------------------');
  }
}

Future<bool> checkBookPresentInCardOrNot(int bookId) async {
  final dbhelper = Databasehelper.instance;
  var bookresult = await dbhelper.checkBookPresentInTableOrNot(bookId);
  if (bookresult.length == 1) {
    return false;
  } else {
    return true;
  }
}

Future<void> update() async {
  print('........... update specific data.............');
  final dbhelper = Databasehelper.instance;
  var row = await dbhelper.updateData("true");
  print(row);
}

Future<void> deleteSpecificbookCardRecord(int id) async {
  print('........... delete specific data.............');
  final dbhelper = Databasehelper.instance;
  var row = await dbhelper.deleteData(id);
  print(row);
}
