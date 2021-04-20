import 'package:book_app/app/data/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class SplashScreenController extends GetxController {
  final UserRepository userRepository;
  bool isAlreadyCheck = false;
  SplashScreenController(
      {@required this.userRepository})
      : assert(userRepository != null);

  @override
  void onInit() {
    super.onInit();
    
  }

}
