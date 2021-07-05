import 'package:book_app/app/data/repository/user_repository.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/model/following.dart';
import '../../../data/model/user.dart';
import '../user_controller.dart';

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
  bool isMe = false;
  List<Following> listUser = [];

  @override
  void onInit() {
    super.onInit();
    isMe = !UserController.to.isAuth
        ? false
        : (userId == UserController.to.user.id);
    _getListFollowers();
  }

  _getListFollowers() async {
    if (isFollowing) {
      var list = await repository.getListFollowing(userId);
      afterLoading = true;
      listUser = list;
      if (isMe) UserController.to.setListFollowing(list);
    } else {
      List<UserModel> list = await repository.getListFollowers(userId);
      afterLoading = true;
      if (isMe) UserController.to.setListFollowers(list);
      list.forEach((user) {
        listUser.add(Following(
            id: user.id,
            pseudo: user.pseudo,
            isBookSeller: false,
            picture: user.picture,
            isBlocked: user.isBlocked,
            address: ""));
      });
    }
    update();
  }
}
