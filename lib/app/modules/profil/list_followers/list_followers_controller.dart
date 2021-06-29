import 'package:book_app/app/data/repository/user_repository.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListFollowersController extends GetxController {
  static ListFollowersController get to => Get.find();

  final UserRepository repository;
  final String userId;
  final bool isFollowing;
  ListFollowersController(
      {@required this.repository, this.userId, this.isFollowing: false})
      : assert(repository != null),
        assert(userId != null && userId != "");

  bool afterLoading = false;

  @override
  void onInit() {
    super.onInit();
    _getListFollowers();
  }

  _getListFollowers() async {
    if (isFollowing) {
      var list = await repository.getListFollowing(userId);
      afterLoading = true;
      UserController.to.setListFollowing(list);
    } else {
      var list = await repository.getListFollowers(userId);
      afterLoading = true;
      UserController.to.setListFollowers(list);
    }
  }
}
