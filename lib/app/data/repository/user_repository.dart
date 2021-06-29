import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/model/bookweek.dart';
import 'package:book_app/app/data/model/following.dart';
import 'package:book_app/app/data/model/user.dart';
import 'package:book_app/app/data/provider/api/firebase/firebase_storage_api.dart';
import 'package:book_app/app/data/provider/api/nodejs/nodejs_auth_api.dart';
import 'package:book_app/app/data/provider/api/nodejs/nodejs_bdd_api.dart';

class UserRepository {
 
  final NodeJSAuthAPI _authAPI = NodeJSAuthAPI();
  final NodeJSBddAPI _databaseAPI = NodeJSBddAPI();
  final FirebaseStorageAPI _firebaseStorageAPI = FirebaseStorageAPI();

  getCurrentUser() {
    return _authAPI.getCurrentUser();
  }

  getUserById(String uid) async {
    return await _databaseAPI.getUserById(uid);
  }

  changeUserPicture(String uid, String path) async {
    String url = await _firebaseStorageAPI.uploadPicture(uid, path);
    if (url != null)
      await _databaseAPI.updateUser(uid, {"picture": url}, false);
    return url;
  }

  updateUser(String idUser, Map<String, String> data, {bool isBookSeller: false}) async {
    return await _databaseAPI.updateUser(idUser, data, isBookSeller);
  }

  getUserListBook(String idUser) async {
    return await _databaseAPI.getUserListBook(idUser);
  }

  getLastRatings(String idUser, List<Book> listBooks) async {
    return await _databaseAPI.getLastRatings(idUser, listBooks);
  }

  addBookToGallery(String idUser, Book book, int nbBooks) async {
    return await _databaseAPI.addBookToGallery(idUser, book, nbBooks);
  }

  addBookWeek(String idUser, BookWeek bookWeek) async {
    return await _databaseAPI.addBookWeek(idUser, bookWeek);
  }

  addRating(UserModel user, Book book, String titleRating, String descRating, double noteRating) async {
    return await _databaseAPI.addRating(user, book, titleRating, descRating, noteRating);
  }

  updateRating(String userId, String bookId, double previousNote, String title, String desc, double note) async {
    return await _databaseAPI.updateRating(userId, bookId, previousNote, title, desc, note);
  }

  deleteRating(String userId, String bookId, int nbRatings, double note) async {
    return await _databaseAPI.deleteRating(userId, bookId, nbRatings, note);
  }

  deleteBookFromGallery(String idUser, Book book, int nbBooks) async {
    return await _databaseAPI.deleteBookFromGallery(idUser, book, nbBooks);
  }

  followUser(UserModel user, Following userToFollow) async {
    return await _databaseAPI.followUser(user, userToFollow);
  }

  getListFollowers(String userId) async {
    return await _databaseAPI.getListFollowers(userId);
  }

  getListFollowing(String userId) async {
    return await _databaseAPI.getListFollowing(userId);
  }

  unFollowUser(UserModel user, Following userToFollow) async {
    return await _databaseAPI.unFollowUser(user, userToFollow);
  }

  isFollow(String idUser, String idUserToFollow) async {
    return await _databaseAPI.isFollow(idUser, idUserToFollow);
  }

}