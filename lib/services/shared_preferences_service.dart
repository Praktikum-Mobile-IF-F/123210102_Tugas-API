import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const _keyEmail = 'email';
  static const _keyPassword = 'password';
  static const _keyBirthday = 'birthday';

  static Future<void> saveUserCredentials(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEmail, email);
    await prefs.setString(_keyPassword, password);
  }

  static Future<Map<String, String>> getUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString(_keyEmail) ?? '';
    final password = prefs.getString(_keyPassword) ?? '';
    return {'email': email, 'password': password};
  }

  static Future<void> saveUserBirthday(String birthday) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyBirthday, birthday);
  }

  static Future<String> getUserBirthday() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyBirthday) ?? '';
  }
}
