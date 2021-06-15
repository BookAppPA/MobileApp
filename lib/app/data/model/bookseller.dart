import 'package:book_app/app/data/model/book.dart';

class BookSeller {

  String id, name, email, phone, address, bio;
  DateTime timestamp;
  List<Book> listBooksWeek;
  Map openHour;

  BookSeller({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.bio,
    this.timestamp,
    this.listBooksWeek,
    this.openHour
  });

  BookSeller.fromJson(Map<String, dynamic> json){
      this.id = json['uid'];
      this.name = json['name'];
      this.email = json['email'];
      this.phone = json['phone'] ?? "";
      this.address = json['address'];
      this.bio = json['bio'] ?? "";
      this.timestamp = DateTime.fromMillisecondsSinceEpoch(json["timestamp"]["_seconds"] * 1000);
      this.openHour = json["open_hour"];
      this.listBooksWeek = [];
  }

  @override
  String toString() => "$id, $name";
}