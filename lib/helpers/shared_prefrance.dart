import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences?> init() async {
    _prefsInstance = await SharedPreferences.getInstance();

    return _prefsInstance;
  }

  static Future<String?> getDataFromPreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? isStored = prefs.getString(key);
    return isStored;
  }

  static Future<bool> storeDataToPreferences(String key, String? value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isStored = await prefs.setString(key, value ?? "");
    return isStored;
  }

  static Future<bool> storeBoolDataToPreferences(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isStored = await prefs.setBool(key, value);

    return isStored;
  }

  static Future<bool?> getBoolDataFromPreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isStored = prefs.getBool(key);
    return isStored;
  }

  static Future<bool?> removeData(String key) async {
    return await _prefsInstance?.remove(key);
  }
}
