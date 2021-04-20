import 'package:book_app/app/data/provider/api/firebase/firebase_auth_api.dart';
import 'package:book_app/app/data/provider/api/firebase/firebase_firestore_api.dart';

class AuthRepository {

  final FirebaseAuthAPI _authAPI = FirebaseAuthAPI();
  final FirebaseFirestoreAPI _databaseAPI = FirebaseFirestoreAPI();

  isEmailExist(String email) async {
    return await _databaseAPI.isEmailExist(email);
  }

  logout() async {
    await _authAPI.signOut();
  }

}