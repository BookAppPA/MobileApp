import 'package:book_app/app/data/model/bookseller.dart';
import 'package:book_app/app/data/model/following.dart';
import 'package:book_app/app/data/repository/bookseller_repository.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookSellerMainController extends GetxController {
  static BookSellerMainController get to => Get.find();

  BookSellerMainController({@required this.repository})
      : assert(repository != null);

  final BookSellerRepository repository;

  final TextEditingController _editTextController = TextEditingController();
  TextEditingController get editTextController => this._editTextController;

  String get _searchText => _editTextController.text.trim();

  bool get _checkValid => _searchText.length >= 3 && _searchText.length <= 50;

  bool searching = true;

  List<BookSeller> booksellers = [];

  @override
  void onInit() {
    super.onInit();
    _getListBookseller();
  }

  _getListBookseller() async {
    booksellers = await repository.getInitListBookSeller();
    searching = false;
    update();
  }

  cancelSearch() {
    Get.focusScope.unfocus();
    _editTextController.clear();
  }

  search() async {
    Get.focusScope.unfocus();
    print("$_searchText");
    if (_checkValid) {
      searching = true;
      update();
      booksellers = await repository.searchBookSeller(_searchText);
      searching = false;
      update();
    }
  }

  followBookSeller(int index, BookSeller bookSeller) async {
    var res = await UserController.to.followUser(Following(
      id: bookSeller.id,
      pseudo: bookSeller.name,
      isBookSeller: true,
      address: bookSeller.address,
      nbFollowers: bookSeller.nbFollowers,
    ));
    if (res) {
      booksellers[index].nbFollowers++;
      update();
    }
  }

  unFollowBookSeller(int index, BookSeller bookSeller) async {
    var res = await UserController.to.unFollowUser(Following(
      id: bookSeller.id,
      pseudo: bookSeller.name,
      isBookSeller: true,
      address: bookSeller.address,
      nbFollowers: bookSeller.nbFollowers,
    ));
    if (res) {
      booksellers[index].nbFollowers--;
      update();
    }
  }
}