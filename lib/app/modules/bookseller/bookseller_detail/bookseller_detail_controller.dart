import 'package:book_app/app/data/model/bookseller.dart';
import 'package:book_app/app/data/model/following.dart';
import 'package:book_app/app/data/repository/auth_repository.dart';
import 'package:book_app/app/data/repository/bookseller_repository.dart';
import 'package:book_app/app/modules/profil/profil_controller.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:book_app/app/translations/app_translations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class BookSellerDetailController extends GetxController {
  static BookSellerDetailController get to => Get.find();

  BookSellerDetailController(
      {@required this.repository, this.bookSeller, this.bookSellerId})
      : assert(repository != null);

  final BookSellerRepository repository;
  BookSeller bookSeller;
  final String bookSellerId;
  int bookPosition = 0;
  bool isMe;
  String errorMessage = "";
  bool loadData = true;

  _errorLoad() {
    errorMessage = AppTranslation.serverError.tr;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    if (bookSeller == null && bookSellerId != null)
      _getBookSeller();
    else if (bookSeller == null && bookSellerId == null) {
      _errorLoad();
      return;
    } else {
      loadData = false;
      if (UserController.to.isBookSeller)
        isMe = bookSeller.id == UserController.to.bookseller.id;
      else
        isMe = false;
      update();
    }
    if (bookSeller != null)
      _getListBooksWeek();
  }

  _getBookSeller() async {
    print("GET BOOKSELLER");
    bookSeller = await repository.getBookSellerById(bookSellerId);
    if (bookSeller != null) {
      loadData = false;
      if (UserController.to.isBookSeller)
        isMe = bookSeller.id == UserController.to.bookseller.id;
      else
        isMe = false;
    } else {
      _errorLoad();
      return;
    }
    update();
    _getListBooksWeek();
  }

  _getListBooksWeek() async {
    var list = await repository.getListBooksWeek(bookSeller.id);
    if (isMe) {
      UserController.to.setListBooksWeek(list);
    } else
      bookSeller.listBooksWeek = list;
    update();
  }

  callBookSeller() async {
    var url = "tel:${bookSeller.phone}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  changePositionBook(int index) {
    bookPosition = index;
    update();
  }

  updateBio(String bio) {
    bookSeller.bio = bio;
    update();
  }

  updatePhone(String phone) {
    bookSeller.phone = phone;
    update();
  }

  updateOpenHours(Map hours) {
    bookSeller.openHour = hours;
    update();
  }

  clickLogout() async {
    print("logout");
    var result = await AuthRepository().logout();
    if (result) {
      Get.delete<ProfilController>();
      Get.delete<BookSellerDetailController>();
      Get.delete<UserController>();
      Get.offAllNamed(Routes.AUTH);
    }
    else
      print("LOGOUT ERREUR....");
  }

  followUser(BookSeller user) async {
    var res = await UserController.to.followUser(Following(
      id: bookSeller.id,
      pseudo: bookSeller.name,
      isBookSeller: true,
      address: bookSeller.address,
      nbFollowers: bookSeller.nbFollowers,
    ));
    if (res) {
      bookSeller.nbFollowers++;
      update();
    }
  }

  unFollowUser(BookSeller user) async {
    var res = await UserController.to.unFollowUser(Following(
      id: bookSeller.id,
      pseudo: bookSeller.name,
      isBookSeller: true,
      address: bookSeller.address,
      nbFollowers: bookSeller.nbFollowers,
    ));
    if (res) {
      bookSeller.nbFollowers--;
      update();
    }
  }
}
