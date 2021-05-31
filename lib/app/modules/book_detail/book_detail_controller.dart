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
  int nbRatings = 0;

  String errorMessage = "";
  bool loadData = true;

  @override
  void onInit() {
    super.onInit();
    if (book == null && bookId != null)
      _getBook();
    else if (book == null && bookId == null)
      _errorLoad();
    else {
      loadData = false;
      update();
    }
    _getRatings();
  }

  _getBook() async {
    print("GET BOOK");
    book = await repository.getBook(bookId);
    if (book != null) loadData = false;
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
        book.setNote(map["note"]);
        book.setNbRatings(map["nbRatings"]);
        List<Rating> ratings = [];
        map["ratings"].forEach((rating) => ratings.add(Rating.fromJson(rating)));
        listRatings = ratings;
        update();
    }
  }
}
