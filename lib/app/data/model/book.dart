class Book {

  String id, title, description, publisher, publishedDate, coverImage, language, previewLink, buyLink;
  List authors, categories;
  int pageCount, nbUserRead;
  double note;
  Map<String, dynamic> listPrice, retailPrice;

  Book({
    this.id,
    this.title,
    this.description,
    this.publisher,
    this.publishedDate,
    this.coverImage,
    this.language,
    this.previewLink,
    this.buyLink,
    this.authors,
    this.categories,
    this.pageCount,
    this.listPrice,
    this.retailPrice,
    this.note: 0.0,
    this.nbUserRead: 0,
  });

  setNote(double note) => this.note = note;
  setUserRead(int nb) => this.nbUserRead = nb;

  Book.fromJson(Map<String, dynamic> json){
      this.id = json['id'];
      this.title = json['volumeInfo']['title'];
      this.description = json['volumeInfo']['description'];
      this.publisher = json['volumeInfo']['publisher'];
      this.publishedDate = json['volumeInfo']['publishedDate'];
      this.coverImage = json['volumeInfo']['imageLinks']['thumbnail'];
      this.language = json['volumeInfo']['language'];
      this.previewLink = json['volumeInfo']['previewLink'];
      this.buyLink = json['saleInfo']['buyLink'];
      this.authors = json['volumeInfo']['authors'];
      this.categories = json['volumeInfo']['categories'];
      this.pageCount = json['volumeInfo']['pageCount'];
      this.listPrice = json['saleInfo']['listPrice'];
      this.retailPrice = json['saleInfo']['retailPrice'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['publisher'] = this.publisher;
    data['publishedDate'] = this.publishedDate;
    data['coverImage'] = this.coverImage;
    data['language'] = this.language;
    data['previewLink'] = this.previewLink;
    data['buyLink'] = this.buyLink;
    data['authors'] = this.authors;
    data['categories'] = this.categories;
    data['pageCount'] = this.pageCount;
    data['listPrice'] = this.listPrice;
    data['retailPrice'] = this.retailPrice;
    return data;
  }

  @override
  String toString() => "$id - $title";
}