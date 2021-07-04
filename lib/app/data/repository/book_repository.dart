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

  searchBooksByCategories(String search) async {
    return await _databaseAPI.searchBooksByCategories(search);
  }

  searchUsers(String search) async {
    return await _databaseAPI.searchUsers(search);
  }

  getRecommendationBooks(int mlID) async {
    return await _databaseAPI.getRecommendationBooks(mlID);
  }

}