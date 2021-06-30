import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/model/bookseller.dart';
import 'package:book_app/app/data/model/lastBookWeek.dart';
import 'package:book_app/app/data/repository/book_repository.dart';
import 'package:book_app/app/data/repository/bookseller_repository.dart';
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

  List<LastBookWeek> _listLastBooksWeek = [];
  List<LastBookWeek> get listLastBooksWeek => this._listLastBooksWeek;

  bool _hasDataPopularBooks = false;
  get hasDataPopularBooks => this._hasDataPopularBooks;

  @override
  void onInit() {
    super.onInit();
    _getLastBooksWeek();
    _getPopularBooks();
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
}
