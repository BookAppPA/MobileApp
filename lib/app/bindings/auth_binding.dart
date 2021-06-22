import 'package:book_app/app/data/repository/auth_repository.dart';
import 'package:book_app/app/data/repository/user_repository.dart';
import 'package:book_app/app/modules/auth/auth_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    bool isBlocked = Get.arguments as bool ?? false;
    Get.put(AuthController(userRepository: UserRepository(), authRepository: AuthRepository(), isBlocked: isBlocked));
  }

}