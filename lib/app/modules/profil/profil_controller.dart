import 'dart:io';

import 'package:book_app/app/data/repository/auth_repository.dart';
import 'package:book_app/app/data/repository/user_repository.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfilController extends GetxController {
  static ProfilController get to =>
      Get.put(ProfilController(authRepository: AuthRepository(), userRepository: UserRepository()));

  final AuthRepository authRepository;
  final UserRepository userRepository;
  ProfilController({@required this.authRepository, @required this.userRepository})
      : assert(authRepository != null), assert(userRepository != null);

  final _picker = ImagePicker();
  

  clickLogout() async {
    print("logout");
    var result = await authRepository.logout();
    if (result)
      Get.offAllNamed(Routes.AUTH);
    else
      print("LOGOUT ERREUR....");
  }

  changePicture() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      UserController.to.isLoadingPicture(true);
      String urlPic = await userRepository.changeUserPicture(UserController.to.user.id, pickedFile.path, UserController.to.user.picture);
      UserController.to.updatePicture(urlPic);
      UserController.to.isLoadingPicture(false);
    } else {
      print('No image selected.');
    }
  }

  clickEditProfil() {
    Get.toNamed(Routes.EDIT_PROFIL);
  }

  clickFollow() {
    print("click follow user");
  }
}
