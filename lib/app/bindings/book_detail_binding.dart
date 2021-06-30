import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/repository/book_repository.dart';
import 'package:book_app/app/modules/book_detail/book_detail_controller.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:get/get.dart';

class BookDetailBinding extends Bindings {

  void eventAnalytics(book) async {
    print('avant');
    await UserController.analytics.logViewItem(
      itemId: book.id,
      itemName: book.title,
      itemCategory: book.authors != null ? book.authors.first : '',
      itemLocationId: UserController.to.user.id,
    );
    print('apres');
  }

  @override
  void dependencies() {
    final Book book = Get.arguments as Book;
    Get.delete<BookDetailController>();
    if (book.title != null){
      eventAnalytics(book);
      Get.create(() => BookDetailController(repository: BookRepository(), book: book), permanent: false);
    } 
    else if (book.id != null)
      Get.create(() => BookDetailController(repository: BookRepository(), bookId: book.id, bio: book.description ?? ''),permanent: false);
    else
      Get.put(BookDetailController(repository: BookRepository()));
  }

}