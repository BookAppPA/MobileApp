import 'package:get/get.dart';
import '../modules/widgets_global/my_check_internet.dart';


class AppBinding extends Bindings {
  @override
  void dependencies() {
   // Get.put(SplashScreenController(userRepository: UserRepository(), adminRepository: AdminRepository()));
   // Get.put(UserController(repository: UserRepository()));
    MyCheckInternet.instance.initialise();
  }
}