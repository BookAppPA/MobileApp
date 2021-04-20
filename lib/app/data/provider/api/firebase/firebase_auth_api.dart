import 'package:book_app/app/data/provider/api/firebase/custom_exception.dart';
import 'package:book_app/app/translations/app_translations.dart';
import 'package:book_app/app/utils/constant/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseAuthAPI {
  Stream<User> get onAuthStateChanged =>
      FirebaseAuth.instance.authStateChanges();

  User getCurrentUser() {
    try {
      return FirebaseAuth.instance.currentUser;
    } catch (_) {
      print("ERROR: Firebase Auth API: GetCurrentUser()");
      return null;
    }
  }

  /*
  Future<AuthResult> signIn(String email, String password) async {
    try {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } catch(err) {
      String msg = "";
      switch (err.code) {
        case "ERROR_WRONG_PASSWORD":
          msg = Localization.errorAPIwrongPassword.tr;
          break;
        case "ERROR_INVALID_EMAIL":
          msg = Localization.errorAPIinvalidEmail.tr;
          break;
        case "ERROR_USER_NOT_FOUND":
          msg = Localization.errorAPIuserNotFound.tr;
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          msg = Localization.errorAPImanyRequests.tr;
          break;
        case "ERROR_NETWORK_REQUEST_FAILED":
          msg = Localization.errorAPInetwork.tr;
          break; 
        default:
          msg = Localization.errorAPIdefault.tr;
          break; 
      }
      print(err);
      throw CustomException(code: err.code, message: msg);
    }
    
  }

  Future<AuthResult> signUp(String email, String password) async {
    try {
      return await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } catch (err) {
      String msg = "";
      switch (err.code) {
        case "ERROR_WEAK_PASSWORD":
          msg = Localization.errorAPIweakPassword.tr;
          break;
        case "ERROR_INVALID_EMAIL":
          msg = Localization.errorAPIinvalidEmail.tr;
          break;
        case "ERROR_EMAIL_ALREADY_IN_USE":
          msg = Localization.errorAPIemailAlreadyUse.tr;
          break;
        case "ERROR_NETWORK_REQUEST_FAILED":
          msg = Localization.errorAPInetwork.tr;
          break; 
        default:
          msg = Localization.errorAPIdefault.tr;
          break; 
      }
      print(err);
      throw CustomException(code: err.code, message: msg);
    }
  }*/

  signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (err) {
      String msg = "";
      switch (err) {
        case "ERROR_NETWORK_REQUEST_FAILED":
          msg = AppTranslation.errorAPInetwork.tr;
          break;
        default:
          msg = AppTranslation.errorAPIdefault.tr;
          break;
      }
      throw CustomException(code: err.code, message: msg);
    }
  }
}
