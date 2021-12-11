import 'package:book_store/componant/removeFromCard_controller.dart';
import 'package:book_store/componant/search_controller.dart';
import 'package:book_store/controller/book_list.dart';
import 'package:book_store/controller/card_count.dart';
import 'package:book_store/model/book.dart';
import 'package:book_store/model/sql_book_table.dart';
import 'package:book_store/screen/service/card_list_service.dart';
import 'package:book_store/screen/service/home_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardList extends StatefulWidget {
  const CardList({Key? key}) : super(key: key);

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  final cardCountController = Get.put(CardCountController());

  final BookListController bookListController = Get.find();

  List<Book> cardData = [];
  List<SqlBook> sqlCardData = [];
  void getAllCardDataFromSqlHome() async {
    var tempsqlCardData = await getAllCardDataFromSql();

    setState(() {
      sqlCardData = tempsqlCardData;
    });
    print('.........../sql card data...............');
    print(sqlCardData);
  }

  @override
  void initState() {
    super.initState();
    getAllCardDataFromSqlHome();
    bookListController.fetchBookData();
  }

  @override
  Widget build(BuildContext context) {
    // final cardCountController = Get.find()(CardCountController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.brown,
        leading: InkWell(
          child: const Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
        title: Row(children: [
          Expanded(
              child: SearchController(
                  hintText: "Search..", searchTextfieldCallBack: (value) {})),
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
                    return Text(controller.cardCount.toString(),
                        style:
                            const TextStyle(fontSize: 15, color: Colors.red));
                  }),
                  // child: Text(sqlCardData.length.toString())
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_cart_outlined))
            ],
          )
        ],
      ),
      body:
          //StreamBuilder(
          //   stream:
          //       FirebaseFirestore.instance.collection('Add-To-Card').snapshots(),
          //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //     if (!snapshot.hasData) {
          //       return const Center(
          //         child: Text('Card is empty'),
          //       );
          //     }
          ListView.builder(
              itemCount: sqlCardData.length,
              itemBuilder: (context, int index) {
                return InkWell(
                    child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side:
                              const BorderSide(color: Colors.black12, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                sqlCardData[index].imageUrl,
                                height: 70,
                                width: 70,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(sqlCardData[index].title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  "by " + sqlCardData[index].authorName,
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.grey),
                                ),
                                Text(
                                    "Rs." + sqlCardData[index].price.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RemoveFromCard(
                                      removeFromCardCallBack: () async {
                                        var result = await Connectivity()
                                            .checkConnectivity();

                                        if (result.toString() ==
                                                "ConnectivityResult.mobile" ||
                                            result.toString() ==
                                                "ConnectivityResult.wifi") {
                                          await deleteSpecificbookCardRecord(
                                              int.parse(sqlCardData[index].id));
                                          await cardDeleteFromFirebase(
                                              int.parse(sqlCardData[index].id));
                                          setState(() {
                                            sqlCardData.removeAt(index);
                                          });
                                          cardCountController.getCardCount();
                                        } else {
                                          print(
                                              '///////delete else main/////////////');
                                          addFromLocalDeleteCardItem(
                                              sqlCardData[index].id);
                                          await deleteSpecificbookCardRecord(
                                              int.parse(sqlCardData[index].id));
                                          setState(() {
                                            sqlCardData.removeAt(index);
                                          });
                                          //// getAllCardData();
                                          cardCountController.getCardCount();
                                        }
                                        var snackBar = const SnackBar(
                                          content:
                                              Text("Book remove from card"),
                                          duration: Duration(milliseconds: 250),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ))),
                    onTap: () {
                      Navigator.pushNamed(context, '/addToCard', arguments: {
                        'id': sqlCardData[index].id,
                        'image': sqlCardData[index].imageUrl,
                        'title': sqlCardData[index].title,
                        'author': sqlCardData[index].authorName,
                        'price': sqlCardData[index].price.toString()
                      });
                    });
              }),
      //},
      // ),
    );
  }
}
