import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/repository/book_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {

  static SearchController get to => Get.find();

  SearchController({@required this.repository}) : assert(repository != null);

  final BookRepository repository;
  final TextEditingController _editTextController = TextEditingController();
  TextEditingController get editTextController => this._editTextController;

  String get _searchText => _editTextController.text.trim();

  bool get _checkValid => _searchText.length >= 3 && _searchText.length <= 50;

  RxList<Book> books = <Book>[].obs;

  search() async {
    Get.focusScope.unfocus();
    print("$_searchText");
    if (_checkValid) {
      books.value = await repository.searchBook(_searchText);
    }
  }

  cancelSearch() {
    Get.focusScope.unfocus();
    _editTextController.clear();
  }
}
