import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences prefs;

  // _________ initialization ____________________
  static Future<void> intSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  // _________ Set Data ____________________
  static Future<void> setData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else {
      await prefs.setStringList(key, value);
    }
  }

  // _________ Get Data ____________________
  static dynamic getData({required String key}) {
    return prefs.get(key);
  }

  // _________ Remove Data ____________________
  static dynamic removeData({required String key}) {
    prefs.remove(key);
  }

  // _________ Remove All Data ____________________
  static void removeAllData() {
    prefs.clear();
  }
}
