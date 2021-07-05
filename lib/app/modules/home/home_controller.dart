import 'dart:math';

import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/model/lastBookWeek.dart';
import 'package:book_app/app/data/repository/book_repository.dart';
import 'package:book_app/app/data/repository/bookseller_repository.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  final BookRepository repository;
  final BookSellerRepository repositorySeller;
  HomeController({@required this.repository, @required this.repositorySeller})
      : assert(repository != null && repositorySeller != null);

  bool _loadData = true;
  bool get loadData => this._loadData;

  List<Book> _listPopularBooks = [];
  List<Book> get listPopularBooks => this._listPopularBooks;

  List<Book> _listRecommendationBooks = [];
  List<Book> get listRecommendationBooks => this._listRecommendationBooks;

  List<LastBookWeek> _listLastBooksWeek = [];
  List<LastBookWeek> get listLastBooksWeek => this._listLastBooksWeek;

  bool _hasDataPopularBooks = false;
  get hasDataPopularBooks => this._hasDataPopularBooks;

  bool _hasDataRecommendationBooks = false;
  get hasDataRecommendationBooks => this._hasDataRecommendationBooks;

  @override
  void onInit() {
    super.onInit();
    _getLastBooksWeek();
    _getPopularBooks();
    if (!UserController.to.isBookSeller) _getRecommendationBooks();
  }

  _getLastBooksWeek() async {
    var res = await repositorySeller.getLastBooksWeek();
    print("books popular => $res");
    _listLastBooksWeek = res;
    update();
  }

  _getPopularBooks() async {
    var res = await repository.getPopularBooks();
    print("books popular => $res");
    _listPopularBooks = res;
    _hasDataPopularBooks = true;
    update();
  }

  _getRecommendationBooks() async {
    int mlID = 1;
    if (UserController.to.isAuth)
      mlID = UserController.to.user.recommendationID;
    else {
      var rnd = Random();
      mlID = rnd.nextInt(25000);
    }
    var res = await repository
        .getRecommendationBooks(mlID);
    print("recommended books => $res");
    _listRecommendationBooks = res;
    _hasDataRecommendationBooks = res.length > 0;
    update();
  }

  showMoreBooks() => 
    Get.toNamed(Routes.ML, arguments: _listRecommendationBooks);
}
