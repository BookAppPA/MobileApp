import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/model/following.dart';
import 'package:book_app/app/data/model/rating.dart';
import 'package:book_app/app/data/model/user.dart';
import 'package:book_app/app/data/repository/auth_repository.dart';
import 'package:book_app/app/data/repository/user_repository.dart';
import 'package:book_app/app/modules/bookseller/bookseller_detail/bookseller_detail_controller.dart';
import 'package:book_app/app/modules/dialog/basic_dialog.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:book_app/app/translations/app_translations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'user_controller.dart';

class ProfilController extends GetxController {
  static ProfilController get to => Get.find();

  final AuthRepository authRepository;
  final UserRepository userRepository;
  ProfilController(
      {@required this.authRepository,
      @required this.userRepository,
      this.user,
      this.userId,
      this.reloadMe: false})
      : assert(authRepository != null),
        assert(userRepository != null);

  UserModel user;
  final String userId;

  String errorMessage = "";
  bool loadData = true;
  bool isMe = false;
  bool reloadMe = false;

  List<Book> books = [];
  List<Rating> ratings = [];

  final _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    loadData = true;
    update();
    if (reloadMe || (user == null && userId != null))
      _getUser();
    else if (user == null && userId == null) {
      _errorLoad();
      return;
    } else {
      loadData = false;
      if (!UserController.to.isBookSeller)
        isMe = user.id == (UserController.to.isAuth ? UserController.to.user.id : false);
      else
        isMe = false;
      update();
    }
    if (user != null) _getData();
  }

  _getUser() async {
    print("GET USER");
    user = await userRepository.getUserById(userId ?? user.id);
    if (user != null) {
      if (user.isBlocked) _errorBlocked();
      loadData = false;
      if (!UserController.to.isBookSeller) {
        if (reloadMe) UserController.to.user = user;
        isMe = user.id == (UserController.to.isAuth ? UserController.to.user.id : false);
        update();
      } else
        isMe = false;
    } else {
      _errorLoad();
      return;
    }
    update();
    _getData();
  }

  _errorLoad() {
    errorMessage = AppTranslation.serverError.tr;
    update();
  }

  _errorBlocked() {
    errorMessage = AppTranslation.profilBlocked.tr;
    update();
  }

  _getData() async {
    if ((user != null && user.id != null) || userId != null) {
      if (!UserController.to.isBookSeller) {
        isMe = (userId ?? user.id) == (UserController.to.isAuth ? UserController.to.user.id : false);
        var isFollow = !UserController.to.isAuth ? false : await userRepository.isFollow(
            UserController.to.user.id, userId ?? user.id);
        bool isAlreadyContain = !UserController.to.isAuth ? false : UserController.to.user.listFollowing.firstWhere(
                (item) => item.id == userId ?? user.id,
                orElse: () => null) !=
            null;
        if (!UserController.to.isBookSeller && isFollow && !isAlreadyContain)
          UserController.to.addFollowingUser(Following(
            id: userId ?? user.id,
            pseudo: user.pseudo,
            isBookSeller: false,
            picture: user.picture,
            nbFollowers: user.nbFollowers,
          ));
        update();
      } else
        isMe = false;
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
    if (result) {
      Get.delete<ProfilController>();
      Get.delete<BookSellerDetailController>();
      Get.delete<UserController>();
      Get.offAllNamed(Routes.AUTH);
    } else
      print("LOGOUT ERREUR....");
  }

  changePicture() {
    if (GetPlatform.isAndroid)
      BasicDialog.showConfirmPictureDialog(onConfirm: () async {
        _getPhoto();
      });
    else 
      _getPhoto();
  }

  _getPhoto() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      UserController.to.isLoadingPicture(true);
      String urlPic = await userRepository.changeUserPicture(
          UserController.to.user.id, pickedFile.path);
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

  clickFinishBook() {
    Get.toNamed(Routes.SEARCH);
  }

  followUser(UserModel user) async {
    Following following = Following(
      id: user.id,
      pseudo: user.pseudo,
      isBookSeller: false,
      picture: user.picture,
      nbFollowers: user.nbFollowers,
    );
    var res = await UserController.to.followUser(following);
    if (res) {
      user.nbFollowers++;
      update();
    }
  }

  unFollowUser(UserModel user) async {
    Following following = Following(
      id: user.id,
      pseudo: user.pseudo,
      isBookSeller: false,
      picture: user.picture,
      nbFollowers: user.nbFollowers,
    );
    var res = await UserController.to.unFollowUser(following);
    if (res) {
      user.nbFollowers--;
      update();
    }
  }
}
