import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/repository/book_repository.dart';
import 'package:book_app/app/modules/dialog/add_book_week_bottomsheet.dart';
import 'package:book_app/app/modules/dialog/basic_dialog.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:book_app/app/modules/widgets_global/snackbar.dart';
import 'package:book_app/app/translations/app_translations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchCategoriesController extends GetxController {
  static SearchCategoriesController get to => Get.find();

  final String category;
  SearchCategoriesController({@required this.repository, this.category: ''}) : assert(repository != null);

  final BookRepository repository;

  bool searching = true;
  List<Book> booksByCategories = [];

  @override
    void onInit() {
      super.onInit();
      _getResultsCategories();
    }

  _getResultsCategories() async {
    booksByCategories = await repository.searchBooksByCategories(category);
    searching = false;
    update();
  }

  _addBook(Book book) async {
    var res = await UserController.to.addBookToGallery(book);
    if (res)
      CustomSnackbar.snackbar(AppTranslation.bookHasAddToGallery.tr);
    else
      CustomSnackbar.snackbar(AppTranslation.serverError.tr);
    update();
  }

   _deleteBook(Book book) async {
    var res = await UserController.to.deleteBookFromGallery(book);
    if (res)
      CustomSnackbar.snackbar(AppTranslation.bookHasDeleteFromGallery.tr);
    else
      CustomSnackbar.snackbar(AppTranslation.alreadyDeleteBook.tr);
    update();
  }

  addBookToGallery(Book book) {
    if (UserController.to.isBookSeller) {
      print("add book week");
      Get.bottomSheet(AddBookWeekBottomSheet(
          onConfirm: (desc) => _addBookWeek(book, desc)));
    } else
      BasicDialog.showConfirmFinishBookDialog(onConfirm: () => _addBook(book));
  }

  deleteBookFromGallery(Book book) {
    if (UserController.to.isBookSeller)
      print("delete book week");
    else
      BasicDialog.showConfirmDeleteBookDialog(
          onConfirm: () => _deleteBook(book));
  }

  _addBookWeek(Book book, String desc) async {
    if (UserController.to.canAddBookWeek) {
      var res = await UserController.to.addBookWeek(book, desc);
      if (res) {
        UserController.to.isAddBookWeek(false);
        CustomSnackbar.snackbar(AppTranslation.bookHasAddBookWeek.tr);
      } else
        CustomSnackbar.snackbar(AppTranslation.alreadyAddBook.tr);
      update();
    } else {
      Future.delayed(
        Duration(milliseconds: 500),
        () => CustomSnackbar.snackbar(
            AppTranslation.mustWaitToAddNewBookWeek.tr,
            shortDuration: false),
      );
    }
  }

}