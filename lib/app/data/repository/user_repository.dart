import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/provider/api/firebase/firebase_firestore_api.dart';
import 'package:book_app/app/data/provider/api/firebase/firebase_messaging_api.dart';
import 'package:book_app/app/data/provider/api/firebase/firebase_storage_api.dart';
import 'package:book_app/app/data/provider/api/nodejs/nodejs_auth_api.dart';
import 'package:book_app/app/data/provider/api/nodejs/nodejs_bdd_api.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
 
  final NodeJSAuthAPI _authAPI = NodeJSAuthAPI();
  final NodeJSBddAPI _databaseAPI = NodeJSBddAPI();
  final FirebaseStorageAPI _firebaseStorageAPI = FirebaseStorageAPI();
  final FirebaseMessagingAPI _notificationAPI = FirebaseMessagingAPI();

  //Stream<User> get onAuthStateChanged => this._authAPI.onAuthStateChanged;

  getCurrentUser() {
    return _authAPI.getCurrentUser();
  }

  getUserById(String uid) async {
    return await _databaseAPI.getUserById(uid);
  }

  changeUserPicture(String uid, String path, String urlToDelete) async {
    String url = await _firebaseStorageAPI.uploadPicture(uid, path, urlToDelete);
    if (url != null)
      await _databaseAPI.updateUser(uid, {"picture": url});
    return url;
  }

  updateUser(String idUser, Map<String, String> data) {
    return _databaseAPI.updateUser(idUser, data);
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

  configurePushNotification(String idUser) async {
   // final token = await _notificationAPI.getToken();
   // UserController.to.user.pushToken = token;
   // _databaseAPI.setTokenNotifUser(idUser, token);
  }

  listenCallbackNotification() {
    //_notificationAPI.configureCallback();
  }

}