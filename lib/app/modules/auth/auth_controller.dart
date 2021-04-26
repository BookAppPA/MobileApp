import 'package:book_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {

  bool _isLoginvView = true;
  bool get isLoginView => this._isLoginvView;

  changeAuthMode() {
    _isLoginvView = !_isLoginvView;
    update();
  }

  submitAuth() {
    if (_isLoginvView)
      print("Login process");
    else
      print("Signup process");
    
    Get.offAllNamed(Routes.CHOICE_THEME);
  }
}