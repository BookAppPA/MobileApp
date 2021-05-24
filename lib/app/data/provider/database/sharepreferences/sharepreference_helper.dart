import 'package:shared_preferences/shared_preferences.dart';

class SharePreferenceHelper {
  static const _IS_FIRST_TIME = "ISFIRSTTIME";
  static const _STARTUP_VIEW = "startup_view";
  static const _EXPLORER_VIEW = "explorer_view";
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

  Future<String> getStartupView() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(_STARTUP_VIEW);
  }

  setStartupView(String view) async {
    await _prefs.setString(_STARTUP_VIEW, view);
  }

  Future<String> getExplorerView() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(_EXPLORER_VIEW);
  }

  setExplorerView(String view) async {
    await _prefs.setString(_EXPLORER_VIEW, view);
  }
}
