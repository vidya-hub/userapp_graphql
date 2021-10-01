import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static Future saveUserData(userToken) async {
    final prefs = await SharedPreferences.getInstance();
    String user = userToken;
    prefs.setString('userData', user);
  }

  static Future getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String user = prefs.getString('userData');

    if (user == null) {
      return null;
    }
    return user;
  }
}
