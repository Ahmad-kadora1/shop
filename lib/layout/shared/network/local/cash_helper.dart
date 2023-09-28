import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static SharedPreferences? sharedPrefernaces;
  static init() async {
    sharedPrefernaces = await SharedPreferences.getInstance();
  }

  static Future<bool> putData({
    required String key,
    required bool value,
  }) async {
    return await sharedPrefernaces?.setBool(key, value) ?? false;
  }

  static dynamic getdata({required String key}) {
    return sharedPrefernaces?.get(key);
  }

  static Future<bool?> removedata({required String key}) async {
    return await sharedPrefernaces?.remove(key);
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPrefernaces?.setString(key, value) ?? false;
    }

    if (value is bool) {
      return await sharedPrefernaces?.setBool(key, value) ?? false;
    }
    if (value is int) {
      return await sharedPrefernaces?.setInt(key, value) ?? false;
    }

    return await sharedPrefernaces?.setDouble(key, value) ?? false;
  }
}
