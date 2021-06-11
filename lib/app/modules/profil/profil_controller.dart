import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/model/rating.dart';
import 'package:book_app/app/data/model/user.dart';
import 'package:book_app/app/data/repository/auth_repository.dart';
import 'package:book_app/app/data/repository/user_repository.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfilController extends GetxController {
  static ProfilController get to => Get.find();

  final AuthRepository authRepository;
  final UserRepository userRepository;
  ProfilController(
      {@required this.authRepository,
      @required this.userRepository,
      this.user,
      this.userId})
      : assert(authRepository != null),
        assert(userRepository != null);

  UserModel user;
  final String userId;

  String errorMessage = "";
  bool loadData = true;
  bool isMe = false;

  List<Book> books = [];
  List<Rating> ratings = [];

  final _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    if (user == null && userId != null)
      _getUser();
    else if (user == null && userId == null) {
      _errorLoad();
      return;
    } else {
      loadData = false;
      isMe = user.id == UserController.to.user.id;
      update();
    }
    _getData();
  }

  _getUser() async {
    print("GET USER");
    user = await userRepository.getUserById(userId);
    if (user != null) {
      if (user.isBlocked)
        _errorBlocked();
      loadData = false;
      isMe = user.id == UserController.to.user.id;
    } else
      _errorLoad();
    update();
  }

  _errorLoad() {
    errorMessage = "Erreur du serveur...";
    update();
  }

  _errorBlocked() {
    errorMessage = "Ce compte à été bloqué";
    update();
  }

  _getData() async {
    if ((user != null && user.id != null) || userId != null) {
      isMe = user.id == UserController.to.user.id;
      books = await userRepository.getUserListBook(userId ?? user.id);
      if (isMe) UserController.to.setListBooks(books);
      ratings = await userRepository.getLastRatings(userId ?? user.id, books);
      if (isMe) UserController.to.setLastRatings(ratings);
      update();
    }
  }

  clickLogout() async {
    print("logout");
    var result = await authRepository.logout();
    if (result)
      Get.offAllNamed(Routes.AUTH);
    else
      print("LOGOUT ERREUR....");
  }

  changePicture() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      UserController.to.isLoadingPicture(true);
      String urlPic = await userRepository.changeUserPicture(
          UserController.to.user.id,
          pickedFile.path,
          UserController.to.user.picture);
      UserController.to.updatePicture(urlPic);
      UserController.to.isLoadingPicture(false);
      user.picture = urlPic;
      update();
    } else {
      print('No image selected.');
    }
  }

  clickEditProfil() {
    Get.toNamed(Routes.EDIT_PROFIL);
  }

  clickFollow() {
    print("click follow user");
  }

  clickFinishBook() {
    Get.toNamed(Routes.SEARCH);
  }
}
