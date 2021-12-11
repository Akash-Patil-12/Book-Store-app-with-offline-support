import 'package:book_store/screen/service/home_service.dart';
import 'package:get/get.dart';

class CardCountController extends GetxController {
  var cardCount = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getCardCount();
    //  cardItemCount;
  }

  int get cardItemCount => cardCount.value;
  void getCardCount() async {
    print("4444444444444444444444444 controller 4444444444444444444");
    // Query collectionReference =
    //     FirebaseFirestore.instance.collection('Add-To-Card');
    // QuerySnapshot querySnapshot = await collectionReference.get();
    // cardCount.value = querySnapshot.docs.length;
    cardCount.value = await getCardItemLengthFromSql();
    print(cardCount);
  }
}
