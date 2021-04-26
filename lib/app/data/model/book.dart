class Book {

  String title, author;

  Book(this.title, this.author);

  Book.fromJson(Map<String, dynamic> json){
      this.title = json['title'];
      this.author = json['author'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['author'] = this.author;
    return data;
  }

  @override
  String toString() => "$title, $author";
}