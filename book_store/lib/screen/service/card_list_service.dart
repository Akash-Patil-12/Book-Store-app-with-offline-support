import 'package:book_store/sqflite/database_delete_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

addFromLocalDeleteCardItem(String id) async {
  final deleteDatabaseInstance = DataBaseDeleteCardItem.instance;

  Map<String, dynamic> row = {
    DataBaseDeleteCardItem.columnID: id.toString(),
  };
  final response = await deleteDatabaseInstance.insert(row);
  print("...........add id to delete table");
  print(response);
}

Future<void> getAllCardData() async {
  print('.................all data....................');

  final deleteDatabaseInstance = DataBaseDeleteCardItem.instance;
  print('.................all data....................');
  var allrows = await deleteDatabaseInstance.queryall();
  for (var row in allrows) {
    print(row['id']);
  }
}

Future<void> updateToFirebaseDataWhenNetworkOn() async {
  print('...........get specific delete data.............');
  final deleteDatabaseInstance = DataBaseDeleteCardItem.instance;
  print('.................all delete data....................');
  var allrows = await deleteDatabaseInstance.queryall();
  if (allrows.isNotEmpty) {
    print('/////////////////////////isnotempty//////////////////');
    for (var row in allrows) {
      print(row);
      cardDeleteFromFirebase(int.parse(row['id']));
    }
    updateToLocalDeleteCardItemTable();
  } else {
    print('-------------------------else delete------------------------');
  }
}

Future<void> updateToLocalDeleteCardItemTable() async {
  print('........... update specific data.............');
  final deleteDatabaseInstance = DataBaseDeleteCardItem.instance;
  var row = await deleteDatabaseInstance.deleteData();
  print(row);
}

cardDeleteFromFirebase(int id) async {
  print(
      '//////////////////////////////////// delete card item from firebase//////////////');
  // print(id);
  var collection = FirebaseFirestore.instance.collection('Add-To-Card');
  var snapshot = await collection.where('id', isEqualTo: id.toString()).get();
  snapshot.docs.first.reference.delete();
}
