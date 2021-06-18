import 'package:book_app/app/data/model/bookseller.dart';
import 'package:book_app/app/data/provider/api/firebase/firebase_firestore_api.dart';
import 'package:book_app/app/data/provider/api/nodejs/nodejs_auth_api.dart';

class AuthRepository {

  final NodeJSAuthAPI _authAPI = NodeJSAuthAPI();
  final FirebaseFirestoreAPI _databaseAPI = FirebaseFirestoreAPI();

  login(String email, String password) async {
    return await _authAPI.login(email, password);
  }

  signup(String pseudo, String email, String password) async {
    return await _authAPI.signup(pseudo, email, password);
  }

  checkSiret(String siret) async {
    return await _authAPI.checkSiret(siret);
  }

  checkSiren(String siren) async {
    return await _authAPI.checkSiren(siren);
  }

  signupBookSeller(BookSeller bookSeller, String password) async {
    return await _authAPI.signupBookSeller(bookSeller, password);
  }

  isEmailExist(String email) async {
    return await _databaseAPI.isEmailExist(email);
  }

  logout() async {
    return await _authAPI.logout();
  }

}