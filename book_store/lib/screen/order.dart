import 'package:book_store/controller/card_count.dart';
import 'package:book_store/model/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Order extends StatefulWidget {
  Order({Key? key}) : super(key: key);

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final FocusNode _focusNode = FocusNode();
  //Map ordrData = {};
  int cardCount = 1;
  Future<void> getCardDataCount() async {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCardDataCount();
  }

  @override
  Widget build(BuildContext context) {
    //   final cardCountController = Get.put(CardCountController());

    // orderData = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.brown,
        leading: InkWell(
          child: const Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pushNamed(context, '/card_list');
          },
        ),
        title: Row(children: [
          Expanded(
              child: Container(
                  color: Colors.white,
                  child: TextField(
                    onChanged: (value) {},
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(2),
                        hintText: "Search...",
                        fillColor: Colors.white,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(),
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: _focusNode.hasFocus
                                    ? Colors.grey.shade600
                                    : Colors.grey.shade500))),
                  ))),
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
                  // Text(cardCount.toString(),
                  //     style: const TextStyle(fontSize: 15, color: Colors.red)),
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/addToCard');
                  },
                  icon: const Icon(Icons.shopping_cart_outlined))
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          // height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
              ),
              const Text(
                'Order Placed Successfully',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              // Image.asset(
              //   "assets/images/orderSuccessfull-2.png",
              //   height: 60,
              //   width: 60,
              // ),
              const Text(
                'hurray!! your order is confirmed',
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'The order id is #123456 save the order id for',
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'further communication.',
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                    //defaultColumnWidth: FixedColumnWidth(120.0),
                    border: TableBorder.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 2),
                    children: [
                      TableRow(children: [
                        Column(children: const [
                          Text('Email us', style: TextStyle(fontSize: 20.0))
                        ]),
                        Column(children: const [
                          Text('Contact us', style: TextStyle(fontSize: 20.0))
                        ]),
                        Column(children: const [
                          Text('Address', style: TextStyle(fontSize: 20.0))
                        ]),
                      ]),
                      TableRow(children: [
                        Column(children: const [
                          Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Text('admin@bookstore.com'),
                          )
                        ]),
                        Column(children: const [
                          Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Text('+91 8163475881'),
                          )
                        ]),
                        Column(children: const [
                          Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Text(
                                '42, 14th Main, 15th Cross, Sector 4, opp to BDA /n complex, near Kumarakom restaurant, HSR Layout, Bangalore 560034'),
                          )
                        ]),
                      ]),
                    ]),
              ),

              TextButton(
                child: const Text(
                  'CONTINUE SHOPPING',
                  style: TextStyle(fontSize: 11, color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(4.0),
                  )),
                ),
                onPressed: () {
                  // Map<String, dynamic> bookCardData = {
                  //   "name": orderData['name'],
                  //   "pinCode": orderData['pinCode'],
                  //   "locality": orderData['locality'],
                  //   "address": orderData['address'],
                  //   "city": orderData['city'],
                  //   "landmark": orderData['landmark'],
                  //   "type": orderData['type'],
                  //   "bookName": orderData['bookName'],
                  //   "price": orderData['price'].toString()
                  // };
                  // FirebaseFirestore.instance
                  //     .collection("orderData")
                  //     .add(bookCardData);
                  // FirebaseFirestore.instance
                  //     .collection('Add-To-Card')
                  //     .doc(orderData['cardId'])
                  //     .delete();
                  // cardCountController.getCardCount();

                  Navigator.pushNamed(context, '/home');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
