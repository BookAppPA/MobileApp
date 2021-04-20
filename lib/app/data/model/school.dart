class School {

  String name, code;

  School(this.name, this.code);

  School.fromJson(Map<String, dynamic> json){
      this.name = json['name'];
      this.code = json['code'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }

  @override
  String toString() => "$name, $code";
}