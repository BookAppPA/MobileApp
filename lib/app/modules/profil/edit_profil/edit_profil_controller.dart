import 'package:book_app/app/data/repository/user_repository.dart';
import 'package:book_app/app/modules/widgets_global/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../user_controller.dart';

class EditProfilController extends GetxController {
  static EditProfilController get to => Get.find();

  final UserRepository repository;
  EditProfilController({@required this.repository})
      : assert(repository != null);

  final TextEditingController _bioController = TextEditingController();
  TextEditingController get bioController => this._bioController;

  Map<String, dynamic> _beforeValues = {};
  bool _isError = false;
  int get nbBio => _bioController.text.length;
  String get bio => _bioController.text.trim();

  @override
  void onInit() {
    super.onInit();
    var user = UserController.to.user;
    _bioController.text = user.bio;
    _initListeners();
    _beforeValues.addAll({
      'bio': _bioController.text,
    });
  }

  @override
  void onClose() {
    super.onClose();
    _bioController.dispose();
  }

  _initListeners() {
    _bioController.addListener(() {
      update(["nbBio"]);
    });
  }

  validateModif() async {
    print(bio);
    if (bio.length > 0) {
      var res = await repository.updateUser(UserController.to.user.id, {"bio": bio});
      print("Res UPDATE BIO --> $res");
      if (res) {
        UserController.to.updateBio(bio);
      } else
        CustomSnackbar.snackbar("Erreur de synchronisation...");
    }
    Get.back();
    /*_isError = false;
    if (_profilImage.length == 0) {
      _isError = true;
      CustomSnackbar.snackbar("1 Photo obligatoire minimum");
    }
    if (_checkEditInfo()) _updateData();
    if (!_sameListPicture()) _updatePicture();
    if (!_isError) {
      PhotoGridController.to.deleteAllFileCache();
      Get.back();
    } */
  }
}
