import 'dart:convert';
import 'package:book_app/app/data/model/user.dart';
import 'package:book_app/app/modules/widgets_global/snackbar.dart';
import 'package:book_app/app/utils/constant/url_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class NodeJSAuthAPI {
  Future<UserModel> login(String email, String password) async {
    try {
      http.Response resp = await http.post(Uri.parse(UrlAPI.login),
          body: {"email": email, "password": password});
      Map<String, dynamic> map = json.decode(resp.body);
      if (resp.statusCode == 200) {
        print("response: ${resp.body}");
        try {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);
          return UserModel.fromJson(map);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            CustomSnackbar.snackbar("Cet email n'existe pas");
          } else if (e.code == 'wrong-password') {
            CustomSnackbar.snackbar("Mot de passe erroné");
          }
          return null;
        }
      } else {
        if (map["code"] == "auth/user-not-found")
          CustomSnackbar.snackbar("Cet email n'existe pas");
        else if (map["code"] == 'auth/wrong-password')
          CustomSnackbar.snackbar("Mot de passe erroné");
        else
          CustomSnackbar.snackbar(map["message"]);
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<UserModel> signup(String pseudo, String email, String password) async {
    try {
      http.Response resp = await http.post(Uri.parse(UrlAPI.signup),
          body: {"pseudo": pseudo, "email": email, "password": password});
      Map<String, dynamic> map = json.decode(resp.body);
      if (resp.statusCode == 200) {
        print("response: ${resp.body}");
        return UserModel.fromJson(map);
      } else {
        print("error get http call");
        if (map["code"] == "auth/email-already-exists")
          // The email address is already in use by another account.
          CustomSnackbar.snackbar(
              "L'adresse email est déjà utilisé par un autre compte");
        else
          CustomSnackbar.snackbar(map["message"]);
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> logout() async {
    try {
      var token = await FirebaseAuth.instance.currentUser.getIdToken();
      http.Response resp = await http.post(Uri.parse(UrlAPI.logout),
          headers: {"authorization": "Bearer $token"});
      if (resp.statusCode == 200) {
        FirebaseAuth.instance.signOut();
        return true;
      } else {
        print("error get http call");
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  User getCurrentUser() {
    try {
      return FirebaseAuth.instance.currentUser;
    } catch (_) {
      print("ERROR: Firebase Auth API: GetCurrentUser()");
      return null;
    }
  }
}
