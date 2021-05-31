class Rating {

  String bookId, title, message, bookTitle, bookImage, bookAuthor, bookPublished, userId, userImage, userName;
  int note;
  DateTime timestamp;


  Rating({
    this.bookId,
    this.title,
    this.message,
    this.bookTitle,
    this.bookImage,
    this.bookAuthor,
    this.bookPublished,
    this.userId,
    this.userImage,
    this.userName,
    this.note,
    this.timestamp
  });

  Rating.fromJson(Map<String, dynamic> json){
      this.bookId = json['book_id'];
      this.bookTitle = json['book_title'];
      this.bookImage = json['book_pic'];
      this.bookAuthor = json['book_author'];
      this.bookPublished = json['book_published'];
      this.title = json['title'];
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
    data['book_title'] = this.bookTitle;
    data['book_pic'] = this.bookImage;
    data['book_author'] = this.bookAuthor;
    data['book_published'] = this.bookPublished;
    data['title'] = this.title;
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