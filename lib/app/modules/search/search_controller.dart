import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/repository/book_repository.dart';
import 'package:book_app/app/modules/dialog/basic_dialog.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:book_app/app/modules/widgets_global/snackbar.dart';
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

  bool searching = false;
  List<Book> books = [];

  search() async {
    Get.focusScope.unfocus();
    print("$_searchText");
    if (_checkValid) {
      searching = true;
      update();
      books = await repository.searchBook(_searchText);
      searching = false;
      update();
    }
  }

  cancelSearch() {
    Get.focusScope.unfocus();
    _editTextController.clear();
  }

  addBookToGallery(Book book) {
    BasicDialog.showConfirmFinishBookDialog(onConfirm: () => _addBook(book));
  }

  _addBook(Book book) async {
    var res = await UserController.to.addBookToGallery(book);
    if (res)
      CustomSnackbar.snackbar("Ce livre à été ajouté a votre bibliothèque");
    else
      CustomSnackbar.snackbar("Vous avez déjà ajouté ce livre");
    update();
  }

  deleteBookFromGallery(Book book) {
    BasicDialog.showConfirmDeleteBookDialog(onConfirm: () => _deleteBook(book));
  }

  _deleteBook(Book book) async {
    var res = await UserController.to.deleteBookFromGallery(book);
    if (res)
      CustomSnackbar.snackbar("Ce livre à été supprimé de votre bibliothèque");
    else
      CustomSnackbar.snackbar("Vous avez déjà supprimé ce livre");
    update();
  }
}
