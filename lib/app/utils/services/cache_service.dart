import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static late SharedPreferences prefs;
  static bool? isLoged;

  static Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void setBool(String key, bool value) async {
    prefs.setBool(key, value);
  }

  static void getBool(String key) {
    isLoged = prefs.getBool(key);
  }

  static void removeBool(String key) {
    prefs.remove(key);
  }
}
