class Rating {

  String id, message, bookImage;
  int nbStars;


  Rating({
    this.id,
    this.message,
    this.bookImage,
    this.nbStars,
  });

  Rating.fromJson(Map<String, dynamic> json){
      this.id = json['id'];
      this.message = json['message'];
      this.bookImage = json['bookImage'];
      this.nbStars = json['nbStars'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['bookImage'] = this.bookImage;
    data['nbStars'] = this.nbStars;
    return data;
  }

  @override
  String toString() => "$message: $nbStars/5";
}