import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs {
  static const String _keyToken = 'token';
  static const String _keyUser = 'user_json';
  final SharedPreferences _prefs;
  AppPrefs(this._prefs);

  Future<void> saveToken(String token) async {
    await _prefs.setString(_keyToken, token);
  }

  String? getToken() {
    return _prefs.getString(_keyToken);
  }

  Future<void> removeToken() async {
    await _prefs.remove(_keyToken);
  }

  bool isLoggedIn() {
    return _prefs.containsKey(_keyToken);
  }

  Future<void> saveUserJson(Map<String, dynamic> userJson) async {
    await _prefs.setString(_keyUser, jsonEncode(userJson));
  }

  Map<String, dynamic>? getUserJson() {
    final stored = _prefs.getString(_keyUser);
    if (stored == null) return null;
    final decoded = jsonDecode(stored);
    if (decoded is Map<String, dynamic>) {
      return Map<String, dynamic>.from(decoded);
    }
    return null;
  }

  Future<void> removeUser() async {
    await _prefs.remove(_keyUser);
  }

  Future<void> clearSession() async {
    await Future.wait([removeToken(), removeUser()]);
  }
}
