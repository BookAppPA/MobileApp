import 'package:shared_preferences/shared_preferences.dart';

class SharePreferenceHelper {
  static const _IS_FIRST_TIME = "ISFIRSTTIME";
  SharedPreferences _prefs;

  static final SharePreferenceHelper _instance = SharePreferenceHelper._init();
  static SharePreferenceHelper get instance => _instance;

  SharePreferenceHelper._init();

  Future<bool> isFirstTime() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool(_IS_FIRST_TIME) ?? true;
  }

  setFirstTime(bool res) async {
    await _prefs.setBool(_IS_FIRST_TIME, res);
  }

}
