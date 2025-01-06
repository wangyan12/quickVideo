import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


class StorageUtil {
  static final StorageUtil _instance = StorageUtil._();
  factory StorageUtil() => _instance;
  static SharedPreferences? _prefs;

  StorageUtil._();

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<bool> setJSON(String key, dynamic jsonVal) {
    String jsonString = jsonEncode(jsonVal);
    return _prefs!.setString(key, jsonString);
  }

  dynamic getJSON(String key) {
    String? jsonString = _prefs!.getString(key);
    return jsonString == null ? null : jsonDecode(jsonString);
  }

  Future<bool> setList(String key, List<String> list) {
    return _prefs!.setStringList(key, list);
  }

  List<String> getList(String key) {
    return _prefs!.getStringList(key) ?? [];
  }

  Future<bool> setString(String key, String val) {
    return _prefs!.setString(key, val);
  }

  String getString(String key) {
    return _prefs!.getString(key) ?? '';
  }

  Future<bool> setBool(String key, bool val) {
    return _prefs!.setBool(key, val);
  }

  bool getBool(String key) {
    return _prefs!.getBool(key) ?? false;
  }

  Future<bool> remove(String key) {
    return _prefs!.remove(key);
  }

  bool whetherToLogin() {
    String? auth = _prefs!.getString('user_auth');
    if (auth != null) {
      return true;
    }
    return false;
  }

  // 用户 auth
  static const userAuth = 'user_auth';
  // 账号列表
  static const accountList = 'account_list';
  // 当前账号
  static const currentAccountInformation = 'current_account_information';
  // 下载记录
  static const downloadRecord = 'download_record';

}