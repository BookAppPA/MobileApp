import 'package:book_app/app/data/model/user.dart';
import 'package:book_app/app/data/repository/user_repository.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListFollowersController extends GetxController {

  static ListFollowersController get to => Get.find();

  final UserRepository repository;
  final String userId;
  ListFollowersController({@required this.repository, this.userId})
      : assert(repository != null),
        assert(userId != null && userId != "");

  bool afterLoading = false;

  @override
  void onInit() {
    super.onInit();
    _getListFollowers();
  }

  _getListFollowers() async {
    var list = await repository.getListFollowers(userId);
    afterLoading = true;
    UserController.to.setListFollowers(list);
  }

  followUser(int index, UserModel user) async {
    var res = await UserController.to.followUser(user);
    if (res) {
      UserController.to.modifyNbFollowersOfUser(index, user.nbFollowers + 1);
      update();
    }
  }


}
