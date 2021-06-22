import 'package:book_app/app/data/repository/user_repository.dart';
import 'package:book_app/app/modules/profil/list_followers/list_followers_controller.dart';
import 'package:get/get.dart';

class ListFollowersBinding extends Bindings {
  @override
  void dependencies() {
    String userId = Get.arguments as String;
    Get.put(ListFollowersController(repository: UserRepository(), userId: userId));
  }
}