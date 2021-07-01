import 'dart:convert';
import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/model/bookseller.dart';
import 'package:book_app/app/data/model/bookweek.dart';
import 'package:book_app/app/data/model/following.dart';
import 'package:book_app/app/data/model/lastBookWeek.dart';
import 'package:book_app/app/data/model/rating.dart';
import 'package:book_app/app/data/model/user.dart';
import 'package:book_app/app/utils/constant/url_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class NodeJSBddAPI {
  Future<dynamic> getUserById(String uid) async {
    try {
      var t = await FirebaseAuth.instance.currentUser();
      var token = (await t.getIdToken()).token;
      http.Response resp = await http.get(
        Uri.parse(UrlAPI.getUserById + "/$uid"),
        headers: {"authorization": "Bearer $token"},
      );
      if (resp.statusCode == 200) {
        Map<String, dynamic> map = json.decode(resp.body);
        if (map["type"] == "user") return UserModel.fromJson(map["data"]);
        return BookSeller.fromJson(map["data"]);
      } else {
        print("error get http getUserById --> ${resp.body}");
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> updateUser(
      String idUser, Map<String, String> data, bool isBookSeller) async {
    try {
      var t = await FirebaseAuth.instance.currentUser();
      var token = (await t.getIdToken()).token;
      http.Response resp = await http.put(
          Uri.parse(UrlAPI.updateUser + "/$idUser"),
          headers: {
            "authorization": "Bearer $token",
            "isbookseller": isBookSeller.toString()
          },
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
      var t = await FirebaseAuth.instance.currentUser();
      var token = (await t.getIdToken()).token;
      http.Response resp = await http.get(
          Uri.parse(UrlAPI.bookDetail + "/$bookID"),
          headers: {"authorization": "Bearer $token"});
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

  Future<List<Book>> searchBooks(String search) async {
    try {
      var t = await FirebaseAuth.instance.currentUser();
      var token = (await t.getIdToken()).token;
      http.Response resp = await http.get(Uri.parse(UrlAPI.searchBook),
          headers: {"authorization": "Bearer $token", "search": Uri.encodeFull(search)});
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

  Future<List<Book>> searchBooksByCategories(String search) async {
    try {
      var t = await FirebaseAuth.instance.currentUser();
      var token = (await t.getIdToken()).token;
      print('URI ENCODE ${Uri.encodeComponent(search)}');
      http.Response resp = await http.get(Uri.parse(UrlAPI.searchBooksByCategories),
          headers: {"authorization": "Bearer $token", "search": Uri.encodeFull(search)});
      if (resp.statusCode == 200) {
        var listBooks = json.decode(resp.body);
        List<Book> books = [];
        listBooks.forEach((book) => books.add(Book.fromJson(book)));
        return books;
      } else {
        print("error get http searchBooksByCategories --> ${resp.body}");
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<Book>> searchBooksByAuthor(String search) async {
    try {
      var t = await FirebaseAuth.instance.currentUser();
      var token = (await t.getIdToken()).token;
      print('URI ENCODE ${Uri.encodeComponent(search)}');
      http.Response resp = await http.get(Uri.parse(UrlAPI.searchBooksByAuthor),
          headers: {"authorization": "Bearer $token", "search": Uri.encodeFull(search)});
      if (resp.statusCode == 200) {
        var listBooks = json.decode(resp.body);
        List<Book> books = [];
        listBooks.forEach((book) => books.add(Book.fromJson(book)));
        return books;
      } else {
        print("error get http searchBooksByAuthor --> ${resp.body}");
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<UserModel>> searchUsers(String search) async {
    try {
      var t = await FirebaseAuth.instance.currentUser();
      var token = (await t.getIdToken()).token;
      http.Response resp = await http.get(Uri.parse(UrlAPI.searchUsers),
          headers: {"authorization": "Bearer $token", "search": Uri.encodeFull(search)});
      if (resp.statusCode == 200) {
        var listUsers = json.decode(resp.body);
        List<UserModel> users = [];
        listUsers.forEach((user) => users.add(UserModel.fromJson(user)));
        return users;
      } else {
        print("error get http searchUsers --> ${resp.body}");
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Map<String, dynamic>> getRatingsByBook(String bookID) async {
    try {
      var t = await FirebaseAuth.instance.currentUser();
      var token = (await t.getIdToken()).token;
      http.Response resp = await http.get(
          Uri.parse(UrlAPI.ratingByBook + "/$bookID"),
          headers: {"authorization": "Bearer $token"});
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
      var t = await FirebaseAuth.instance.currentUser();
      var token = (await t.getIdToken()).token;
      http.Response resp = await http.get(
          Uri.parse(UrlAPI.userListBooks + "/$idUser"),
          headers: {"authorization": "Bearer $token"});
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

      var t = await FirebaseAuth.instance.currentUser();
      var token = (await t.getIdToken()).token;
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

  Future<bool> addBookToGallery(String idUser, Book book, int nbBooks) async {
    try {
      var t = await FirebaseAuth.instance.currentUser();
      var token = (await t.getIdToken()).token;
      http.Response resp = await http.post(Uri.parse(UrlAPI.addBookToGallery),
          headers: {"authorization": "Bearer $token", "uid": idUser},
          body: {"bookid": book.id, "nbBook": nbBooks.toString()});
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

  Future<bool> addBookWeek(String idUser, BookWeek book) async {
    try {
      var t = await FirebaseAuth.instance.currentUser();
      var token = (await t.getIdToken()).token;
      http.Response resp = await http.post(Uri.parse(UrlAPI.addBookWeek),
          headers: {"authorization": "Bearer $token", "uid": idUser},
          body: book.toJson());
      if (resp.statusCode == 200) {
        return true;
      } else {
        print("error get http addBookWeek --> ${resp.body}");
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> addRating(
      UserModel user, Book book, String title, String desc, double note) async {
    try {
      var t = await FirebaseAuth.instance.currentUser();
      var token = (await t.getIdToken()).token;
      http.Response resp = await http
          .post(Uri.parse(UrlAPI.addRating + "/${book.id}"), headers: {
        "authorization": "Bearer $token",
        "uid": user.id,
      }, body: {
        "user_nbRatings": user.nbRatings.toString(),
        "rating": json.encode({
          "book_author": book.authors != null ? book.authors.first : "",
          "book_id": book.id,
          "book_pic": book.coverImage,
          "book_published": book.publishedDate,
          "book_title": book.title,
          "message": desc,
          "note": note,
          "title": title,
          "user_id": user.id,
          "user_pic": user.picture,
          "username": user.pseudo,
        })
      });
      if (resp.statusCode == 200) {
        return true;
      } else {
        print("error get http addRating --> ${resp.body}");
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateRating(String userId, String bookId, double previousNote,
      String title, String desc, double note) async {
    try {
      var t = await FirebaseAuth.instance.currentUser();
      var token = (await t.getIdToken()).token;
      http.Response resp =
          await http.put(Uri.parse(UrlAPI.modifyRating + "/$bookId"), headers: {
        "authorization": "Bearer $token",
        "uid": userId
      }, body: {
        "previous_note": previousNote.toString(),
        "rating": json.encode({
          "title": title,
          "message": desc,
          "note": note,
        })
      });
      if (resp.statusCode == 200) {
        return true;
      } else {
        print("error get http updateRating --> ${resp.body}");
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> deleteRating(
      String userId, String bookId, int nbRating, double note) async {
    try {
      var t = await FirebaseAuth.instance.currentUser();
      var token = (await t.getIdToken()).token;
      http.Response resp = await http
          .post(Uri.parse(UrlAPI.deleteRating + "/$bookId"), headers: {
        "authorization": "Bearer $token",
        "uid": userId
      }, body: {
        "user_nbRatings": nbRating.toString(),
        "note": note.toString()
      });
      if (resp.statusCode == 200) {
        return true;
      } else {
        print("error get http deleteRating --> ${resp.body}");
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> deleteBookFromGallery(String idUser, Book book, int nbBooks) async {
    try {
      var t = await FirebaseAuth.instance.currentUser();
      var token = (await t.getIdToken()).token;
      http.Response resp = await http.post(
          Uri.parse(UrlAPI.deleteBookFromGallery),
          headers: {"authorization": "Bearer $token", "uid": idUser},
          body: {"bookid": book.id, "nbBook": nbBooks.toString()});
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

  Future<BookSeller> getBookSellerById(String uid) async {
    try {
      var t = await FirebaseAuth.instance.currentUser();
      var token = (await t.getIdToken()).token;
      http.Response resp = await http.get(
        Uri.parse(UrlAPI.getBookSellerById + "/$uid"),
        headers: {"authorization": "Bearer $token"},
      );
      if (resp.statusCode == 200) {
        var map = json.decode(resp.body);
        return BookSeller.fromJson(map);
      } else {
        print("error get http getBookSellerById --> ${resp.body}");
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<BookSeller>> getInitListBookSeller() async {
    try {
      var t = await FirebaseAuth.instance.currentUser();
      var token = (await t.getIdToken()).token;
      http.Response resp = await http.get(
          Uri.parse(UrlAPI.getInitListBookSeller),
          headers: {"authorization": "Bearer $token"});
      if (resp.statusCode == 200) {
        var listBookseller = json.decode(resp.body);
        List<BookSeller> booksellers = [];
        listBookseller.forEach(
            (bookseller) => booksellers.add(BookSeller.fromJson(bookseller)));
        return booksellers;
      } else {
        print("error get http getInitListBookSeller --> ${resp.body}");
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<BookSeller>> searchBookSeller(String search) async {
    try {
      var t = await FirebaseAuth.instance.currentUser();
      var token = (await t.getIdToken()).token;
      http.Response resp = await http.get(Uri.parse(UrlAPI.searchBookSeller),
          headers: {"authorization": "Bearer $token", "search": Uri.encodeFull(search)});
      if (resp.statusCode == 200) {
        var listBookseller = json.decode(resp.body);
        List<BookSeller> booksellers = [];
        listBookseller.forEach(
            (bookseller) => booksellers.add(BookSeller.fromJson(bookseller)));
        return booksellers;
      } else {
        print("error get http searchBookSeller --> ${resp.body}");
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<BookWeek>> getListBooksWeek(String idBookSeller) async {
    try {
      var t = await FirebaseAuth.instance.currentUser();
      var token = (await t.getIdToken()).token;
      http.Response resp = await http.get(
          Uri.parse(UrlAPI.getListBooksWeek + "/$idBookSeller"),
          headers: {"authorization": "Bearer $token"});
      if (resp.statusCode == 200) {
        var listBooksWeek = json.decode(resp.body);
        List<BookWeek> booksWeek = [];
        listBooksWeek.forEach((book) => booksWeek.add(BookWeek.fromJson(book)));
        return booksWeek;
      } else {
        print("error get http getListBooksWeek --> ${resp.body}");
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<LastBookWeek>> getLastBooksWeek() async {
    try {
      var t = await FirebaseAuth.instance.currentUser();
      var token = (await t.getIdToken()).token;
      http.Response resp = await http.get(
          Uri.parse(UrlAPI.getLastBooksWeek),
          headers: {"authorization": "Bearer $token"});
      if (resp.statusCode == 200) {
        var listBooksWeek = json.decode(resp.body);
        List<LastBookWeek> booksWeek = [];
        listBooksWeek.forEach((book) => booksWeek.add(LastBookWeek.fromJson(book)));
        return booksWeek;
      } else {
        print("error get http getLastBooksWeek --> ${resp.body}");
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<bool> followUser(UserModel user, Following userToFollow) async {
    try {
      var t = await FirebaseAuth.instance.currentUser();
      var token = (await t.getIdToken()).token;
      http.Response resp = await http
          .post(Uri.parse(UrlAPI.followUser + "/${userToFollow.id}"), headers: {
        "authorization": "Bearer $token",
        "uid": user.id
      }, body: {
        "userSrc": json.encode({
          "id": user.id,
          "pseudo": user.pseudo,
          "picture": user.picture,
        }),
        "userDest": json.encode(userToFollow.toJson()),
        "nbFollowers": (userToFollow.nbFollowers + 1).toString(),
        "nbFollowing": (user.nbFollowing + 1).toString()
      });
      if (resp.statusCode == 200) {
        return true;
      } else {
        print("error get http followUser --> ${resp.body}");
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<List<UserModel>> getListFollowers(String userId) async {
    try {
      var t = await FirebaseAuth.instance.currentUser();
      var token = (await t.getIdToken()).token;
      http.Response resp = await http.get(
          Uri.parse(UrlAPI.getListFollowers + "/$userId"),
          headers: {"authorization": "Bearer $token"});
      if (resp.statusCode == 200) {
        var listFollowers = json.decode(resp.body);
        List<UserModel> followers = [];
        listFollowers
            .forEach((user) => followers.add(UserModel.fromJson(user)));
        return followers;
      } else {
        print("error get http getListFollowers --> ${resp.body}");
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<Following>> getListFollowing(String userId) async {
    try {
      var t = await FirebaseAuth.instance.currentUser();
      var token = (await t.getIdToken()).token;
      http.Response resp = await http.get(
          Uri.parse(UrlAPI.getListFollowing + "/$userId"),
          headers: {"authorization": "Bearer $token"});
      if (resp.statusCode == 200) {
        var listFollowing = json.decode(resp.body);
        List<Following> following = [];
        listFollowing
            .forEach((user) => following.add(Following.fromJson(user)));
        return following;
      } else {
        print("error get http getListFollowing --> ${resp.body}");
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<bool> unFollowUser(UserModel user, Following userToUnFollow) async {
    try {
      var t = await FirebaseAuth.instance.currentUser();
      var token = (await t.getIdToken()).token;
      http.Response resp = await http.post(
          Uri.parse(UrlAPI.unFollowUser + "/${userToUnFollow.id}"),
          headers: {
            "authorization": "Bearer $token",
            "uid": user.id
          },
          body: {
            "isBookSeller": userToUnFollow.isBookSeller.toString(),
            "nbFollowers": (userToUnFollow.nbFollowers - 1).toString(),
            "nbFollowing": (user.nbFollowing - 1).toString()
          });
      if (resp.statusCode == 200) {
        return true;
      } else {
        print("error get http unFollowUser --> ${resp.body}");
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> isFollow(String user, String userToFollow) async {
    try {
      var t = await FirebaseAuth.instance.currentUser();
      var token = (await t.getIdToken()).token;
      http.Response resp = await http.get(
          Uri.parse(UrlAPI.isFollow + "/$userToFollow"),
          headers: {"authorization": "Bearer $token", "uid": user});
      if (resp.statusCode == 200) {
        Map map = json.decode(resp.body);
        return map["status"];
      } else {
        print("error get http isFollow --> ${resp.body}");
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<List<Rating>> getFeed(String userId) async {
    try {
      var t = await FirebaseAuth.instance.currentUser();
      var token = (await t.getIdToken()).token;
      http.Response resp = await http.get(
          Uri.parse(UrlAPI.getFeed + "/$userId"),
          headers: {"authorization": "Bearer $token"});
      if (resp.statusCode == 200) {
        var listRatings = json.decode(resp.body);
        List<Rating> ratings = [];
        listRatings
            .forEach((rating) => ratings.add(Rating.fromJson(rating)));
        return ratings;
      } else {
        print("error get http getFeed --> ${resp.body}");
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
  
}
