import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/repository/book_repository.dart';
import 'package:book_app/app/modules/book_detail/book_detail_controller.dart';
import 'package:get/get.dart';

class BookDetailBinding extends Bindings {

  @override
  void dependencies() {
    final Book book = Get.arguments as Book;
    if (book.title != null)
      Get.put(BookDetailController(repository: BookRepository(), book: book));
    else if (book.id != null)
      Get.put(BookDetailController(repository: BookRepository(), bookId: book.id));
    else
      Get.put(BookDetailController(repository: BookRepository()));
  }

}