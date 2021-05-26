import 'package:book_app/app/data/model/user.dart';
import 'package:book_app/app/data/repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();

  final UserRepository repository;
  UserController({@required this.repository}) : assert(repository != null);

  UserModel _user;
  UserModel get user => this._user;
  set user(value) => this._user = value;

  Map<String, dynamic> _userData = {};
  Map<String, dynamic> get userData => this._userData;

  updateBio(String bio) {
    _user.bio = bio;
    update();
  }

  /*changeDomain(String domain) {
    Map<String, dynamic> map = {'domain': domain};
    if (_user != null) {
      if (_user.editInfo == null) {
        _user.editInfo = map;
      } else {
        _user.editInfo['domain'] = domain;
      }
    }
    _userData.addAll(map);
    update();
  }*/

/*
  changeBasicInfo(String sex, String name, String birthday, int age) {
    _userData.addAll({
      'sex': sex,
      'name': name,
      'birthday': birthday,
      'age': age,
    });
    _user.sex = sex;
    _user.name = name;
    _user.age = age;
    update();
  }*/

}
