import 'package:book_app/app/data/provider/api/nodejs/nodejs_bdd_api.dart';

class BookSellerRepository {

  final NodeJSBddAPI _databaseAPI = NodeJSBddAPI();

  getBookSellerById(String bookSellerId) async {
    return await _databaseAPI.getBookSellerById(bookSellerId);
  }

  getInitListBookSeller() async {
    return await _databaseAPI.getInitListBookSeller();
  }

  searchBookSeller(String search) async {
    return await _databaseAPI.searchBookSeller(search);
  }

  getListBooksWeek(String idBookSeller) async {
    return await _databaseAPI.getListBooksWeek(idBookSeller);
  }

}