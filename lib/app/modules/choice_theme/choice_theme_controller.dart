import 'dart:convert';

import 'package:book_app/app/data/repository/user_repository.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:book_app/app/modules/widgets_global/snackbar.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:book_app/app/translations/app_translations.dart';
import 'package:get/get.dart';

class ChoiceThemeController extends GetxController {

  List<String> listChoiceCategories = [];
  bool isBlock = true;
  final UserRepository repository = UserRepository();

  selectCategories(String categoryName) {
    listChoiceCategories.add(categoryName);
    isBlock = false;
    update();
  }

  deselectCategories(String categoryName){
    listChoiceCategories.remove(categoryName);
    if(listChoiceCategories.length == 0){
      isBlock = true;
      update();
    }
  }

  finishSelectChoice() async {
    if(!isBlock){
      var res = await repository.updateUser(UserController.to.user.id, {'listCategories': json.encode(listChoiceCategories)});
      if(res){
        UserController.to.user.listCategories = listChoiceCategories;
        Get.toNamed(Routes.SQUELETON);
      } else {
        CustomSnackbar.snackbar(AppTranslation.serverError.tr);
      }
    }
  }

}