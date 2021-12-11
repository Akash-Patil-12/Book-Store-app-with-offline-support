import 'package:book_store/screen/service/card_list_service.dart';
import 'package:book_store/screen/service/home_service.dart';
import 'package:book_store/sqflite/database_order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';

addPlaceBookOrderToFirebaseAndRemoveFromCard(Map<String, dynamic> row) async {
  await FirebaseFirestore.instance.collection("orderData").add(row);
  await cardDeleteFromFirebase(int.parse(row['cardId']));
  // await FirebaseFirestore.instance
  //     .collection('Add-To-Card')
  //     .doc(row['cardId'])
  //     .delete();
}

placeBookOrder(Map<String, dynamic> book) async {
  print(".............place book order............");
  final dbPlaceOrder = DataBasePlaceOrder.instance;

  var result = await Connectivity().checkConnectivity();
  if (result.toString() == "ConnectivityResult.mobile" ||
      result.toString() == "ConnectivityResult.wifi") {
    print('.................if place book order................');
    Map<String, dynamic> row = {
      DataBasePlaceOrder.columnID: book['cardId'].toString(),
      DataBasePlaceOrder.columnName: book['name'].toString(),
      DataBasePlaceOrder.columnLocality: book['locality'].toString(),
      DataBasePlaceOrder.columnPincode: book['pinCode'].toString(),
      DataBasePlaceOrder.columnAddress: book['address'].toString(),
      DataBasePlaceOrder.columnCity: book['city'].toString(),
      DataBasePlaceOrder.columnLandmark: book['landmark'].toString(),
      DataBasePlaceOrder.columnType: book['type'].toString(),
      DataBasePlaceOrder.columnBookName: book['bookName'].toString(),
      DataBasePlaceOrder.columnPrice: book['price'].toString(),
      DataBasePlaceOrder.columnCheckUpdate: "false"
    };
    print(row);
    final response = dbPlaceOrder.insert(row);
    print(response);
    addPlaceBookOrderToFirebaseAndRemoveFromCard(row);
    deleteSpecificbookCardRecord(int.parse(book['cardId']));
  } else {
    Map<String, dynamic> row = {
      DataBasePlaceOrder.columnID: book['cardId'].toString(),
      DataBasePlaceOrder.columnName: book['name'].toString(),
      DataBasePlaceOrder.columnLocality: book['locality'].toString(),
      DataBasePlaceOrder.columnPincode: book['pinCode'].toString(),
      DataBasePlaceOrder.columnAddress: book['address'].toString(),
      DataBasePlaceOrder.columnCity: book['city'].toString(),
      DataBasePlaceOrder.columnLandmark: book['landmark'].toString(),
      DataBasePlaceOrder.columnType: book['type'].toString(),
      DataBasePlaceOrder.columnBookName: book['bookName'].toString(),
      DataBasePlaceOrder.columnPrice: book['price'].toString(),
      DataBasePlaceOrder.columnCheckUpdate: "true"
    };
    await dbPlaceOrder.insert(row);
    addFromLocalDeleteCardItem(book['cardId'].toString());
    await deleteSpecificbookCardRecord(int.parse(book['cardId']));
  }
}

Future<void> getquerySpecificOrderData() async {
  print('...........get order specific data.............');
  final dbPlaceOrder = DataBasePlaceOrder.instance;
  var allrows = await dbPlaceOrder.querySpecific("true");
  if (allrows.isNotEmpty) {
    print('/////////////////////////order data isnotempty//////////////////');
    for (var row in allrows) {
      print(row);
      await FirebaseFirestore.instance.collection("orderData").add(row);
    }
    update();
    updateToFirebaseDataWhenNetworkOn();
  } else {
    print('-------------------------else------------------------');
  }
}

Future<void> update() async {
  print('........... update order specific data.............');
  final dbPlaceOrder = DataBasePlaceOrder.instance;
  var row = await dbPlaceOrder.updateData("true");
  print(row);
}
