import 'dart:convert';
import 'package:jiffy/jiffy.dart';
import 'package:http/http.dart' as http;
import 'constant/url_api.dart';

String parseDateTime(DateTime date, String regex) {
  return Jiffy(date).format(regex);
}

DateTime stringToDate(String date, String regex) {
  return Jiffy(date, regex).dateTime;
}

DateTime timestampToDate(int timestamp) {
  return DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
}

bool stringIsName(String str) {
  RegExp reg = RegExp(r"^[A-Za-z \-\']+$");
  return reg.hasMatch(str);
}

bool isOnlyNumeric(String str) {
  RegExp reg = RegExp(r"^[0-9]+$");
  return reg.hasMatch(str);
}

bool isPhoneNumber(String str) {
  RegExp reg = RegExp(r"^[0-9\-]+$");
  return reg.hasMatch(str);
}

String splitAddress(String address) {
  var list = address.split(" ");
  int index = list.indexWhere((item) {
    var n = int.tryParse(item);
    return n != null && n > 1000;
  });
  if (index != -1) {
    String res = "";
    for (int i = 0; i < index; i++) {
      res += list[i] + " ";
    }
    res += "\n";
    for (int i = index; i < list.length; i++) {
      res += list[i] + " ";
    }
    return res;
  } else
    return address;
}

Future<DateTime> getDateServer() async {
  try {
    http.Response resp = await http.get(Uri.parse(UrlAPI.dateServer));
    if (resp.statusCode == 200) {
      print("response: ${resp.body}");
      Map<String, dynamic> map = json.decode(resp.body);
      print("time: ${map['timestamp']}");
      print("date: ${timestampToDate(map['timestamp'])}");
      var date = timestampToDate(map['timestamp']);
      return date;
    } else {
      print("error get http getDateServer --> ${resp.body}");
      return DateTime.now();
    }
  } catch (e) {
    print(e.toString());
    return DateTime.now();
  }
}

int diffDateToDateServer(DateTime dateServer, DateTime date, Units units) {
  var now = Jiffy(dateServer);
  return now.diff(
      Jiffy(
        date,
      ),
      units);
}