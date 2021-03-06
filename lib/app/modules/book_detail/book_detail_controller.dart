import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/model/rating.dart';
import 'package:book_app/app/data/repository/book_repository.dart';
import 'package:book_app/app/modules/dialog/add_book_week_bottomsheet.dart';
import 'package:book_app/app/modules/dialog/basic_dialog.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:book_app/app/modules/widgets_global/snackbar.dart';
import 'package:book_app/app/translations/app_translations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../profil/user_controller.dart';

class BookDetailController extends GetxController {
  static BookDetailController get to => Get.find();

  final BookRepository repository;
  final String bio;
  BookDetailController(
      {@required this.repository, this.book, this.bookId, this.bio})
      : assert(repository != null);

  Book book;
  final String bookId;
  List<Rating> listRatings = [];
  int _nbRatings = 0;
  double _note = 0.0;

  String errorMessage = "";
  bool loadData = true;
  bool haveAlreadyBook = false;

  @override
  void onInit() {
    super.onInit();
    if (book == null && bookId != null)
      _getBook();
    else if (book == null && bookId == null) {
      _errorLoad();
      return;
    } else {
      loadData = false;
      update();
    }
    _getRatings();
  }

  _getBook() async {
    print("GET BOOK");
    book = await repository.getBook(bookId);
    if (book != null) {
      loadData = false;
      book.setNote(_note);
      book.setNbRatings(_nbRatings);
      if (UserController.to.isBookSeller)
        haveAlreadyBook = UserController.to.bookseller.listBooksWeek
                .firstWhere((item) => item.id == book.id, orElse: () => null) !=
            null;
      else
        haveAlreadyBook = !UserController.to.isAuth ? false : UserController.to.user.listBooksRead
                .firstWhere((item) => item.id == book.id, orElse: () => null) !=
            null;
    } else
      _errorLoad();
    update();
  }

  _errorLoad() {
    errorMessage = AppTranslation.serverError.tr;
    update();
  }

  _getRatings() async {
    if ((book != null && book.id != null) || bookId != null) {
      if (UserController.to.isBookSeller)
        haveAlreadyBook = UserController.to.bookseller.listBooksWeek.firstWhere(
                (item) => item.id == (book != null ? book.id : bookId),
                orElse: () => null) !=
            null;
      else
        haveAlreadyBook = !UserController.to.isAuth ? false : UserController.to.user.listBooksRead.firstWhere(
                (item) => item.id == (book != null ? book.id : bookId),
                orElse: () => null) !=
            null;
      Map<String, dynamic> map =
          await repository.getRatingsByBook(bookId ?? book.id);
      _note = map["note"] != null ? map["note"].toDouble() : 0.0;
      _nbRatings = map["nbRatings"] ?? 0;
      if (book != null && book.id != null) {
        book.setNote(_note);
        book.setNbRatings(_nbRatings);
      }
      if (_nbRatings > 0) {
        List<Rating> ratings = [];
        map["ratings"]
            .forEach((rating) => ratings.add(Rating.fromJson(rating)));
        listRatings = ratings;
      }
      update();
    }
  }

  handleAddOrDeleteBook() {
    if (haveAlreadyBook) {
      if (UserController.to.isBookSeller)
        print("delete book week");
      else
        BasicDialog.showConfirmDeleteBookDialog(
            onConfirm: () => _deleteBookFromGallery());
    } else {
      if (UserController.to.isBookSeller) {
        print("add book week");
        Get.bottomSheet(
            AddBookWeekBottomSheet(onConfirm: (desc) => _addBookWeek(desc)));
      } else
        BasicDialog.showConfirmFinishBookDialog(
            onConfirm: () => _addBookToGallery());
    }
  }

  _addBookWeek(String desc) async {
    if (UserController.to.canAddBookWeek) {
      var res = await UserController.to.addBookWeek(book, desc);
      if (res) {
        UserController.to.isAddBookWeek(false);
        CustomSnackbar.snackbar(AppTranslation.bookHasAddBookWeek.tr);
      } else
        CustomSnackbar.snackbar(AppTranslation.alreadyAddBook.tr);
      haveAlreadyBook = true;
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

  _addBookToGallery() async {
    var res = await UserController.to.addBookToGallery(book);
    if (res)
      CustomSnackbar.snackbar(AppTranslation.bookHasAddToGallery.tr);
    else
      CustomSnackbar.snackbar(AppTranslation.serverError.tr);
    haveAlreadyBook = true;
    update();
  }

  _deleteBookFromGallery() async {
    var res = await UserController.to.deleteBookFromGallery(book);
    if (res)
      CustomSnackbar.snackbar(AppTranslation.bookHasDeleteFromGallery.tr);
    else
      CustomSnackbar.snackbar(AppTranslation.alreadyDeleteBook.tr);
    haveAlreadyBook = false;
    update();
  }
}
