import 'package:book_app/app/modules/dialog/basic_dialog.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:book_app/app/modules/squeleton/squeleton_controller.dart';
import 'package:book_app/app/translations/app_translations.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../profil/user_controller.dart';

class SqueletonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => BasicDialog.showExitAppDialog(),
      child: GetBuilder<SqueletonController>(
        init: SqueletonController(),
        builder: (controller) {
          return Scaffold(
            body: controller.page,
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: ConstantColor.white,
              selectedItemColor: ConstantColor.accent,
              unselectedItemColor: ConstantColor.greyWhite,
              elevation: 0.0,
              showUnselectedLabels: true,
              currentIndex: controller.currentIndex,
              onTap: (index) => controller.changePage(index),
              type: BottomNavigationBarType.fixed,
              items: _createListNavigation(),
            ),
          );
        },
      ),
    );
  }

  _createListNavigation() {
    var list = [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: AppTranslation.home.tr,
        tooltip: "",
      ),
      BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.book, size: 20),
        label: AppTranslation.bookseller.tr,
        tooltip: "",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: "Feed",
        tooltip: "",
      ),
      BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.userAlt, size: 20),
        label: AppTranslation.profil.tr,
        tooltip: "",
      ),
    ];
    if (UserController.to.isBookSeller || !UserController.to.isAuth) list.removeAt(2);
    return list;
  }
}
