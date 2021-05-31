class Rating {

  String bookId, message, bookImage, userId, userImage, userName;
  int note;
  DateTime timestamp;


  Rating({
    this.bookId,
    this.message,
    this.bookImage,
    this.userId,
    this.userImage,
    this.userName,
    this.note,
    this.timestamp
  });

  Rating.fromJson(Map<String, dynamic> json){
      this.bookId = json['book_id'];
      this.bookImage = json['book_pic'];
      this.message = json['message'];
      this.note = json['note'];
      this.timestamp = DateTime.fromMillisecondsSinceEpoch(json["timestamp"]["_seconds"] * 1000);
      this.userId = json["user_id"];
      this.userImage = json["user_pic"];
      this.userName = json["username"];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['book_id'] = this.bookId;
    data['book_pic'] = this.bookImage;
    data['message'] = this.message;
    data['note'] = this.note;
    data['user_id'] = this.userId;
    data['user_pic'] = this.userImage;
    data['username'] = this.userName;
    return data;
  }

  @override
  String toString() => "$message: $note/5";
}