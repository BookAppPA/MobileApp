import 'package:book_app/app/data/repository/auth_repository.dart';
import 'package:book_app/app/data/repository/bookseller_repository.dart';
import 'package:book_app/app/data/repository/user_repository.dart';
import 'package:book_app/app/modules/bookseller/bookseller_detail/bookseller_detail_controller.dart';
import 'package:book_app/app/modules/bookseller/bookseller_detail/bookseller_detail_page.dart';
import 'package:book_app/app/modules/bookseller/bookseller_main_page.dart';
import 'package:book_app/app/modules/feed/feed_page.dart';
import 'package:book_app/app/modules/home/home_page.dart';
import 'package:book_app/app/modules/profil/profil_controller.dart';
import 'package:book_app/app/modules/profil/profil_page.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SqueletonController extends GetxController {

  int _currentIndex = 0;
  int get currentIndex => this._currentIndex;

  Widget get page {
    switch (_currentIndex) {
      case 0:
        return HomePage();
      case 1:
        return BookSellerMainPage();
      case 2:
        if (UserController.to.isBookSeller) {
          var controller = Get.put(BookSellerDetailController(repository: BookSellerRepository(), bookSeller: UserController.to.bookseller));
          return BookSellerDetailPage(bookSeller: UserController.to.bookseller, back: false, controller: controller);
        }
        return FeedPage();
      case 3:
        var controller = Get.put(ProfilController(authRepository: AuthRepository(), userRepository: UserRepository(), user: UserController.to.user));
        return ProfilPage(controller: controller);
      default:
        return Center(child: Text("Erreur"));
    }
  }

  changePage(int index) {
    if (index != _currentIndex) {
      _currentIndex = index;
      update();
    }
  }

}