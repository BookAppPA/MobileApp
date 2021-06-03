import 'package:book_app/app/data/model/book.dart';
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
  set user(value) => this._user = value;

  Map<String, dynamic> _userData = {};
  Map<String, dynamic> get userData => this._userData;

  bool _loadingPicture = false;
  bool get loadingPicture => this._loadingPicture;

  updateBio(String bio) {
    _user.bio = bio;
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

}
