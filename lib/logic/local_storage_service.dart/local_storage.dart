// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService? _instance;
  static SharedPreferences? _preferences;
  final getStorage = GetStorage();

  static Future<LocalStorageService?> getInstance() async {
    _instance ??= LocalStorageService();
    _preferences ??= await SharedPreferences.getInstance();

    return _instance;
  }

  // updated _saveToDisk function that handles all types
  void saveToDisk<T>(String key, T content) {
    debugPrint(
        '(TRACE) LocalStorageService:_saveToDisk. key: $key value: $content');

    if (content is String) {
      _preferences!.setString(key, content);
    }
    if (content is bool) {
      _preferences!.setBool(key, content);
    }
    if (content is int) {
      _preferences!.setInt(key, content);
    }
    if (content is double) {
      _preferences!.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences!.setStringList(key, content);
    }
  }

  dynamic getFromDisk(String key) {
    var value = _preferences!.get(key);
    debugPrint(
        '(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  Future<void> removeFromDisk(String key) async {
    debugPrint('(TRACE) LocalStorageService:_removeFromDisk. key: $key');
    await _preferences!.remove(key);
  }

  Future<void> empty() async {
    await _preferences!.clear();
  }

  /// GetStorage
  Future<void> getsaveToDisk(String key, String content) async {
    debugPrint(
        '(TRACE) LocalStorageService:_getgetFromDisk. key: $key value: $content');

    await getStorage.write(key, content);
  }

  dynamic getreadFromDisk(String key) {
    var value = getStorage.read(key);

    debugPrint(
        '(TRACE) LocalStorageService:_getgetFromDisk. key: $key value: $value');
    return value;
  }

  Future<void> geteraseToDisk(String key) async {
    debugPrint('(TRACE) LocalStorageService:_getremoveFromDisk. key: $key');
    await getStorage.remove(key);
  }
}
