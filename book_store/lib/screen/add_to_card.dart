import 'package:book_store/componant/search_controller.dart';
import 'package:book_store/controller/card_count.dart';
import 'package:book_store/screen/service/add_to_card_service.dart';
import 'package:book_store/screen/service/card_list_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:form_field_validator/form_field_validator.dart';

enum SingingCharacter { Home, Work, Other }

class AddToCard extends StatefulWidget {
  AddToCard({Key? key}) : super(key: key);

  @override
  _AddToCardState createState() => _AddToCardState();
}

class _AddToCardState extends State<AddToCard> {
  SingingCharacter? _character = SingingCharacter.Home;
  String deliveryPlace = "Home";
  Map cardData = {};
  int cardCount = 0;
  int itemCount = 1;
  bool isSummaryVisible = false,
      isCustomerVisible = true,
      isCustomerDetailVisible = false,
      isOrderSummaryVisible = true,
      isOrderDetailSummaryVisible = false;
  TextEditingController name = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  TextEditingController locality = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  void initState() {
    super.initState();
    //getCardDataCount();
  }

  @override
  Widget build(BuildContext context) {
    final cardCountController = Get.put(CardCountController());
    cardData = ModalRoute.of(context)!.settings.arguments as Map;

    var width = MediaQuery.of(context).size.width;
    print('.....................');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: Row(children: [
            Expanded(
                child: Container(
                    color: Colors.white,
                    child: SearchController(
                        hintText: "Search..",
                        searchTextfieldCallBack: (value) {}))),
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
                    child:
                        // Text(cardCount.toString(),
                        //     style:
                        //         const TextStyle(fontSize: 15, color: Colors.red)),
                        GetX<CardCountController>(builder: (controller) {
                      return Text(controller.cardCount.toString(),
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
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20, left: 20),
                          child: Text(
                            'My Card',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                        ),
                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    cardData['image'],
                                    height: 90,
                                    width: 70,
                                    fit: BoxFit.fill,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Text(cardData['title'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "by " + cardData['author'],
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    "Rs." +
                                        (double.parse(cardData['price']) *
                                                itemCount)
                                            .toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: const Icon(
                                            Icons.remove,
                                          ),
                                        ),
                                        onTap: () {
                                          if (itemCount > 1) {
                                            setState(() {
                                              itemCount = itemCount - 1;
                                            });
                                          }
                                        },
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                          height: 27,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black12)),
                                          child: Center(
                                              child:
                                                  Text(itemCount.toString()))),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: const Icon(
                                            Icons.add,
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            itemCount = itemCount + 1;
                                          });
                                        },
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: isCustomerVisible,
                            child: InkWell(
                              child: Container(
                                width: double.infinity,
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text('Customer Details',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  isCustomerVisible = false;
                                  isCustomerDetailVisible = true;
                                });
                              },
                            ),
                          ),
                          Visibility(
                            visible: isCustomerDetailVisible,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 10, left: 13),
                                  child: Text('Customer Details',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                        height: 50,
                                        width: width / 2.39,
                                        child: TextFormField(
                                          controller: name,
                                          validator: RequiredValidator(
                                              errorText:
                                                  "This field is required"),
                                          decoration: const InputDecoration(
                                              hintText: "Name",
                                              hintStyle: TextStyle(
                                                fontSize: 15,
                                              ),
                                              border: OutlineInputBorder()),
                                        )),
                                    Container(
                                        height: 50,
                                        width: width / 2.39,
                                        child: TextFormField(
                                          controller: phoneNo,
                                          validator: RequiredValidator(
                                              errorText:
                                                  "This field is required"),
                                          decoration: const InputDecoration(
                                              hintText: "Phone Number",
                                              hintStyle: TextStyle(
                                                fontSize: 15,
                                              ),
                                              border: OutlineInputBorder()),
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                        height: 50,
                                        width: width / 2.39,
                                        child: TextFormField(
                                          controller: pinCode,
                                          validator: RequiredValidator(
                                              errorText:
                                                  "This field is required"),
                                          decoration: const InputDecoration(
                                              hintText: "Pincode",
                                              hintStyle: TextStyle(
                                                fontSize: 15,
                                              ),
                                              border: OutlineInputBorder()),
                                        )),
                                    Container(
                                        height: 50,
                                        width: width / 2.39,
                                        child: TextFormField(
                                          controller: locality,
                                          validator: RequiredValidator(
                                              errorText:
                                                  "This field is required"),
                                          decoration: const InputDecoration(
                                              hintText: "Locality",
                                              hintStyle: TextStyle(
                                                fontSize: 15,
                                              ),
                                              border: OutlineInputBorder()),
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        padding: EdgeInsets.all(0),
                                        width: width / 1.14,
                                        height: 100,
                                        child: TextFormField(
                                            controller: address,
                                            validator: RequiredValidator(
                                                errorText:
                                                    "This field is required"),
                                            decoration: const InputDecoration(
                                                hintText: "Address",
                                                border: InputBorder.none,
                                                hintStyle: TextStyle(
                                                  fontSize: 15,
                                                ))),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey.shade500)),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                        height: 50,
                                        width: width / 2.39,
                                        child: TextFormField(
                                          controller: city,
                                          validator: RequiredValidator(
                                              errorText:
                                                  "This field is required"),
                                          decoration: const InputDecoration(
                                              hintText: "City/Town",
                                              hintStyle: TextStyle(
                                                fontSize: 15,
                                              ),
                                              border: OutlineInputBorder()),
                                        )),
                                    Container(
                                        height: 50,
                                        width: width / 2.39,
                                        child: TextFormField(
                                          controller: landmark,
                                          validator: RequiredValidator(
                                              errorText:
                                                  "This field is required"),
                                          decoration: const InputDecoration(
                                              hintText: "Landmark",
                                              hintStyle: TextStyle(
                                                fontSize: 15,
                                              ),
                                              border: OutlineInputBorder()),
                                        )),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Type"),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Radio<SingingCharacter>(
                                            value: SingingCharacter.Home,
                                            groupValue: _character,
                                            onChanged:
                                                (SingingCharacter? value) {
                                              setState(() {
                                                _character = value;
                                                deliveryPlace = "Home";
                                              });
                                              print(".....home");
                                            },
                                          ),
                                          Text("Home"),
                                          Radio<SingingCharacter>(
                                            value: SingingCharacter.Work,
                                            groupValue: _character,
                                            onChanged:
                                                (SingingCharacter? value) {
                                              setState(() {
                                                _character = value;
                                                deliveryPlace = "Work";
                                              });

                                              print(".......Work");
                                            },
                                          ),
                                          Text("Work"),
                                          Radio<SingingCharacter>(
                                            value: SingingCharacter.Other,
                                            groupValue: _character,
                                            onChanged:
                                                (SingingCharacter? value) {
                                              setState(() {
                                                _character = value;
                                                deliveryPlace = "Other";
                                              });

                                              print(".......other");
                                            },
                                          ),
                                          Text("Other"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        child: const Text(
                                          'CONTINUE',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white),
                                        ),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.blue)),
                                        onPressed: () {
                                          setState(() {
                                            isOrderSummaryVisible = false;
                                            isOrderDetailSummaryVisible = true;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: isOrderSummaryVisible,
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Order Summary',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isOrderDetailSummaryVisible,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 9, top: 8),
                                child: Text(
                                  'Order Summary',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                              ),
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          cardData['image'],
                                          height: 90,
                                          width: 70,
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(cardData['title'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "by " + cardData['author'],
                                          style: const TextStyle(
                                              fontSize: 10, color: Colors.grey),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            "Rs." +
                                                (double.parse(
                                                            cardData['price']) *
                                                        itemCount)
                                                    .toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ]),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      child: const Text(
                                        'CHECKOUT',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.white),
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.blue)),
                                      onPressed: () async {
                                        Map<String, dynamic> bookCardData = {
                                          "cardId": cardData['id'],
                                          "name": name.text,
                                          "locality": locality.text,
                                          "pinCode": pinCode.text,
                                          "address": address.text,
                                          "city": city.text,
                                          "landmark": city.text,
                                          "type": deliveryPlace,
                                          "bookName": cardData['title'],
                                          "price":
                                              (double.parse(cardData['price']) *
                                                      itemCount)
                                                  .toString()
                                        };
                                        // await cardDeleteFromFirebase(
                                        //       int.parse(cardData['id']));
                                        await placeBookOrder(bookCardData);
                                        // FirebaseFirestore.instance
                                        //     .collection("orderData")
                                        //     .add(bookCardData);
                                        // FirebaseFirestore.instance
                                        //     .collection('Add-To-Card')
                                        //     .doc(orderData['cardId'])
                                        //     .delete();
                                        cardCountController.getCardCount();
                                        Navigator.pushNamed(context, '/order');
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
