import 'dart:convert';
import 'package:book_app/app/data/model/bookseller.dart';
import 'package:book_app/app/data/model/company.dart';
import 'package:book_app/app/data/model/user.dart';
import 'package:book_app/app/modules/widgets_global/snackbar.dart';
import 'package:book_app/app/utils/constant/url_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class NodeJSAuthAPI {
  Future<dynamic> login(String email, String password) async {
    try {
      http.Response resp = await http.post(Uri.parse(UrlAPI.login),
          body: {"email": email, "password": password});
      Map<String, dynamic> map = json.decode(resp.body);
      if (resp.statusCode == 200) {
        if (map["type"] == "user") {
          UserModel user = UserModel.fromJson(map["data"]);
          if (user.isBlocked) {
            CustomSnackbar.snackbar("Votre compte à été bloqué");
            return null;
          }
        }
        print("response: ${resp.body}");
        try {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);
          return map["type"] == "user" ? UserModel.fromJson(map["data"]) : BookSeller.fromJson(map["data"]);
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

  Future<BookSeller> signupBookSeller(
      BookSeller bookSeller, String password) async {
    try {
      http.Response resp = await http.post(Uri.parse(UrlAPI.signupBookSeller),
          headers: {"password": password}, body: bookSeller.toJson());
      Map<String, dynamic> map = json.decode(resp.body);
      if (resp.statusCode == 200) {
        print("response: ${resp.body}");
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: bookSeller.email, password: password);
          return BookSeller.fromJson(map);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            CustomSnackbar.snackbar("Cet email n'existe pas");
          } else if (e.code == 'wrong-password') {
            CustomSnackbar.snackbar("Mot de passe erroné");
          }
          return null;
        }
      } else {
        print("error get http signupBookSeller --> ${resp.body}");
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

  Future<Company> checkSiret(String siret) async {
    try {
      http.Response resp = await http.get(
        Uri.parse(UrlAPI.checkSiret),
        headers: {"siret": siret},
      );
      if (resp.statusCode == 200) {
        var map = json.decode(resp.body);
        return Company.fromJson(map);
      } else {
        print("error get checkSiret http --> ${resp.body}");
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Company> checkSiren(String siren) async {
    try {
      http.Response resp = await http.get(
        Uri.parse(UrlAPI.checkSiren),
        headers: {"siren": siren},
      );
      if (resp.statusCode == 200) {
        var map = json.decode(resp.body);
        return Company.fromJson(map);
      } else {
        print("error get checkSiren http --> ${resp.body}");
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
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
