class Following {

  String id, pseudo, picture, address;
  bool isBookSeller, isBlocked;
  int nbFollowers;
  DateTime timestamp;

  Following({
    this.id: "",
    this.pseudo: "",
    this.picture: "",
    this.address: "",
    this.nbFollowers: 0,
    this.isBookSeller: false,
    this.timestamp,
    this.isBlocked: false,
  });

  Following.fromJson(Map<String, dynamic> json){
      this.id = json['id'];
      this.pseudo = json['pseudo'];
      this.picture = json['picture'] ?? "";
      this.address = json['address'] ?? "";
      this.isBookSeller = json['isBookSeller'] ?? false;
      this.isBlocked = false;
      this.timestamp = DateTime.fromMillisecondsSinceEpoch(json["timestamp"]["_seconds"] * 1000);
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pseudo'] = this.pseudo;
    data['picture'] = this.picture;
    data['address'] = this.address;
    data['isBookSeller'] = this.isBookSeller;
    return data;
  }

  @override
  String toString() => "$id - $pseudo";
}