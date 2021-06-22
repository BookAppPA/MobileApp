import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/repository/book_repository.dart';
import 'package:book_app/app/modules/book_detail/book_detail_controller.dart';
import 'package:get/get.dart';

class BookDetailBinding extends Bindings {
  @override
  void dependencies() {
    final Book book = Get.arguments as Book;
    Get.delete<BookDetailController>();
    if (book.title != null)
      Get.create(() => BookDetailController(repository: BookRepository(), book: book), permanent: false);
    else if (book.id != null)
      Get.create(() => BookDetailController(repository: BookRepository(), bookId: book.id), permanent: false);
    else
      Get.put(BookDetailController(repository: BookRepository()));
  }

}