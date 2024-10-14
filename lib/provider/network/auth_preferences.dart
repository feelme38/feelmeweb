import 'package:injectable/injectable.dart';
import 'package:feelmeweb/provider/network/preference_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class AuthPreferences {
  AuthPreferences();

  late SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  // Сохранение токена
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(PreferenceName.token, token);
  }

  // Получение токена
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(PreferenceName.token);
  }

  // Удаление токена
  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(PreferenceName.token);
  }
}
