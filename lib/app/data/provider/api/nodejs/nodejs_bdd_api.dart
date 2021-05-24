import 'dart:convert';
import 'package:book_app/app/data/model/user.dart';
import 'package:book_app/app/modules/widgets_global/snackbar.dart';
import 'package:book_app/app/utils/constant/url_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class NodeJSBddAPI {

  Future<UserModel> getUserById(String uid) async {
    try {
      var token = await FirebaseAuth.instance.currentUser.getIdToken();
      http.Response resp = await http.get(Uri.parse(UrlAPI.getUserById),
          headers: {"authorization": "Bearer $token", "uid": uid}, );
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
}
