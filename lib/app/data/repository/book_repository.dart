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

}