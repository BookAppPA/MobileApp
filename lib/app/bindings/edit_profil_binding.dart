import 'package:book_app/app/data/repository/user_repository.dart';
import 'package:book_app/app/modules/profil/edit_profil/edit_profil_controller.dart';
import 'package:get/get.dart';

class EditProfilBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditProfilController(repository: UserRepository()));
  }

}