import 'package:book_app/app/data/model/bookseller.dart';
import 'package:book_app/app/data/repository/bookseller_repository.dart';
import 'package:book_app/app/modules/bookseller/bookseller_detail/bookseller_detail_controller.dart';
import 'package:get/get.dart';

class BookSellerDetailBinding extends Bindings {

  @override
  void dependencies() {
    final BookSeller bookSeller = Get.arguments as BookSeller;
    Get.put(BookSellerDetailController(repository: BookSellerRepository(), bookSeller: bookSeller));
  }

}