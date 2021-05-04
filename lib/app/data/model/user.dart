class UserModel {

  String id, pseudo, email, picture, bio;


  UserModel({
    this.id,
    this.pseudo,
    this.email,
    this.picture,
    this.bio,
  });

  UserModel.fromJson(Map<String, dynamic> json){
      this.id = json['id'];
      this.pseudo = json['pseudo'];
      this.email = json['email'];
      this.picture = json['picture'];
      this.bio = json['bio'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pseudo'] = this.pseudo;
    data['email'] = this.email;
    data['picture'] = this.picture;
    data['bio'] = this.bio;
    return data;
  }

  @override
  String toString() => "$id, $pseudo";
}