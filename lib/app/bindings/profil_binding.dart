import 'package:book_app/app/data/model/user.dart';
import 'package:book_app/app/data/repository/auth_repository.dart';
import 'package:book_app/app/data/repository/user_repository.dart';
import 'package:book_app/app/modules/profil/profil_controller.dart';
import 'package:get/get.dart';

class ProfilBinding extends Bindings {
  @override
  void dependencies() {
    final UserModel user = Get.arguments as UserModel;
    if (user.pseudo != null)
      Get.put(ProfilController(authRepository: AuthRepository(), userRepository: UserRepository(), user: user));
    else if (user.id != null)
      Get.put(ProfilController(authRepository: AuthRepository(), userRepository: UserRepository(), userId: user.id));
    else
      Get.put(ProfilController(authRepository: AuthRepository(), userRepository: UserRepository()));
  }
}