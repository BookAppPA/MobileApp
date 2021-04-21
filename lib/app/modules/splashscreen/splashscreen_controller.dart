import 'package:book_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 2), () => Get.offAllNamed(Routes.ONBOARDING));
  }

}
