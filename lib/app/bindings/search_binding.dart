import 'package:book_app/app/data/repository/book_repository.dart';
import 'package:book_app/app/modules/search/search_controller.dart';
import 'package:get/get.dart';

class SearchBinding extends Bindings {

  @override
  void dependencies() {
    Get.put(SearchController(repository: BookRepository()));
  }
}