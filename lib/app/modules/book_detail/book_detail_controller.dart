import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/model/rating.dart';
import 'package:book_app/app/data/repository/book_repository.dart';
import 'package:book_app/app/modules/dialog/basic_dialog.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:book_app/app/modules/widgets_global/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookDetailController extends GetxController {
  static BookDetailController get to => Get.find();

  final BookRepository repository;
  BookDetailController({@required this.repository, this.book, this.bookId})
      : assert(repository != null);

  Book book;
  final String bookId;
  List<Rating> listRatings = [];
  int _nbRatings = 0;
  int _note = 0;

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
      haveAlreadyBook = UserController.to.user.listBooksRead
              .firstWhere((item) => item.id == book.id, orElse: () => null) !=
          null;
    } else
      _errorLoad();
    update();
  }

  _errorLoad() {
    errorMessage = "Erreur du serveur...";
    update();
  }

  _getRatings() async {
    if ((book != null && book.id != null) || bookId != null) {
      haveAlreadyBook = UserController.to.user.listBooksRead
              .firstWhere((item) => item.id == book.id, orElse: () => null) !=
          null;
      Map<String, dynamic> map =
          await repository.getRatingsByBook(bookId ?? book.id);
      _note = map["note"] ?? 0;
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
    if (haveAlreadyBook)
      BasicDialog.showConfirmDeleteBookDialog(
          onConfirm: () => _deleteBookFromGallery());
    else
      BasicDialog.showConfirmFinishBookDialog(
          onConfirm: () => _addBookToGallery());
  }

  _addBookToGallery() async {
    var res = await UserController.to.addBookToGallery(book);
    if (res)
      CustomSnackbar.snackbar("Ce livre à été ajouté a votre bibliothèque");
    else
      CustomSnackbar.snackbar("Vous avez déjà ajouté ce livre");
    haveAlreadyBook = true;
    update();
  }

  _deleteBookFromGallery() async {
    var res = await UserController.to.deleteBookFromGallery(book);
    if (res)
      CustomSnackbar.snackbar("Ce livre à été supprimé de votre bibliothèque");
    else
      CustomSnackbar.snackbar("Vous avez déjà supprimé ce livre");
    haveAlreadyBook = false;
    update();
  }
}
