import 'package:book_app/app/data/model/user.dart';
import 'package:book_app/app/data/repository/auth_repository.dart';
import 'package:book_app/app/data/repository/user_repository.dart';
import 'package:book_app/app/modules/profil/profil_controller.dart';
import 'package:get/get.dart';

class ProfilBinding extends Bindings {
  @override
  void dependencies() {
    final UserModel user = Get.arguments as UserModel;
    Get.put(ProfilController(authRepository: AuthRepository(), userRepository: UserRepository(), user: user));
  }
}