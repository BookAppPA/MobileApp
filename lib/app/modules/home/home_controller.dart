import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/repository/book_repository.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:meta/meta.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  final BookRepository repository;
  HomeController({@required this.repository}) : assert(repository != null);

  DateTime _dateServer;
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
    //_loadData = false;
    //update(["appbar"]);
   // await Jiffy.locale("fr");
    //var user = UserController.to.user;
    //await _initDateServer();
   // repository.listenCallbackNotification();
    // Run SwipeController
    //_loadData = true;
    //update(["appbar"]);
  }

  /*_initDateServer() async {
    _dateServer = await getDateServer();
    Constant.today = _dateServer;
  }*/
}
