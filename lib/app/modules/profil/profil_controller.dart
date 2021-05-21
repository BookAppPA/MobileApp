import 'package:book_app/app/data/repository/auth_repository.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilController extends GetxController {
  static ProfilController get to => Get.put(ProfilController(authRepository: AuthRepository()));

  final AuthRepository authRepository;
  ProfilController({@required this.authRepository})
      : assert(authRepository != null);

  clickLogout() async {
    print("logout");
    var result = await authRepository.logout();
    if (result)
      Get.offAllNamed(Routes.AUTH);
    else 
      print("LOGOUT ERREUR....");
  }
}
