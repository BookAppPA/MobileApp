import 'dart:convert';
import 'package:book_app/app/utils/constant/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jiffy/jiffy.dart';
import 'package:http/http.dart' as http;
import 'constant/url_api.dart';

String parseDateTime(DateTime date, String regex) {
  return Jiffy(date).format(regex);
}

String parseTimestamp(Duration duration) {
  String date = duration.toString().split('.').first;
  String newDate = date.substring(0, date.length - 3);
  List<String> list = newDate.split(":");
  String res = "";
  if (list[0].length == 1)
    res = "0${list[0]}:";
  else
    res = "${list[0]}:";
  if (list[1].length == 1)
    res += "0${list[1]}";
  else
    res += list[1];
  return res;
}

DateTime stringToDate(String date, String regex) {
  return Jiffy(date, regex).dateTime;
}

DateTime timestampToDate(int timestamp) {
  return DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
}

int getAgeFromBirthday(String birthday) {
  return diffDateToToday(stringToDate(birthday, 'dd/MM/yyyy'), Units.YEAR);
}

int diffDateToToday(DateTime date, Units units) {
  var now = Jiffy(Constant.today);
  return now.diff(
      Jiffy(
        date,
      ),
      units);
}

bool stringIsAlphabet(String str) {
  RegExp reg = RegExp(r"^[A-Za-z]+$");
  return reg.hasMatch(str);
}

bool stringIsName(String str) {
  RegExp reg = RegExp(r"^[A-Za-z \-\']+$");
  return reg.hasMatch(str);
}

String capitalizeFirstLetter(String str) {
  return "${str[0].toUpperCase()}${str.substring(1)}";
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
      /*var now = Jiffy().dateTime;
        Duration diff = now.difference(timestampToDate(map['timestamp']));
        print("now date: $now, $diff");
        print(
            "diff to today: ${diffDateToToday(timestampToDate(map['timestamp']), Units.HOUR)}");*/
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

Timestamp parseDateTimeToTimestamp(DateTime date) {
  return Timestamp.fromDate(date);
}

String parseTimestampFirebaseToString(Timestamp date) {
  return parseDateTime(
      Timestamp.fromDate(date.toDate()).toDate(), "dd/MM/yyyy HH:mm");
}
