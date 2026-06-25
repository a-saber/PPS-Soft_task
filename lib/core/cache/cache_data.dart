import 'dart:convert';

import 'cache_helper.dart';
import 'cache_keys.dart';


class CacheDataTemp<T> {
  final String key;
  final dynamic Function(T value)? toJson;
  final T Function(dynamic json)? fromJson;
  T? _value;

  CacheDataTemp({
    required this.key,
    this.toJson,
    this.fromJson,
  });

  T? get value {
    if (_value != null) return _value;

    final raw = CacheHelper.getData(key: key);

    // Direct type match (primitives and List<String>)
    if (raw is T?)
    {
      _value = raw;
    }
    else
    {
      try {
        // Complex object or list, decode from JSON
        if (raw is String && fromJson != null) {
          final decoded = jsonDecode(raw);
          _value = fromJson!(decoded);
        }
      } catch (e) {
        print('ERROR: Failed to read cache key: $key. Raw: $raw');
      }
    }

    return _value;
  }

  Future<bool> set(T value) async {
    _value = value;

    try {
      if (toJson != null) {
        final jsonStr = jsonEncode(toJson!(value));
        return await CacheHelper.saveData(key: key, value: jsonStr);
      } else {
        return await CacheHelper.saveData(key: key, value: value);
      }
    } catch (e) {
      print('ERROR: Failed to save cache data for key: $key. Value: $value');
      return false;
    }
  }

  Future<bool> remove() async {
    _value = null;
    return await CacheHelper.removeData(key: key);
  }
}

class CacheData {
  static late final CacheDataTemp<String> lang;
  static late final CacheDataTemp<String> themeMode;

  static void init() // called in CacheHelper.init()
  {
    lang = CacheDataTemp<String>(key: CacheKeys.langKey);
    themeMode = CacheDataTemp<String>(key: CacheKeys.themeModeKey);
  }

}
