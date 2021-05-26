import 'package:book_app/app/data/model/book.dart';

class UserModel {

  String id, pseudo, email, picture, bio;
  int nbBooks, nbRatings, nbFollowers;
  List<Book> listBooksRead;

  UserModel({
    this.id,
    this.pseudo,
    this.email,
    this.picture,
    this.bio,
    this.nbBooks,
    this.nbRatings,
    this.nbFollowers,
    this.listBooksRead
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
      this.listBooksRead = json['listBooksRead'] ?? [];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.id;
    data['pseudo'] = this.pseudo;
    data['email'] = this.email;
    data['picture'] = this.picture;
    data['bio'] = this.bio;
    data['nbBooks'] = this.bio;
    data['nbRatings'] = this.bio;
    data['nbFollowers'] = this.bio;
    data['listBooksRead'] = this.bio;
    return data;
  }

  @override
  String toString() => "$id, $pseudo";
}