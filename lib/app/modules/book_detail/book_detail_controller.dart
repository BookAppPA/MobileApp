import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/model/rating.dart';
import 'package:book_app/app/data/repository/book_repository.dart';
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

  @override
  void onInit() {
    super.onInit();
    if (book == null && bookId != null)
      _getBook();
    else if (book == null && bookId == null) {
      _errorLoad();
      return;
    }
    else {
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
    }
    else _errorLoad();
    update();
  }

  _errorLoad() {
    errorMessage = "Erreur du serveur...";
    update();
  }

  _getRatings() async {
    if ((book != null && book.id != null) || bookId != null) {
        Map<String, dynamic> map = await repository.getRatingsByBook(bookId ?? book.id);
        _note = map["note"];
        _nbRatings = map["nbRatings"];
        if (book != null && book.id != null) {
          book.setNote(_note);
          book.setNbRatings(_nbRatings);
        }
        List<Rating> ratings = [];
        map["ratings"].forEach((rating) => ratings.add(Rating.fromJson(rating)));
        listRatings = ratings;
        update();
    }
  }
}
