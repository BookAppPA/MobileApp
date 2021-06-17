import 'package:book_app/app/data/model/bookseller.dart';
import 'package:book_app/app/data/repository/bookseller_repository.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class BookSellerDetailController extends GetxController {

  static BookSellerDetailController get to => Get.find();

  BookSellerDetailController({@required this.repository, @required this.bookSeller}) : assert(repository != null), assert(bookSeller != null);

  final BookSellerRepository repository;
  final BookSeller bookSeller;
  int bookPosition = 0;
  Location location;

  @override
  void onInit() {
    super.onInit();
    _getListBooksWeek();
    _transformAddressToCoord();
  }

  _getListBooksWeek() async {
    bookSeller.listBooksWeek = await repository.getListBooksWeek(bookSeller.id);
    update();
  }

  _transformAddressToCoord() async {
    var _locations = await locationFromAddress(bookSeller.address, localeIdentifier: "fr_FR");
    location = _locations.first;
    update();
  }

  callBookSeller() async {
    var url = "tel:+33${bookSeller.phone}";
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

}