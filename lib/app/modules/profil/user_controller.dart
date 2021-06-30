import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/model/bookseller.dart';
import 'package:book_app/app/data/model/bookweek.dart';
import 'package:book_app/app/data/model/following.dart';
import 'package:book_app/app/data/model/rating.dart';
import 'package:book_app/app/data/model/user.dart';
import 'package:book_app/app/data/repository/user_repository.dart';
import 'package:book_app/app/modules/dialog/add_rating_bottomsheet.dart';
import 'package:book_app/app/modules/dialog/basic_dialog.dart';
import 'package:book_app/app/modules/widgets_global/snackbar.dart';
import 'package:book_app/app/utils/functions.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

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

  bool canAddBookWeek = false;

  static FirebaseAnalytics analytics = FirebaseAnalytics();

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

  isAddBookWeek(bool value) {
    canAddBookWeek = value;
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

  setListBooksWeek(List<BookWeek> list) {
    _bookseller.listBooksWeek = list;
    update();
  }

  setLastRatings(List<Rating> ratings) {
    _user.listLastRatings = ratings;
    update();
  }

  setListFollowers(List<UserModel> list) {
    _user.listFollowers = list;
    update();
  }

  setListFollowing(List<Following> list) {
    _user.listFollowing = list;
    update();
  }

  modifyNbFollowersOfUser(int index, int nb) {
    _user.listFollowers[index].nbFollowers = nb;
    update();
  }

  addFollowingUser(Following user) {
    _user.listFollowing.add(user);
    update();
  }

  deleteFollowingUser(UserModel user) {
    _user.listFollowing.removeWhere((item) => item.id == user.id);
    update();
  }

  Future<bool> addBookWeek(Book book, String desc) async {
    if (_bookseller.listBooksWeek
            .firstWhere((item) => item.id == book.id, orElse: () => null) !=
        null) return false;
    BookWeek bookWeek = BookWeek(
      id: book.id,
      author: book.authors.first,
      bio: desc,
      datePublished: book.publishedDate,
      title: book.title,
      picture: book.coverImage,
    );
    var res = await repository.addBookWeek(_bookseller.id, bookWeek);
    print("res add book week --> $res");
    if (res) {
      _bookseller.listBooksWeek.insert(0, bookWeek);
      var date = _bookseller.dateNextAddBookWeek == null
          ? await getDateServer()
          : _bookseller.dateNextAddBookWeek;
      var newDate = date.add(Duration(days: 7));
      await repository.updateUser(
          _bookseller.id, {"dateNextAddBookWeek": newDate.toIso8601String()},
          isBookSeller: true);
      _bookseller.dateNextAddBookWeek = newDate;
      update();
    }
    return res;
  }

  Future<bool> addBookToGallery(Book book) async {
    if (user.listBooksRead
            .firstWhere((item) => item.id == book.id, orElse: () => null) !=
        null) return false;
    var titleRating;
    var descRating;
    var noteRating;
    await Get.bottomSheet(
        AddRatingBottomSheet(
            title: "Ajouter un avis",
            onConfirm: (title, desc, note) {
              titleRating = title;
              descRating = desc;
              noteRating = note;
            },
            onCancel: () =>
                BasicDialog.showConfirmAddBookWithoutRating(onConfirm: () {
                  print("add without avis");
                  Get.back();
                })),
        isDismissible: false,
        enableDrag: false);
    if (titleRating != null) {
      print("rating: $titleRating, $descRating, $noteRating");
      var resAddRating = await repository.addRating(
          _user, book, titleRating, descRating, noteRating);
      if (resAddRating) {
        var res =
            await repository.addBookToGallery(_user.id, book, _user.nbBooks);
        print("res add book --> $res");
        if (res) {
          _user.listBooksRead.insert(0, book);
          _user.listLastRatings.add(Rating(
            bookAuthor: book.authors != null ? book.authors.first : "",
            bookId: book.id,
            bookImage: book.coverImage,
            bookPublished: book.publishedDate,
            bookTitle: book.title,
            message: descRating,
            note: noteRating,
            timestamp: DateTime.now(),
            title: titleRating,
            userId: _user.id,
            userImage: _user.picture,
            userName: _user.pseudo,
          ));
          _user.nbRatings++;
          _user.nbBooks++;
          update();
        }
        return res;
      } else
        return false;
    }
    var res = await repository.addBookToGallery(_user.id, book, _user.nbBooks);
    print("res add book --> $res");
    if (res) {
      _user.listBooksRead.insert(0, book);
      _user.nbBooks++;
      update();
    }
    return res;
  }

  Future<bool> deleteBookFromGallery(Book book) async {
    if (user.listBooksRead
            .firstWhere((item) => item.id == book.id, orElse: () => null) ==
        null) return false;
    var res =
        await repository.deleteBookFromGallery(_user.id, book, _user.nbBooks);
    print("res add book --> $res");
    if (res) {
      var index = _user.listBooksRead.indexWhere((item) => item.id == book.id);
      if (index != -1) {
        var book = _user.listBooksRead[index];
        var ratingIndex = _user.listLastRatings.indexWhere((item) => item.bookId == book.id);
        if (ratingIndex != -1) {
          _user.listLastRatings.removeAt(ratingIndex);
        }
        _user.listBooksRead.removeAt(index);
        _user.nbBooks--;
        _user.nbRatings--;
        update();
        return true;
      }
      return false;
    }
    return res;
  }

  updateRating(Rating rating) async {
    var titleRating;
    var descRating;
    var noteRating;
    await Get.bottomSheet(
        AddRatingBottomSheet(
          title: "Modifier votre avis",
          isAdd: false,
          preTitle: rating.title,
          preDesc: rating.message,
          preNote: rating.note,
          onConfirm: (title, desc, note) {
            titleRating = title;
            descRating = desc;
            noteRating = note;
          },
          onCancel: () => Get.back(),
        ),
      );
    if (titleRating == null)
      return;

    var title = titleRating ?? rating.title;
    var desc = descRating ?? rating.message;
    var note = noteRating ?? rating.note;

    var res = await repository.updateRating(
        _user.id, rating.bookId, rating.note, title, desc, note);
    if (res) {
      var index = _user.listLastRatings
          .indexWhere((item) => item.bookId == rating.bookId);
      if (index != -1) {
        _user.listLastRatings[index].title = title;
        _user.listLastRatings[index].message = desc;
        _user.listLastRatings[index].note = note;
        update();
        CustomSnackbar.snackbar("Avis modifié");
      }
    }
  }

  deleteRating(Rating rating) async {
    var res = await repository.deleteRating(
        _user.id, rating.bookId, _user.nbRatings, rating.note);
    if (res) {
      var index = _user.listLastRatings
          .indexWhere((item) => item.bookId == rating.bookId);
      if (index != -1) {
        _user.listLastRatings.removeAt(index);
        _user.nbRatings--;
        update();
        CustomSnackbar.snackbar("Avis supprimé");
      }
    } else
      CustomSnackbar.snackbar("Erreur du serveur...");
  }

  followUser(Following userToFollow) async {
    var res = await repository.followUser(_user, userToFollow);
    if (res) {
      _user.listFollowing.add(userToFollow);
      _user.nbFollowing++;
      update();
      return true;
    } else {
      CustomSnackbar.snackbar("Erreur de synchronisation...");
      return false;
    }
  }

  unFollowUser(Following userToFollow) async {
    var res = await repository.unFollowUser(_user, userToFollow);
    if (res) {
      _user.listFollowing.removeWhere((item) => item.id == userToFollow.id);
      _user.nbFollowing--;
      update();
      return true;
    } else {
      CustomSnackbar.snackbar("Erreur de synchronisation...");
      return false;
    }
  }
}
