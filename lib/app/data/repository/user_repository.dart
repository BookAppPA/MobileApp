import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/model/bookweek.dart';
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

  changeUserPicture(String uid, String path, String urlToDelete) async {
    String url = await _firebaseStorageAPI.uploadPicture(uid, path, urlToDelete);
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

  addBookToGallery(String idUser, Book book) async {
    return await _databaseAPI.addBookToGallery(idUser, book);
  }

  addBookWeek(String idUser, BookWeek bookWeek) async {
    return await _databaseAPI.addBookWeek(idUser, bookWeek);
  }

  deleteBookFromGallery(String idUser, Book book) async {
    return await _databaseAPI.deleteBookFromGallery(idUser, book);
  }

  followUser(UserModel user, UserModel userToFollow) async {
    return await _databaseAPI.followUser(user, userToFollow);
  }

  getListFollowers(String userId) async {
    return await _databaseAPI.getListFollowers(userId);
  }

  getListFollowing(String userId) async {
    return await _databaseAPI.getListFollowing(userId);
  }

  unFollowUser(UserModel user, UserModel userToFollow) async {
    return await _databaseAPI.unFollowUser(user, userToFollow);
  }

  isFollow(String idUser, String idUserToFollow) async {
    return await _databaseAPI.isFollow(idUser, idUserToFollow);
  }

}