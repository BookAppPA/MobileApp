import 'dart:convert';
import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/model/rating.dart';
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
        print("error get http getUserById --> ${resp.body}");
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
        print("error get http updateUser --> ${resp.body}");
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
        print("error get http getPopularBooks --> ${resp.body}");
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<Book> getBook(String bookID) async {
    try {
      var token = await FirebaseAuth.instance.currentUser.getIdToken();
      http.Response resp = await http.get(Uri.parse(UrlAPI.bookDetail),
          headers: {"authorization": "Bearer $token", "bookid": bookID});
      if (resp.statusCode == 200) {
        var book = json.decode(resp.body);
        return Book.fromJson(book);
      } else {
        print("error get http getBook --> ${resp.body}");
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<Book>> searchBook(String search) async {
    try {
      var token = await FirebaseAuth.instance.currentUser.getIdToken();
      http.Response resp = await http.get(Uri.parse(UrlAPI.searchBook),
          headers: {"authorization": "Bearer $token", "search": search});
      if (resp.statusCode == 200) {
        var listBooks = json.decode(resp.body);
        List<Book> books = [];
        listBooks.forEach((book) => books.add(Book.fromJson(book)));
        return books;
      } else {
        print("error get http searchBook --> ${resp.body}");
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  Future<Map<String, dynamic>> getRatingsByBook(String bookID) async {
    try {
      var token = await FirebaseAuth.instance.currentUser.getIdToken();
      http.Response resp = await http.get(Uri.parse(UrlAPI.ratingByBook),
          headers: {"authorization": "Bearer $token", "bookid": bookID});
      if (resp.statusCode == 200) {
        return json.decode(resp.body);
      } else {
        print("error get http getRatingsByBook --> ${resp.body}");
        return {};
      }
    } catch (e) {
      print(e.toString());
      return {};
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
        print("error get http getUserListBook --> ${resp.body}");
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<Rating>> getLastRatings(
      String idUser, List<Book> listBooks) async {
    try {
      String list = "";
      listBooks.forEach((book) {
        list += (book.id + "/");
      });
      list = list.substring(0, list.length - 1);
      print(list);

      var token = await FirebaseAuth.instance.currentUser.getIdToken();
      http.Response resp = await http.get(Uri.parse(UrlAPI.userListRatings),
          headers: {
            "authorization": "Bearer $token",
            "uid": idUser,
            "listbooks": list
          });
      if (resp.statusCode == 200) {
        var listRatings = json.decode(resp.body);
        List<Rating> ratings = [];
        listRatings.forEach((rating) => ratings.add(Rating.fromJson(rating)));
        return ratings;
      } else {
        print("error get http getLastRatings --> ${resp.body}");
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<bool> addBookToGallery(String idUser, Book book) async {
    try {
      var token = await FirebaseAuth.instance.currentUser.getIdToken();
      http.Response resp = await http.post(Uri.parse(UrlAPI.addBookToGallery),
          headers: {"authorization": "Bearer $token", "uid": idUser},
          body: {"bookid": book.id});
      if (resp.statusCode == 200) {
        return true;
      } else {
        print("error get http addBookToGallery --> ${resp.body}");
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> deleteBookFromGallery(String idUser, Book book) async {
    try {
      var token = await FirebaseAuth.instance.currentUser.getIdToken();
      http.Response resp = await http.post(Uri.parse(UrlAPI.deleteBookFromGallery),
          headers: {"authorization": "Bearer $token", "uid": idUser},
          body: {"bookid": book.id});
      if (resp.statusCode == 200) {
        return true;
      } else {
        print("error get http deleteBookFromGallery --> ${resp.body}");
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

}
