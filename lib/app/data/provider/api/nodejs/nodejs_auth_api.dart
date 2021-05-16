import 'dart:convert';
import 'package:book_app/app/data/model/user.dart';
import 'package:book_app/app/utils/constant/url_api.dart';
import 'package:http/http.dart' as http;

class NodeJSAuthAPI {
  Future<UserModel> login(String email, String password) async {
    try {
      http.Response resp = await http.post(Uri.parse(UrlAPI.login), body: {
        "email": email,
        "password": password
      });
      if (resp.statusCode == 200) {
        print("response: ${resp.body}");
        Map<String, dynamic> map = json.decode(resp.body);
        return UserModel.fromJson(map);
      } else {
        print("error get http call");
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<UserModel> signup(String pseudo, String email, String password) async {
    try {
      http.Response resp = await http.post(Uri.parse(UrlAPI.signup), body: {
        "pseudo": pseudo,
        "email": email,
        "password": password
      });
      if (resp.statusCode == 200) {
        print("response: ${resp.body}");
        Map<String, dynamic> map = json.decode(resp.body);
        return UserModel.fromJson(map);
      } else {
        print("error get http call");
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<DateTime> server(String email, String password) async {
    try {
      http.Response resp = await http.get(Uri.parse(UrlAPI.login));
      if (resp.statusCode == 200) {
        print("response: ${resp.body}");
        Map<String, dynamic> map = json.decode(resp.body);
        print("time: ${map['timestamp']}");
        return DateTime.now();
      } else {
        print("error get http call");
        return DateTime.now();
      }
    } catch (e) {
      print(e.toString());
      return DateTime.now();
    }
  }
}
