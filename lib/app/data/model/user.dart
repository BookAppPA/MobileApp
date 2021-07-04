import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/model/following.dart';
import 'package:book_app/app/data/model/rating.dart';

class UserModel {

  String id, pseudo, email, picture, bio, pushToken;
  int nbBooks, nbRatings, nbFollowers, nbFollowing, recommendationID;
  List<Book> listBooksRead;
  List<Rating> listLastRatings;
  List<UserModel> listFollowers;
  List listCategories;
  List<Following> listFollowing;
  bool isBlocked;

  UserModel({
    this.id,
    this.pseudo,
    this.email,
    this.picture,
    this.bio,
    this.nbBooks,
    this.nbRatings,
    this.nbFollowers,
    this.nbFollowing,
    this.listBooksRead,
    this.listLastRatings,
    this.isBlocked,
    this.listCategories,
    this.pushToken,
    this.recommendationID,
  });

  UserModel.fromJson(Map<String, dynamic> json){
      this.id = json['uid'] ?? json['id'];
      this.pseudo = json['pseudo'];
      this.email = json['email'];
      this.picture = json['picture'] ?? "";
      this.bio = json['bio'];
      this.nbBooks = json['nbBooks'] ?? 0;
      this.nbRatings = json['nbRatings'] ?? 0;
      this.nbFollowers = json['nbFollowers'] ?? 0;
      this.nbFollowing = json['nbFollowing'] ?? 0;
      this.listBooksRead = [];
      this.listLastRatings = [];
      this.isBlocked = json['isBlocked'] ?? false;
      this.listFollowers = [];
      this.listFollowing = [];
      this.pushToken = json['pushToken'];
      this.listCategories = json['listCategories'] ?? ["Aucune catégorie"];
      this.recommendationID = json['ml_id'] ?? 1;
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
    data['nbFollowing'] = this.nbFollowing;
    data['isBlocked'] = this.isBlocked;
    data['listCategories'] = this.listCategories;
    return data;
  }

  @override
  String toString() => "$id, $pseudo";
}