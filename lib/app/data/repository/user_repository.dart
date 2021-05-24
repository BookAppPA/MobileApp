import 'package:book_app/app/data/provider/api/firebase/firebase_firestore_api.dart';
import 'package:book_app/app/data/provider/api/firebase/firebase_messaging_api.dart';
import 'package:book_app/app/data/provider/api/nodejs/nodejs_auth_api.dart';
import 'package:book_app/app/data/provider/api/nodejs/nodejs_bdd_api.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
 
  final NodeJSAuthAPI _authAPI = NodeJSAuthAPI();
  final NodeJSBddAPI _databaseAPI = NodeJSBddAPI();
  final FirebaseMessagingAPI _notificationAPI = FirebaseMessagingAPI();

  //Stream<User> get onAuthStateChanged => this._authAPI.onAuthStateChanged;

  getCurrentUser() {
    return _authAPI.getCurrentUser();
  }

  getUserById(String uid) async {
    return await _databaseAPI.getUserById(uid);
  }

  /*initUser(String idUser, String phoneNumber, String email) async {
    await _databaseAPI.initUser(idUser, phoneNumber, email);
  }

  updateUser(String idUser, Map<String, dynamic> data) {
    _databaseAPI.updateUser(idUser, data);
  }*/

  configurePushNotification(String idUser) async {
   // final token = await _notificationAPI.getToken();
   // UserController.to.user.pushToken = token;
   // _databaseAPI.setTokenNotifUser(idUser, token);
  }

  listenCallbackNotification() {
    //_notificationAPI.configureCallback();
  }

}