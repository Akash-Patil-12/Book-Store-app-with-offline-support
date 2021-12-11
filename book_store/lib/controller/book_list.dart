import 'package:book_store/model/book.dart';
import 'package:book_store/screen/service/home_service.dart';
import 'package:get/get.dart';

class BookListController extends GetxController {
  var bookList = <Book>[].obs;
  var checkBookList = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBookData();
    //  cardItemCount;
  }

  filterBookList(String value) {
    print('////////////demo//////////////');
    bookList.value = bookList
        .where((bookData) => bookData.title
            .toString()
            .toLowerCase()
            .contains(value.toLowerCase()))
        .toList();
  }

  sortListLowToHigh() {
    bookList.sort((a, b) => a.price.compareTo(b.price));
    print(bookList);
  }

  sortListHighToLow() {
    bookList.sort((b, a) => a.price.compareTo(b.price));
  }

  fetchBookData() async {
    var book = await readBookListFromJsonFile();
    bookList.value = book;
    if (book.isNotEmpty) {
      checkBookList.value = false;
    }
  }
}
