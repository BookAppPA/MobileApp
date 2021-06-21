import 'package:book_app/app/data/repository/user_repository.dart';
import 'package:book_app/app/modules/bookseller/bookseller_detail/bookseller_detail_controller.dart';
import 'package:book_app/app/modules/widgets_global/snackbar.dart';
import 'package:book_app/app/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../user_controller.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'dart:convert';

class EditProfilController extends GetxController {
  static EditProfilController get to => Get.find();

  final UserRepository repository;
  EditProfilController({@required this.repository})
      : assert(repository != null);

  final bool isBookSeller = UserController.to.isBookSeller;

  final TextEditingController _bioController = TextEditingController();
  TextEditingController get bioController => this._bioController;
  final TextEditingController _phoneController = TextEditingController();
  TextEditingController get phoneController => this._phoneController;

  Map _beforeValues = {};
  int get nbBio => _bioController.text.length;
  String get bio => _bioController.text.trim();

  String countryCode = '+33';
  String get phone => _phoneController.text.trim().replaceAll(" ", "");

  final List<String> days = [
    "Lundi",
    "Mardi",
    "Mercredi",
    "Jeudi",
    "Vendredi",
    "Samedi",
    "Dimanche"
  ];

  List<String> hoursOfDays = [];

  Map openHours = {};

  @override
  void onInit() {
    super.onInit();
    if (isBookSeller) {
      _bioController.text = UserController.to.bookseller.bio;
      if (UserController.to.bookseller.phone != "") {
        var phone =
            UserController.to.bookseller.phone.substring(countryCode.length);
        _phoneController.text = phone;
      }
      openHours = UserController.to.bookseller.openHour;
      if (openHours.isEmpty)
        hoursOfDays = List.generate(7, (index) => "Pas d'horaires spécifiés");
      else {
        hoursOfDays = [
          openHours["monday"] ?? "Pas d'horaires spécifiés",
          openHours["tuesday"] ?? "Pas d'horaires spécifiés",
          openHours["wednesday"] ?? "Pas d'horaires spécifiés",
          openHours["thursday"] ?? "Pas d'horaires spécifiés",
          openHours["friday"] ?? "Pas d'horaires spécifiés",
          openHours["saturday"] ?? "Pas d'horaires spécifiés",
          openHours["sunday"] ?? "Pas d'horaires spécifiés"
        ];
      }
      _beforeValues
          .addAll({'phone': _phoneController.text, 'open_hour': openHours});
    } else
      _bioController.text = UserController.to.user.bio;
    _initListeners();
    _beforeValues.addAll({
      'bio': _bioController.text,
    });
    update();
  }

  @override
  void onClose() {
    super.onClose();
    _bioController.dispose();
    _phoneController.dispose();
  }

  _initListeners() {
    _bioController.addListener(() {
      update(["nbBio"]);
    });
  }

  changeCountryCode(CountryCode code) {
    countryCode = code.dialCode;
    update();
  }

  changeHoursDay(String day, String newOpenHours) {
    switch (day) {
      case "Lundi":
        openHours["monday"] = newOpenHours;
        _beforeValues.addAll({'open_hour': openHours});
        break;
      case "Mardi":
        openHours["tuesday"] = newOpenHours;
        _beforeValues.addAll({'open_hour': openHours});
        break;
      case "Mercredi":
        openHours["wednesday"] = newOpenHours;
        _beforeValues.addAll({'open_hour': openHours});
        break;
      case "Jeudi":
        openHours["thursday"] = newOpenHours;
        _beforeValues.addAll({'open_hour': openHours});
        break;
      case "Vendredi":
        openHours["friday"] = newOpenHours;
        _beforeValues.addAll({'open_hour': openHours});
        break;
      case "Samedi":
        openHours["saturday"] = newOpenHours;
        _beforeValues.addAll({'open_hour': openHours});
        break;
      case "Dimanche":
        openHours["sunday"] = newOpenHours;
        _beforeValues.addAll({'open_hour': openHours});
        break;
    }
  }

  validateModif() async {
    if (isBookSeller) {
      Map<String, String> data = {};
      if (bio.length > 0) {
        data["bio"] = bio;
      }
      if (phone.length > 0 &&
          isPhoneNumber(phone) &&
          (countryCode + phone) != UserController.to.bookseller.phone) {
        data["phone"] = countryCode + phone;
      }
      data["open_hour"] = json.encode(_beforeValues["open_hour"]);
      print(data["phone"]);
      var res = await repository.updateUser(
          UserController.to.bookseller.id, data,
          isBookSeller: true);
      print("Res UPDATE BOOKSELLER --> $res");
      if (res) {
        UserController.to.updateBio(bio, true);
        if (data["phone"] != null) {
          UserController.to.updatePhone(data["phone"]);
          BookSellerDetailController.to.updatePhone(data["phone"]);
        }
        UserController.to.updateOpenHours(_beforeValues["open_hour"]);
        BookSellerDetailController.to.updateBio(bio);

        BookSellerDetailController.to
            .updateOpenHours(_beforeValues["open_hour"]);
        update();
      } else
        CustomSnackbar.snackbar("Erreur de synchronisation...");
    } else {
      if (bio.length > 0 && bio != _beforeValues["bio"]) {
        var res = await repository
            .updateUser(UserController.to.user.id, {"bio": bio});
        print("Res UPDATE BIO --> $res");
        if (res) {
          UserController.to.updateBio(bio, false);
        } else
          CustomSnackbar.snackbar("Erreur de synchronisation...");
      }
    }
    Get.back();
  }
}
