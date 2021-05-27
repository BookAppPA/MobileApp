import 'dart:convert';
import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/model/user.dart';
import 'package:book_app/app/modules/widgets_global/snackbar.dart';
import 'package:book_app/app/utils/constant/url_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class NodeJSBddAPI {
  Future<UserModel> getUserById(String uid) async {
    try {
      var token = await FirebaseAuth.instance.currentUser.getIdToken();
      http.Response resp = await http.get(
        Uri.parse(UrlAPI.getUserById),
        headers: {"authorization": "Bearer $token", "uid": uid},
      );
      if (resp.statusCode == 200) {
        Map<String, dynamic> map = json.decode(resp.body);
        return UserModel.fromJson(map);
      } else {
        print("error get http call --> ${resp.body}");
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> updateUser(String idUser, Map<String, String> data) async {
    try {
      var token = await FirebaseAuth.instance.currentUser.getIdToken();
      http.Response resp = await http.post(Uri.parse(UrlAPI.updateUser),
          headers: {"authorization": "Bearer $token", "uid": idUser},
          body: data);
      if (resp.statusCode == 200) {
        return true;
      } else {
        print("error get http call --> ${resp.body}");
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<List<Book>> getPopularBooks() async {
    try {
      // var token = await FirebaseAuth.instance.currentUser.getIdToken();
      http.Response resp = await http.get(Uri.parse(UrlAPI.popularBooks));
      if (resp.statusCode == 200) {
        var listBooks = json.decode(resp.body);
        List<Book> books = [];
        listBooks.forEach((book) => books.add(Book.fromJson(book)));
        return books;
      } else {
        print("error get http call --> ${resp.body}");
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<Book>> getUserListBook(String idUser) async {
    try {
      var token = await FirebaseAuth.instance.currentUser.getIdToken();
      http.Response resp = await http.get(Uri.parse(UrlAPI.userListBooks),
          headers: {"authorization": "Bearer $token", "uid": idUser});
      if (resp.statusCode == 200) {
        var listBooks = json.decode(resp.body);
        List<Book> books = [];
        listBooks.forEach((book) => books.add(Book.fromJson(book)));
        return books;
      } else {
        print("error get http call --> ${resp.body}");
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
