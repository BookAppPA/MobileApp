import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/model/bookseller.dart';
import 'package:book_app/app/data/model/rating.dart';
import 'package:book_app/app/data/model/user.dart';
import 'package:book_app/app/data/repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();

  final UserRepository repository;
  UserController({@required this.repository}) : assert(repository != null);

  UserModel _user;
  UserModel get user => this._user;
  set user(value) {
    this._user = value;
    isBookSeller = false;
  }

  BookSeller _bookseller;
  BookSeller get bookseller => this._bookseller;
  set bookseller(value) {
    this._bookseller = value;
    isBookSeller = true;
  }

  bool isBookSeller = false;

  Map<String, dynamic> _userData = {};
  Map<String, dynamic> get userData => this._userData;

  bool _loadingPicture = false;
  bool get loadingPicture => this._loadingPicture;

  updateBio(String bio, bool isBookSeller) {
    if (isBookSeller)
      _bookseller.bio = bio;
    else
      _user.bio = bio;
    update();
  }

  updatePhone(String phone) {
    _bookseller.phone = phone;
    update();
  }

  updateOpenHours(Map hours) {
    _bookseller.openHour = hours;
    update();
  }

  isLoadingPicture(bool value) {
    _loadingPicture = value;
    update();
  }

  updatePicture(String urlPic) {
    _user.picture = urlPic;
    update();
  }

  setListBooks(List<Book> list) {
    _user.listBooksRead = list;
    update();
  }

  setLastRatings(List<Rating> ratings) {
    _user.listLastRatings = ratings;
    update();
  }

  Future<bool> addBookToGallery(Book book) async {
    if (user.listBooksRead.firstWhere((item) => item.id == book.id, orElse: () => null) != null)
      return false;
    var res = await repository.addBookToGallery(_user.id, book);
    print("res add book --> $res");
    if (res) {
      _user.listBooksRead.insert(0, book);
      update();
    }
    return res;
  }

  Future<bool> deleteBookFromGallery(Book book) async {
    if (user.listBooksRead.firstWhere((item) => item.id == book.id, orElse: () => null) == null)
      return false;
    var res = await repository.deleteBookFromGallery(_user.id, book);
    print("res add book --> $res");
    if (res) {
      var index = _user.listBooksRead.indexWhere((item) => item.id == book.id);
      if (index != -1) {
        _user.listBooksRead.removeAt(index);
        update();
        return true;
      } return false;
    }
    return res;
  }
  

}
