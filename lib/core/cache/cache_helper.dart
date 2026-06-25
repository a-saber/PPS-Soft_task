import 'package:shared_preferences/shared_preferences.dart';

import 'cache_data.dart';

class CacheHelper {

  static late SharedPreferences sharedPreferences;
  static Future init() async // called in main
  {
    sharedPreferences = await SharedPreferences.getInstance();
    CacheData.init();
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is List<String>) {
      return await sharedPreferences.setStringList(key, value);
    }
    else if (value is int) {
      return await sharedPreferences.setInt(key, value);
    }
    else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    }
    else if(value is double) {
      return await sharedPreferences.setDouble(key, value);
    }
    else
    {
      return await sharedPreferences.setString(key, value.toString());
    }
  }

  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }
}