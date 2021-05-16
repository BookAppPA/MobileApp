import 'package:book_app/app/data/model/user.dart';
import 'package:book_app/app/data/repository/auth_repository.dart';
import 'package:book_app/app/data/repository/user_repository.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  final UserRepository userRepository;
  final AuthRepository authRepository;
  AuthController({@required this.userRepository, @required this.authRepository})
      : assert(userRepository != null),
        assert(authRepository != null);

  TextEditingController _pseudoController = TextEditingController();
  TextEditingController get pseudoController => this._pseudoController;
  TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => this._emailController;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => this._passwordController;

  bool _isLoginvView = true;
  bool get isLoginView => this._isLoginvView;

  String get _pseudo => _emailController.text.trim();
  String get _email => _emailController.text.trim();
  String get _password => _emailController.text.trim();

  changeAuthMode() {
    _isLoginvView = !_isLoginvView;
    update();
  }

  submitAuth() async {
    if (_isLoginvView) {
      print("Login process");
      await _loginUser();
    } else {
      print("Signup process");
      await _signupUser();
    }
    Get.offAllNamed(Routes.CHOICE_THEME);
  }

  _loginUser() async {
    UserModel user = await authRepository.login(_email, _password);
    if (user == null) {
      print("USER LOGIN IS NULL");
    } else {
      print("USER LOGIN --> ${user.email}");
    }
  }

  _signupUser() async {
    UserModel user = await authRepository.signup(_pseudo, _email, _password);
    if (user == null) {
      print("USER SIGNUP IS NULL");
    } else {
      print("USER SIGNUP --> ${user.email}");
    }
  }
  
}
