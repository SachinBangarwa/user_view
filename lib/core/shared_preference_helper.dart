import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_view/core/app_strings.dart';

class SharedPreferenceHelper {
  static String savedUsersKey = AppStrings.savedUsersKey;

  static Future<void> saveUser(List user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(savedUsersKey, jsonEncode(user));
  }
  static Future<String?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
   return  prefs.getString(savedUsersKey,);
  }
}
