import 'package:book_app/app/data/model/user.dart';
import 'package:book_app/app/data/repository/auth_repository.dart';
import 'package:book_app/app/data/repository/user_repository.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:book_app/app/utils/constant/constant.dart';
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

  bool _isEmailValid = true;
  bool get isEmailValid => this._isEmailValid;
  bool _isPasswordValid = true;
  bool get isPasswordValid => this._isPasswordValid;
  bool _isPseudoValid = true;
  bool get isPseudoValid => this._isPseudoValid;

  bool _isLoginvView = true;
  bool get isLoginView => this._isLoginvView;

  bool _isLoading = false;
  bool get isLoading => this._isLoading;

  String get _pseudo => _pseudoController.text.trim();
  String get _email => _emailController.text.trim();
  String get _password => _passwordController.text.trim();

  @override
  void onInit() {
    super.onInit();
    _pseudoController.addListener(() {
      _isPseudoValid = true;
      update();
    });
    _emailController.addListener(() {
      _isEmailValid = true;
      update();
    });
    _passwordController.addListener(() {
      _isPasswordValid = true;
      update();
    });
  }

  changeAuthMode() {
    _isLoginvView = !_isLoginvView;
    _isEmailValid = true;
    _isPasswordValid = true;
    _isPseudoValid = true;
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
  }

  bool _validEmail(String email) {
    var _email = email.trim();
    var _index = _email.indexOf("@");
    var _valid = false;
    if (_index != -1) {
      _valid = Constant.regexEmail.hasMatch(_email);
    }
    _isEmailValid = _valid;
    return _valid;
  }

  bool _checkLoginInfo() {
    _isPasswordValid = _password.length >= 6 && _password.length <= 30;
    if (!_validEmail(_email))
      return false;
    if (!_isPasswordValid)
      return false;
    return true;
  }

  bool _checkSignupInfo() {
    _isPseudoValid = _pseudo.length >= 3 && _pseudo.length <= 15;
    return _checkLoginInfo() && _isPseudoValid;
  }

  _loginUser() async {
    if (!_checkLoginInfo()) {
      update();
      return;
    }
    _isLoading = true;
    update();
    UserModel user = await authRepository.login(_email, _password);
    _isLoading = false;
    update();
    if (user == null) {
      print("USER LOGIN IS NULL");
    } else {
      print("USER LOGIN --> ${user.email}");
      Get.offAllNamed(Routes.CHOICE_THEME);
    }
  }

  _signupUser() async {
    if (!_checkSignupInfo()) {
      update();
      return;
    }
    _isLoading = true;
    update();
    UserModel user = await authRepository.signup(_pseudo, _email, _password);
    _isLoading = false;
    update();
    if (user == null) {
      print("USER SIGNUP IS NULL");
    } else {
      print("USER SIGNUP --> ${user.email}");
      Get.offAllNamed(Routes.CHOICE_THEME);
    }
  }
  
}
