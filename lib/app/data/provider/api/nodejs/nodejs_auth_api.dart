import 'dart:convert';
import 'package:book_app/app/data/model/user.dart';
import 'package:book_app/app/utils/constant/url_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class NodeJSAuthAPI {
  Future<UserModel> login(String email, String password) async {
    try {
      http.Response resp = await http.post(Uri.parse(UrlAPI.login),
          body: {"email": email, "password": password});
      if (resp.statusCode == 200) {
        print("response: ${resp.body}");
        Map<String, dynamic> map = json.decode(resp.body);
        try {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);
          return UserModel.fromJson(map);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            print('No user found for that email.');
          } else if (e.code == 'wrong-password') {
            print('Wrong password provided for that user.');
          }
          return null;
        }
      } else {
        print("error get http call");
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
      if (resp.statusCode == 200) {
        print("response: ${resp.body}");
        Map<String, dynamic> map = json.decode(resp.body);
        return UserModel.fromJson(map);
      } else {
        print("error get http call");
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

  Future<DateTime> server(String email, String password) async {
    try {
      http.Response resp = await http.get(Uri.parse(UrlAPI.login));
      if (resp.statusCode == 200) {
        print("response: ${resp.body}");
        Map<String, dynamic> map = json.decode(resp.body);
        print("time: ${map['timestamp']}");
        return DateTime.now();
      } else {
        print("error get http call");
        return DateTime.now();
      }
    } catch (e) {
      print(e.toString());
      return DateTime.now();
    }
  }
}
