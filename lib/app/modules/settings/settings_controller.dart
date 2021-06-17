import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsController extends GetxController {
  String version = "v1.0";

  @override
  void onInit() {
    super.onInit();
    _getVersionApp();
  }

  _getVersionApp() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    update();
  }
}
