import 'package:book_app/app/data/provider/api/nodejs/nodejs_bdd_api.dart';

class BookSellerRepository {

  final NodeJSBddAPI _databaseAPI = NodeJSBddAPI();

  getInitListBookSeller() async {
    return await _databaseAPI.getInitListBookSeller();
  }

  searchBookSeller(String search) async {
    return await _databaseAPI.searchBookSeller(search);
  }

}