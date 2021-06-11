import 'package:book_app/app/data/provider/api/nodejs/nodejs_bdd_api.dart';

class BookRepository {

  final NodeJSBddAPI _databaseAPI = NodeJSBddAPI();

  getPopularBooks() async {
    return await _databaseAPI.getPopularBooks();
  }

  getBook(String bookID) async {
    return await _databaseAPI.getBook(bookID);
  }

  getRatingsByBook(String bookID) async {
    return await _databaseAPI.getRatingsByBook(bookID);
  }

  searchBooks(String search) async {
    return await _databaseAPI.searchBooks(search);
  }

  searchBooksByAuthor(String search) async {
    return await _databaseAPI.searchBooksByAuthor(search);
  }

  searchUsers(String search) async {
    return await _databaseAPI.searchUsers(search);
  }

}