import 'dart:async';

import 'package:book_store/screen/add_to_card.dart';
import 'package:book_store/screen/card_list.dart';
import 'package:book_store/screen/home.dart';
import 'package:book_store/screen/order.dart';
import 'package:book_store/screen/service/add_to_card_service.dart';
import 'package:book_store/screen/service/card_list_service.dart';
import 'package:book_store/screen/service/home_service.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var result = await Connectivity().checkConnectivity();
  print('.........................');
  print(result);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription subscription;

  @override
  void initState() {
    // super.initState();
    subscription = Connectivity().onConnectivityChanged.listen((event) {
      print(',,,,,,,,,,void main,,,,,,,,,,');
      print(event);
      if (event.toString() == "ConnectivityResult.mobile" ||
          event.toString() == "ConnectivityResult.wifi") {
        getquerySpecific();
        updateToFirebaseDataWhenNetworkOn();
        getquerySpecificOrderData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Store',
      initialRoute: '/home', // This widget is the root of your application.
      routes: {
        '/home': (context) => home(),
        '/addToCard': (context) => AddToCard(),
        '/card_list': (context) => const CardList(),
        '/order': (context) => Order()
      },
    );
  }
}
