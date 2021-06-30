import 'package:book_app/app/data/repository/book_repository.dart';
import 'package:book_app/app/modules/search/searchCategories/search_categories_controller.dart';
import 'package:get/get.dart';

class SearchCategoriesBinding extends Bindings {
  @override
  void dependencies() {
    final String category = Get.arguments as String;
    Get.put(SearchCategoriesController(repository: BookRepository(), category: category));

  }
}