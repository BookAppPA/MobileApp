import 'package:book_app/app/data/provider/api/firebase/firebase_auth_api.dart';
import 'package:book_app/app/data/provider/api/firebase/firebase_firestore_api.dart';
import 'package:book_app/app/data/provider/api/firebase/firebase_messaging_api.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
 
  final FirebaseAuthAPI _authAPI = FirebaseAuthAPI();
  final FirebaseFirestoreAPI _databaseAPI = FirebaseFirestoreAPI();
  final FirebaseMessagingAPI _notificationAPI = FirebaseMessagingAPI();

  Stream<User> get onAuthStateChanged => this._authAPI.onAuthStateChanged;

  getCurrentUser() {
    return _authAPI.getCurrentUser();
  }

  getUser(String uid) async {
    return await _databaseAPI.getUser(uid);
  }

  initUser(String idUser, String phoneNumber, String email) async {
    await _databaseAPI.initUser(idUser, phoneNumber, email);
  }

  updateUser(String idUser, Map<String, dynamic> data) {
    _databaseAPI.updateUser(idUser, data);
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