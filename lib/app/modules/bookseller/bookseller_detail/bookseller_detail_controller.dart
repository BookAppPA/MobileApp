import 'package:book_app/app/data/model/bookseller.dart';
import 'package:book_app/app/data/repository/bookseller_repository.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class BookSellerDetailController extends GetxController {
  static BookSellerDetailController get to => Get.find();

  BookSellerDetailController(
      {@required this.repository, @required this.bookSeller})
      : assert(repository != null),
        assert(bookSeller != null);

  final BookSellerRepository repository;
  final BookSeller bookSeller;
  int bookPosition = 0;
  bool isMe;

  @override
  void onInit() {
    super.onInit();
    isMe = UserController.to.bookseller.id == bookSeller.id;
    _getListBooksWeek();
  }

  _getListBooksWeek() async {
    bookSeller.listBooksWeek = await repository.getListBooksWeek(bookSeller.id);
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
}
