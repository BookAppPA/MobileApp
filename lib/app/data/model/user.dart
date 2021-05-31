import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/model/rating.dart';

class UserModel {

  String id, pseudo, email, picture, bio;
  int nbBooks, nbRatings, nbFollowers;
  List<Book> listBooksRead;
  List<Rating> listLastRatings;

  UserModel({
    this.id,
    this.pseudo,
    this.email,
    this.picture,
    this.bio,
    this.nbBooks,
    this.nbRatings,
    this.nbFollowers,
    this.listBooksRead,
    this.listLastRatings,
  });

  UserModel.fromJson(Map<String, dynamic> json){
      this.id = json['uid'];
      this.pseudo = json['pseudo'];
      this.email = json['email'];
      this.picture = json['picture'] ?? "";
      this.bio = json['bio'];
      this.nbBooks = json['nbBooks'] ?? 0;
      this.nbRatings = json['nbRatings'] ?? 0;
      this.nbFollowers = json['nbFollowers'] ?? 0;
      this.listBooksRead = [];
      this.listLastRatings = [];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.id;
    data['pseudo'] = this.pseudo;
    data['email'] = this.email;
    data['picture'] = this.picture;
    data['bio'] = this.bio;
    data['nbBooks'] = this.nbBooks;
    data['nbRatings'] = this.nbRatings;
    data['nbFollowers'] = this.nbFollowers;
    return data;
  }

  @override
  String toString() => "$id, $pseudo";
}