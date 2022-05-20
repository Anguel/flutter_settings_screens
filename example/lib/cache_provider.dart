import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

/// A cache access provider class for shared preferences using Hive library
class HiveCache extends CacheProvider {
  late Box _preferences;
  final String keyName = 'app_preferences';

  @override
  Future<bool> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    if (!kIsWeb) {
      final defaultDirectory = await getApplicationDocumentsDirectory();
      Hive.init(defaultDirectory.path);
    }
    if (Hive.isBoxOpen(keyName)) {
      _preferences = Hive.box(keyName);
    } else {
      _preferences = await Hive.openBox(keyName);
    }
    return true;
  }

  Set get keys => getKeys();

  @override
  bool getBool(String key) {
    return _preferences.get(key);
  }

  @override
  double getDouble(String key) {
    return _preferences.get(key);
  }

  @override
  int getInt(String key) {
    return _preferences.get(key);
  }

  @override
  String getString(String key) {
    return _preferences.get(key);
  }

  @override
  Future<bool> setBool(String key, bool? value, {bool? defaultValue}) async {
    await _preferences.put(key, value);
    return true;
  }

  @override
  Future<bool> setDouble(String key, double? value,
      {double? defaultValue}) async {
    await _preferences.put(key, value);
    return true;
  }

  @override
  Future<bool> setInt(String key, int? value, {int? defaultValue}) async {
    await _preferences.put(key, value);
    return true;
  }

  @override
  Future<bool> setString(String key, String? value,
      {String? defaultValue}) async {
    await _preferences.put(key, value);
    return true;
  }

  @override
  Future<bool> setObject<T>(String key, T value) async {
    await _preferences.put(key, value);
    return true;
  }

  @override
  bool containsKey(String key) {
    return _preferences.containsKey(key);
  }

  @override
  Set getKeys() {
    return _preferences.keys.toSet();
  }

  @override
  Future<bool> remove(String key) async {
    if (containsKey(key)) {
      await _preferences.delete(key);
    }
    return true;
  }

  @override
  Future<bool> removeAll() async {
    final keys = getKeys();
    await _preferences.deleteAll(keys);
    return true;
  }

  @override
  T getValue<T>(String key, T defaultValue) {
    var value = _preferences.get(key);
    if (value is T) {
      return value;
    }
    return defaultValue;
  }
}
