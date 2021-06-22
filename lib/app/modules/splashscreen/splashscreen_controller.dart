import 'package:book_app/app/data/model/user.dart';
import 'package:book_app/app/data/provider/sharepreferences/sharepreference_helper.dart';
import 'package:book_app/app/data/repository/user_repository.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:book_app/app/modules/widgets_global/my_check_internet.dart';
import 'package:book_app/app/modules/widgets_global/snackbar.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:book_app/app/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class SplashScreenController extends GetxController {
  final UserRepository userRepository;
  bool isAlreadyCheck = false;
  SplashScreenController({@required this.userRepository})
      : assert(userRepository != null);

  @override
  void onInit() {
    super.onInit();
    Get.put(UserController(repository: userRepository));
    MyCheckInternet.instance.myStream.listen((value) {
      print("INTERNET => $value");
      if (!value.values.first) {
        // Pas internet
        Future.delayed(Duration(seconds: 2), () {
          CustomSnackbar.notif("Internet Indisponible", fixed: true);
        });
        isAlreadyCheck = false;
      } else {
        // _isConnecting = true;
        if (!isAlreadyCheck) _checkAuth();
        isAlreadyCheck = true;
      }
      update();
    });
  }

  _checkAuth() async {
    var userAuth = await userRepository.getCurrentUser();
    if (userAuth != null) {
      var user = await userRepository.getUserById(userAuth.uid);
      if (user != null) {
        if (user is UserModel && user.isBlocked) {
          Get.offAllNamed(Routes.AUTH, arguments: true);
        } else {
          if (user is UserModel)
            UserController.to.user = user;
          else {
            UserController.to.bookseller = user;
            if (UserController.to.bookseller.dateNextAddBookWeek != null) {
              var dateServer = await getDateServer();
              int diff = diffDateToDateServer(
                  dateServer,
                  UserController.to.bookseller.dateNextAddBookWeek,
                  Units.MINUTE);
              print("diff date -> $diff");
              if (diff > 0) {
                // > 24H
                UserController.to.isAddBookWeek(true);
              }
            } else {
              UserController.to.isAddBookWeek(true);
            }
          }
          Get.offAllNamed(Routes.SQUELETON);
        }
      } else
        Get.offAllNamed(Routes.AUTH);
    } else {
      if (await SharePreferenceHelper.instance.isFirstTime()) {
        await SharePreferenceHelper.instance.setFirstTime(false);
        Get.offAllNamed(Routes.ONBOARDING);
      } else
        Get.offAllNamed(Routes.AUTH);
    }
  }
}
