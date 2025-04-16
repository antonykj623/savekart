import 'package:shared_preferences/shared_preferences.dart';

class AppStorage{

  static const String token = 'token';
  static const String userMap = 'login_user';
  static const String dashboard = 'dashboard';
  static const String id = 'userid';
  static const String walletpoint="walletPoints";
  static const String current_wallet_point="Current_wwaalet_points";

  static SaveToken(String key,String data)
  async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(key, data);
  }

  static Future<String?> getString(String key)
  async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

  String? a=  await prefs.getString(key);

  return a;

  }

  static setString(String key,String data)
  async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(key, data);
  }




}