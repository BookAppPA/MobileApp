import 'package:book_app/app/data/model/bookseller.dart';
import 'package:book_app/app/data/model/company.dart';
import 'package:book_app/app/data/model/user.dart';
import 'package:book_app/app/data/repository/auth_repository.dart';
import 'package:book_app/app/data/repository/user_repository.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:book_app/app/modules/widgets_global/snackbar.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:book_app/app/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AuthView { LOGIN, SIGNUP, PRO }

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  final UserRepository userRepository;
  final AuthRepository authRepository;
  final bool isBlocked;
  AuthController(
      {@required this.userRepository,
      @required this.authRepository,
      @required this.isBlocked})
      : assert(userRepository != null),
        assert(authRepository != null);

  TextEditingController _pseudoController = TextEditingController();
  TextEditingController get pseudoController => this._pseudoController;
  TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => this._emailController;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => this._passwordController;
  TextEditingController _siretController = TextEditingController();
  TextEditingController get siretController => this._siretController;

  bool _isEmailValid = true;
  bool get isEmailValid => this._isEmailValid;
  bool _isPasswordValid = true;
  bool get isPasswordValid => this._isPasswordValid;
  bool _isPseudoValid = true;
  bool get isPseudoValid => this._isPseudoValid;
  bool _isSiretValid = true;
  bool get isSiretValid => this._isSiretValid;

  AuthView _authView = AuthView.LOGIN;
  AuthView get authView => this._authView;

  bool _isLoading = false;
  bool get isLoading => this._isLoading;

  String get _pseudo => _pseudoController.text.trim();
  String get _email => _emailController.text.trim();
  String get _password => _passwordController.text.trim();
  String get _siret => _siretController.text.trim();

  Company _company;

  @override
  void onInit() {
    super.onInit();
    Get.put(UserController(repository: userRepository));
    if (isBlocked) {
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => CustomSnackbar.snackbar("Votre compte à été bloqué"));
    }
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
    _siretController.addListener(() {
      _isSiretValid = true;
      update();
    });
  }

  changeAuthViewToProAccount() {
    _authView = AuthView.PRO;
    update();
  }

  changeAuthMode() {
    if (_authView == AuthView.LOGIN)
      _authView = AuthView.SIGNUP;
    else
      _authView = AuthView.LOGIN;
    _isEmailValid = true;
    _isPasswordValid = true;
    _isPseudoValid = true;
    _isSiretValid = true;
    update();
  }

  submitAuth() async {
    if (_authView == AuthView.LOGIN) {
      print("Login process");
      await _loginUser();
    } else if (_authView == AuthView.SIGNUP) {
      print("Signup process");
      await _signupUser();
    } else {
      print("pro process");
      await _signupProUser();
    }
  }

  bool _validEmail(String email) {
    var _email = email.trim();
    var _index = _email.indexOf("@");
    var _valid = false;
    if (_index != -1)
      _valid = checkIsEmailFormat(_email);
    _isEmailValid = _valid;
    return _valid;
  }

  _checkSiretValid() async {
    var _siretTemp = _siret;
    _isSiretValid = _siretTemp.length == 9 || _siretTemp.length == 14;
    if (!_isSiretValid) {
      CustomSnackbar.snackbar("Le n° SIREN doit contenir 9 caractères. Le n° SIRET 14 caractères");
      return false;
    }
    if (!isOnlyNumeric(_siretTemp)) {
      CustomSnackbar.snackbar("Le n° SIREN ou SIRET doit contenir uniquement des chiffres");
      return false;
    }
    if (_company != null &&
        (_company.siren == _siretTemp || _company.siret == _siretTemp))
      return true;
    if (_siretTemp.length == 9)
      _company = await authRepository.checkSiren(_siretTemp);
    else
      _company = await authRepository.checkSiret(_siretTemp);
    if (_company == null) {
      CustomSnackbar.snackbar("Erreur du serveur... Réessayer plus tard");
      return false;
    }
    if (_company.codeActivity != "4761Z") {
      CustomSnackbar.snackbar("Le n° SIREN ou SIRET ne correspond pas à une entreprise de Commerce de détail de livres en magasin spécialisé", shortDuration: false);
      return false;
    }
    return true;
  }

  bool _checkLoginInfo() {
    _isPasswordValid = _password.length >= 6 && _password.length <= 30;
    if (!_validEmail(_email)) {
      CustomSnackbar.snackbar("Email invalide");
      return false;
    }
    if (!_isPasswordValid) {
      CustomSnackbar.snackbar("Le mot de passe doit contenir entre 6 et 30 caractères");
      return false;
    }
    return true;
  }

  bool _checkSignupInfo() {
    _isPseudoValid = _pseudo.length >= 3 && _pseudo.length <= 15;
    if (!_isPseudoValid) {
      CustomSnackbar.snackbar("Le pseudo doit contenir entre 3 et 15 caractères");
      return false;
    }
    _isPseudoValid = _isPseudoValid && stringIsPseudo(_pseudo);
    if (!_isPseudoValid) {
      CustomSnackbar.snackbar("Le pseudo peut contenir uniquement des lettres, chiffres et underscores");
      return false;
    }
    return _isPseudoValid && _checkLoginInfo();
  }

  Future<bool> _checkSignupProInfo() async {
    _isPseudoValid = _pseudo.length >= 3 && _pseudo.length <= 30;
    if (!_isPseudoValid) {
      CustomSnackbar.snackbar("Le pseudo doit contenir entre 3 et 30 caractères");
      return false;
    }
    _isPseudoValid = _isPseudoValid && stringIsName(_pseudo);
    if (!_isPseudoValid) {
      CustomSnackbar.snackbar("Le pseudo peut contenir uniquement des lettres, espaces, tirets et apostrophes");
      return false;
    }
    var res = _isPseudoValid && _checkLoginInfo();
    if (!res) return false;
    var _isValid = await _checkSiretValid();
    return res && _isValid;
  }

  _loginUser() async {
    if (!_checkLoginInfo()) {
      update();
      return;
    }
    _isLoading = true;
    update();
    var user = await authRepository.login(_email, _password);
    _isLoading = false;
    update();
    if (user == null) {
      print("USER LOGIN IS NULL");
    } else {
      print("USER LOGIN --> ${user.email}");
      if (user is UserModel) {
        UserController.to.user = user;
        await userRepository.configurePushNotification(user.id);
      }
      else
        UserController.to.bookseller = user;
      Get.offAllNamed(Routes.SQUELETON);
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
      UserController.to.user = user;
      await userRepository.configurePushNotification(user.id);
      Get.offAllNamed(Routes.CHOICE_THEME);
    }
  }

  _signupProUser() async {
    _isLoading = true;
    update();
    if (!(await _checkSignupProInfo())) {
      _isSiretValid = false;
      _isLoading = false;
      update();
      return;
    }
    BookSeller bookseller = BookSeller(
      name: _pseudo,
      email: _email,
      address: _company.address,
      coord: _company.coord,
      siret: _company.siret,
      nbFollowers: 0,
    );
    bookseller = await authRepository.signupBookSeller(bookseller, _password);
    _isLoading = false;
    update();
    if (bookseller == null) {
      print("USER PRO SIGNUP IS NULL");
    } else {
      print("USER PRO SIGNUP --> ${bookseller.email}");
      UserController.to.bookseller = bookseller;
      Get.offAllNamed(Routes.SQUELETON);
    }
  }
}
