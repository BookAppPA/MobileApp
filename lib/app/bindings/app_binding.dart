import 'package:book_app/app/data/repository/user_repository.dart';
import 'package:book_app/app/modules/splashscreen/splashscreen_controller.dart';
import 'package:get/get.dart';
import '../modules/widgets_global/my_check_internet.dart';


class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashScreenController(userRepository: UserRepository()));
   // Get.put(UserController(repository: UserRepository()));
    MyCheckInternet.instance.initialise();
  }
}