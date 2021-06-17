class BookWeek {
  String id, bio, picture, title, datePublished, author;
  DateTime timestamp;

  BookWeek({
    this.id,
    this.bio,
    this.picture,
    this.title,
    this.datePublished,
    this.author,
    this.timestamp,
  });

  BookWeek.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.bio = json['bio'];
    this.picture = json['picture'];
    this.title = json['title'];
    this.datePublished = json['datePublished'];
    this.author = json['author'];
    this.timestamp = DateTime.fromMillisecondsSinceEpoch(json["timestamp"]["_seconds"] * 1000);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bio'] = this.bio;
    return data;
  }

  @override
  String toString() => "$id";
}
