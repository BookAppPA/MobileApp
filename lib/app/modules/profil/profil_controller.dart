import 'dart:io';

import 'package:book_app/app/data/repository/auth_repository.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfilController extends GetxController {
  static ProfilController get to =>
      Get.put(ProfilController(authRepository: AuthRepository()));

  final AuthRepository authRepository;
  ProfilController({@required this.authRepository})
      : assert(authRepository != null);

  File _image;
  final picker = ImagePicker();

  clickLogout() async {
    print("logout");
    var result = await authRepository.logout();
    if (result)
      Get.offAllNamed(Routes.AUTH);
    else
      print("LOGOUT ERREUR....");
  }

  changePicture() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
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
