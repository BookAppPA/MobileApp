class LastBookWeek {
  String booksellerId, picture, bookId, bio;
  DateTime timestamp;

  LastBookWeek({
    this.booksellerId,
    this.picture,
    this.timestamp,
    this.bookId,
    this.bio
  });

  LastBookWeek.fromJson(Map<String, dynamic> json) {
    this.booksellerId = json['bookseller_id'];
    this.picture = json['picture'];
    this.bookId = json['book_id'];
    this.bio = json['bio'];
    this.timestamp = DateTime.fromMillisecondsSinceEpoch(json["timestamp"]["_seconds"] * 1000);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookseller_id'] = this.booksellerId;
    data['picture'] = this.picture;
    data['book_id'] = this.bookId;
    data['bio'] = this.bio;
    return data;
  }

  @override
  String toString() => "$booksellerId";
}
