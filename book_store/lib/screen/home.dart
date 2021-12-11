//import 'dart:async';
import 'package:book_store/componant/search_controller.dart';
import 'package:book_store/componant/wishlist_controller.dart';
import 'package:book_store/controller/book_list.dart';
import 'package:book_store/controller/card_count.dart';
//import 'package:book_store/model/book.dart';
import 'package:book_store/screen/service/home_service.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:book_store/sqflite/dbhelper.dart';

class home extends StatefulWidget {
  home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  final cardCountController = Get.put(CardCountController());
  final bookListController = Get.put(BookListController());
  String dropdownValue = 'Sort by relevance';
  //List<Book> bookListData = [];
  //List<Book> filterBookListData = [];
  // Future<void> getBookData() async {
  //   filterBookListData = await readBookListFromJsonFile();
  //   print(bookListData);
  //   setState(() {
  //     bookListData = filterBookListData;
  //   });
  //   print('*******************************************************');
  // }

  @override
  void initState() {
    super.initState();
    // getBookData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.brown,
        title: Row(children: [
          Expanded(
              child: SearchController(
            hintText: "Search..",
            searchTextfieldCallBack: (value) {
              if (value.isNotEmpty) {
                // setState(() {
                //   bookListData = filterBookListData
                //       .where((bookData) => bookData.title
                //           .toString()
                //           .toLowerCase()
                //           .contains(value.toLowerCase()))
                //       .toList();
                //   print("..........................");
                //   print(bookListData);
                // });
                bookListController.filterBookList(value);
              }
              if (value.isEmpty) {
                // print('..........else..........');
                // setState(() {
                //   bookListData = filterBookListData;
                // });
                bookListController.fetchBookData();
              }
              print(
                  ",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,");
              print(value);
            },
          )),
        ]),
        actions: [
          Stack(
            children: [
              Positioned(
                height: 250,
                width: 250,
                child: Container(
                  width: 150,
                  height: 150,
                  child: GetX<CardCountController>(builder: (controller) {
                    return Text(controller.cardItemCount.toString(),
                        style:
                            const TextStyle(fontSize: 15, color: Colors.red));
                  }),
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/card_list');
                  },
                  icon: const Icon(Icons.shopping_cart_outlined))
            ],
          )
        ],
      ),
      body: GetX<BookListController>(builder: (bookController) {
        return bookController.checkBookList.isTrue
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Books",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )),
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                              if (newValue == "Sort by relevance") {
                                print('.......sort relevance...........');
                                bookListController.fetchBookData();
                                // print(filterBookListData);
                                // setState(() {
                                //   bookListData = filterBookListData;
                                // });
                              }
                              if (newValue == "Price: Low to High") {
                                print('>>>>>>>>>>>low to high>>>>>>>>>>>>>');
                                // bookListData
                                //     .sort((a, b) => a.price.compareTo(b.price));
                                //print(bookListData);
                                bookListController.sortListLowToHigh();
                              }
                              if (newValue == "Price: High to Low") {
                                print('>>>>>>>>>>High to low>>>>>>>>>>>>>>');
                                // bookListData
                                //     .sort((b, a) => a.price.compareTo(b.price));
                                bookListController.sortListHighToLow();
                              }
                            });
                          },
                          items: <String>[
                            'Sort by relevance',
                            'Price: Low to High',
                            'Price: High to Low'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Obx(() => GridView.builder(
                          itemCount: bookListController.bookList.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                MediaQuery.of(context).orientation ==
                                        Orientation.landscape
                                    ? 4
                                    : 2,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              child: Card(
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Container(
                                        color: Colors.grey[100],
                                        height: 72,
                                        width: double.infinity,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Image.asset(
                                                bookListController
                                                    .bookList[index].imageUrl,
                                                height: 64,
                                                width: 70,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                                bookListController
                                                    .bookList[index].title,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(
                                              "by " +
                                                  bookListController
                                                      .bookList[index]
                                                      .authorName,
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey),
                                            ),
                                            Text(
                                                "Rs." +
                                                    bookListController
                                                        .bookList[index].price
                                                        .toString(),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextButton(
                                                    child: const Text(
                                                      'ADD TO BAG',
                                                      style: TextStyle(
                                                          fontSize: 9,
                                                          color: Colors.white),
                                                    ),
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .brown)),
                                                    onPressed: () async {
                                                      var boolCheckBookPresentInCardorNot =
                                                          await checkBookPresentInCardOrNot(
                                                              int.parse(
                                                                  bookListController
                                                                      .bookList[
                                                                          index]
                                                                      .id));
                                                      if (boolCheckBookPresentInCardorNot ==
                                                          true) {
                                                        Map<String, dynamic>
                                                            bookCardData = {
                                                          "id":
                                                              bookListController
                                                                  .bookList[
                                                                      index]
                                                                  .id,
                                                          "image":
                                                              bookListController
                                                                  .bookList[
                                                                      index]
                                                                  .imageUrl,
                                                          "title":
                                                              bookListController
                                                                  .bookList[
                                                                      index]
                                                                  .title,
                                                          "author":
                                                              bookListController
                                                                  .bookList[
                                                                      index]
                                                                  .authorName,
                                                          "price":
                                                              bookListController
                                                                  .bookList[
                                                                      index]
                                                                  .price
                                                                  .toString(),
                                                        };
                                                        await addToLocalDataBase(
                                                            bookCardData);
                                                        cardCountController
                                                            .getCardCount();
                                                        var snackBar =
                                                            const SnackBar(
                                                          content: Text(
                                                              "Book added to card"),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  250),
                                                        );
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                snackBar);
                                                      } else {
                                                        var snackBar =
                                                            const SnackBar(
                                                          content: Text(
                                                              "Book Already added in card"),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  250),
                                                        );
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                snackBar);
                                                        // cardCountController
                                                        //     .getCardCount();
                                                      }
                                                      // cardCountController
                                                      //     .getCardCount();
                                                    }),
                                                WishListController(
                                                  wishListControllerCallBack:
                                                      () {
                                                    print(
                                                        '.................WishList.....................');
                                                    // deleteSpecificbookCardRecord(
                                                    //     1);
                                                    // update();
                                                    // getquerySpecific();
                                                    getAllCardData();
                                                    //print(value);
                                                  },
                                                ), ///////////////////////////
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            );
                          })), ///////////////////////////
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
