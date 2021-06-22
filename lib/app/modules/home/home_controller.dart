import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/repository/book_repository.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  final BookRepository repository;
  HomeController({@required this.repository}) : assert(repository != null);

  bool _loadData = true;
  bool get loadData => this._loadData;

  List<Book> _listPopularBooks = [];
  List<Book> get listPopularBooks => this._listPopularBooks;
  bool _hasDataPopularBooks = false;
  get hasDataPopularBooks => this._hasDataPopularBooks;

  @override
  void onInit() {
    super.onInit();
    _getPopularBooks();
  }

  _getPopularBooks() async {
    var res = await repository.getPopularBooks();
    print("books popular => $res");
    _listPopularBooks = res;
    _hasDataPopularBooks = true;
    update();
  }
}
