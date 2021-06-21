import 'package:book_app/app/data/model/bookweek.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookSeller {
  String id, name, email, phone, address, bio, siret;
  DateTime timestamp, dateNextAddBookWeek;
  List<BookWeek> listBooksWeek;
  Map openHour;
  LatLng coord;

  BookSeller(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.bio,
      this.timestamp,
      this.listBooksWeek,
      this.openHour,
      this.coord,
      this.siret});

  BookSeller.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.email = json['email'];
    this.phone = json['phone'] ?? "";
    this.address = json['address'];
    this.bio = json['bio'] ?? "";
    this.timestamp = json["timestamp"]["_seconds"] != null
        ? DateTime.fromMillisecondsSinceEpoch(
            json["timestamp"]["_seconds"] * 1000)
        : DateTime.now();
    this.openHour = json["open_hour"] ?? {};
    this.listBooksWeek = [];
    this.coord = LatLng(json["coord"]["lat"], json["coord"]["lon"]);
    this.siret = json["siret"];
    this.dateNextAddBookWeek = json["dateNextAddBookWeek"] != null ? DateTime.fromMillisecondsSinceEpoch(
        json["dateNextAddBookWeek"]["_seconds"] * 1000) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['lat'] = this.coord.latitude.toString();
    data['lon'] = this.coord.longitude.toString();
    data['siret'] = this.siret;
    data['dateNextAddBookWeek'] = this.dateNextAddBookWeek;
    return data;
  }

  @override
  String toString() => "$id, $name";
}
