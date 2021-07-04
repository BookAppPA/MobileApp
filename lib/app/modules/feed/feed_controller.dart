import 'package:book_app/app/data/model/rating.dart';
import 'package:book_app/app/data/repository/user_repository.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedController extends GetxController {

  FeedController({@required this.repository}) : assert(repository != null);

  final UserRepository repository;
  List<Rating> listRatings = [];
  bool searching = true;

  @override
  void onInit() {
    super.onInit();
    _getFeed();
  }

  _getFeed() async {
    listRatings = await repository.getFeed(UserController.to.user.id);
    searching = false;
    update();
  }

}