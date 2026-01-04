import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final SharedPreferences prefs;

  AppPreferences(this.prefs);

  // 🔐 Token
  Future<void> setAuthToken(String token) async =>
      await prefs.setString('auth_token', token);

  String? getAuthToken() => prefs.getString('auth_token');

  Future<void> removeAuthToken() async =>
      await prefs.remove('auth_token');

  // 👤 Username
  Future<void> setUsername(String name) async =>
      await prefs.setString('username', name);

  String? getUsername() => prefs.getString('username');

  // 📱 Mobile Number
  Future<void> setMobileNo(String name) async =>
      await prefs.setString('mobile', name);

  String? getMobileNo() => prefs.getString('mobile');

  // 📧 Email
  Future<void> setEmail(String email) async =>
      await prefs.setString('email', email);
  String? getEmail() => prefs.getString('email');

  //set photo URL
  Future<void> setPhotoURL(String url) async =>
      await prefs.setString('photo_url', url);
  String? getPhotoURL() => prefs.getString('photo_url');

  // ✔️ Login Status
  Future<void> setLoggedIn(bool value) async =>
      await prefs.setBool('logged_in', value);

  bool isLoggedIn() => prefs.getBool('logged_in') ?? false;

  // ❌ Clear all
  Future<void> clearAll() async => await prefs.clear();
}
